import React, { useState, useRef, useEffect } from 'react';
import Transcribing from './Transcribing';
import whisperService from '../../services/whisperService';
import './VoiceRecorder.css';

const VoiceRecorder = ({ onTranscriptionComplete, onError, disabled = false }) => {
    const [isRecording, setIsRecording] = useState(false);
    const [isTranscribing, setIsTranscribing] = useState(false);
    const [transcriptionText, setTranscriptionText] = useState('');
    const [error, setError] = useState(null);
    const [isInitializing, setIsInitializing] = useState(false);
    const [progress, setProgress] = useState(0);

    const mediaRecorderRef = useRef(null);
    const audioChunksRef = useRef([]);
    const streamRef = useRef(null);

    useEffect(() => {
        // Initialize Whisper service
        const initializeWhisper = async () => {
            try {
                setIsInitializing(true);
                setProgress(10);
                await whisperService.initialize();
                setProgress(100);
                setIsInitializing(false);
            } catch (error) {
                console.error('Failed to initialize Whisper:', error);
                setError('Failed to initialize Whisper AI. Please check your internet connection and try again.');
                setIsInitializing(false);
            }
        };

        initializeWhisper();

        return () => {
            // Cleanup
            if (streamRef.current) {
                streamRef.current.getTracks().forEach(track => track.stop());
            }
            if (mediaRecorderRef.current && mediaRecorderRef.current.state === 'recording') {
                mediaRecorderRef.current.stop();
            }
        };
    }, []);

    const startRecording = async () => {
        try {
            setError(null);
            setTranscriptionText('');

            if (isRecording) {
                return;
            }

            // Get microphone access
            const stream = await navigator.mediaDevices.getUserMedia({ 
                audio: {
                    echoCancellation: true,
                    noiseSuppression: true,
                    sampleRate: 44100
                } 
            });

            streamRef.current = stream;

            // Create MediaRecorder
            const mediaRecorder = new MediaRecorder(stream, {
                mimeType: 'audio/webm;codecs=opus'
            });

            mediaRecorderRef.current = mediaRecorder;
            audioChunksRef.current = [];

            mediaRecorder.ondataavailable = (event) => {
                if (event.data.size > 0) {
                    audioChunksRef.current.push(event.data);
                }
            };

            mediaRecorder.onstop = async () => {
                try {
                    setIsTranscribing(true);
                    setProgress(0);
                    
                    // Create audio blob
                    const audioBlob = new Blob(audioChunksRef.current, { type: 'audio/webm' });
                    
                    // Transcribe with Whisper
                    setProgress(50);
                    const transcribedText = await whisperService.transcribeAudio(audioBlob);
                    
                    setProgress(100);
                    setTranscriptionText(transcribedText);
                    setIsTranscribing(false);
                    
                    // Auto-send the transcription
                    if (transcribedText.trim()) {
                        onTranscriptionComplete?.(transcribedText);
                    }
                } catch (transcriptionError) {
                    console.error('Transcription failed:', transcriptionError);
                    setError('Transcription failed. Please try again.');
                    setIsTranscribing(false);
                }
            };

            mediaRecorder.onerror = (error) => {
                console.error('MediaRecorder error:', error);
                setError('Recording failed. Please try again.');
                setIsRecording(false);
                setIsTranscribing(false);
            };

            // Start recording
            mediaRecorder.start();
            setIsRecording(true);

        } catch (error) {
            console.error('Failed to start recording:', error);
            setError('Failed to access microphone. Please check permissions and try again.');
            setIsRecording(false);
            setIsTranscribing(false);
            onError?.(error);
        }
    };

    const stopRecording = () => {
        if (mediaRecorderRef.current && isRecording) {
            mediaRecorderRef.current.stop();
            setIsRecording(false);
            
            // Stop all tracks
            if (streamRef.current) {
                streamRef.current.getTracks().forEach(track => track.stop());
            }
        }
    };

    const cancelRecording = () => {
        stopRecording();
        setTranscriptionText('');
        setError(null);
        setIsTranscribing(false);
    };

    // Show initializing UI when loading Whisper
    if (isInitializing) {
        return (
            <div className="voice-recorder-container">
                <Transcribing 
                    downloading={true} 
                    progress={progress}
                />
                <div className="initialization-message">
                    <p>Initializing Whisper AI...</p>
                    <p>This may take a moment on first use.</p>
                </div>
            </div>
        );
    }

    // Show transcribing UI when processing
    if (isTranscribing) {
        return (
            <div className="voice-recorder-container">
                <Transcribing 
                    downloading={false} 
                    progress={progress}
                />
                <div className="transcription-preview">
                    <p>Transcribing your audio with Whisper AI...</p>
                    {transcriptionText && (
                        <div className="final-text">
                            <strong>Transcribed:</strong> {transcriptionText}
                        </div>
                    )}
                </div>
            </div>
        );
    }

    return (
        <div className="voice-recorder-container">
            {error && (
                <div className="error-message">
                    <div className="error-text">{error}</div>
                    <div className="error-actions">
                        <button 
                            onClick={() => {
                                setError(null);
                                startRecording();
                            }}
                            className="retry-button"
                        >
                            🔄 Try Again
                        </button>
                        <button 
                            onClick={() => setError(null)}
                            className="dismiss-button"
                        >
                            ✕ Dismiss
                        </button>
                    </div>
                </div>
            )}
            
            <div className="recording-controls">
                <button
                    onClick={isRecording ? stopRecording : startRecording}
                    disabled={disabled}
                    className={`record-button ${isRecording ? 'recording' : ''}`}
                >
                    {isRecording ? (
                        <>
                            <span className="recording-indicator"></span>
                            Stop Recording
                        </>
                    ) : (
                        <>
                            🎤 Start Recording
                        </>
                    )}
                </button>
            </div>

            {isRecording && (
                <div className="recording-status">
                    <div className="recording-animation">
                        <div className="pulse"></div>
                    </div>
                    <p>Recording audio for Whisper AI transcription...</p>
                    <p>Click "Stop Recording" when you're finished speaking</p>
                </div>
            )}

            {transcriptionText && !isTranscribing && (
                <div className="transcription-result">
                    <h4>Transcription Result:</h4>
                    <p>{transcriptionText}</p>
                    <div className="result-actions">
                        <button 
                            onClick={() => onTranscriptionComplete?.(transcriptionText)}
                            className="use-transcription-button"
                        >
                            Use This Text
                        </button>
                        <button 
                            onClick={() => setTranscriptionText('')}
                            className="clear-button"
                        >
                            Clear
                        </button>
                    </div>
                </div>
            )}
        </div>
    );
};

export default VoiceRecorder;
