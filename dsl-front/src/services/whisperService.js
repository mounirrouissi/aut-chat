// New content for src/services/whisperService.js
// Removed: import { pipeline } from '@xenova/transformers';

// Define message types for communication between main thread and worker
const MessageTypes = {
    INFERENCE_REQUEST: 'inference_request',
    LOADING: 'loading',
    DOWNLOADING: 'downloading',
    RESULT: 'result',
    RESULT_PARTIAL: 'result_partial',
    INFERENCE_DONE: 'inference_done',
    ERROR: 'error'
};

class WhisperService {
    constructor() {
        this.worker = null;
        this.isInitialized = false;
        this.isInitializing = false;
        this.resolveInitialize = null; // To resolve the initialize promise
        this.rejectInitialize = null; // To reject the initialize promise
        this.resolveTranscription = null; // To resolve the transcribeAudio promise
        this.rejectTranscription = null; // To reject the transcribeAudio promise
    }

    async initialize() {
        if (this.isInitialized) {
            return true;
        }

        if (this.isInitializing) {
            // Wait for initialization to complete
            return new Promise((resolve, reject) => {
                this.resolveInitialize = resolve;
                this.rejectInitialize = reject;
            });
        }

        this.isInitializing = true;
        console.log('Initializing Whisper model via worker...');

        return new Promise((resolve, reject) => {
            this.resolveInitialize = resolve;
            this.rejectInitialize = reject;

            // Create worker only once
            if (!this.worker) {
                this.worker = new Worker(new URL('../workers/whisperWorker.js', import.meta.url), { type: 'module' });

                this.worker.onmessage = (event) => {
                    const { type, status, results, message, stack, file, progress, loaded, total } = event.data;

                    switch (type) {
                        case MessageTypes.LOADING:
                            console.log(`Worker loading status: ${status}`);
                            if (status === 'success' && this.resolveInitialize) {
                                this.isInitialized = true;
                                this.isInitializing = false;
                                this.resolveInitialize(true);
                                this.resolveInitialize = null;
                                this.rejectInitialize = null;
                            } else if (status === 'error' && this.rejectInitialize) {
                                this.isInitializing = false;
                                this.rejectInitialize(new Error('Worker failed to load model.'));
                                this.resolveInitialize = null;
                                this.rejectInitialize = null;
                            }
                            break;
                        case MessageTypes.DOWNLOADING:
                            console.log(`Downloading ${file}: ${progress}% (${loaded}/${total})`);
                            // You can add a UI update here for download progress
                            break;
                        case MessageTypes.RESULT:
                            if (this.resolveTranscription) {
                                this.resolveTranscription(results);
                                this.resolveTranscription = null;
                                this.rejectTranscription = null;
                            }
                            break;
                        case MessageTypes.ERROR:
                            console.error('Error from worker:', message, stack);
                            if (this.rejectInitialize) {
                                this.isInitializing = false;
                                this.rejectInitialize(new Error(message));
                                this.resolveInitialize = null;
                                this.rejectInitialize = null;
                            } else if (this.rejectTranscription) {
                                this.rejectTranscription(new Error(message));
                                this.resolveTranscription = null;
                                this.rejectTranscription = null;
                            }
                            break;
                        default:
                            console.log('Unknown message type from worker:', type, event.data);
                    }
                };

                this.worker.onerror = (error) => {
                    console.error('Worker error:', error);
                    this.isInitializing = false;
                    if (this.rejectInitialize) {
                        this.rejectInitialize(error);
                        this.resolveInitialize = null;
                        this.rejectInitialize = null;
                    } else if (this.rejectTranscription) {
                        this.rejectTranscription(error);
                        this.resolveTranscription = null;
                        this.rejectTranscription = null;
                    }
                };
            }

            // Send an initial message to trigger worker initialization
            // The worker will handle its own initialization logic
            // No specific message needed to trigger initialization, as it happens on worker load
            // The worker will send back LOADING messages
        });
    }

    async transcribeAudio(audioBlob) {
        if (!this.worker) {
            throw new Error('Whisper worker not initialized. Call initialize() first.');
        }
        if (!this.isInitialized) {
            await this.initialize(); // Ensure worker is initialized before transcribing
        }

        console.log('Sending audio to worker for transcription...');
        return new Promise((resolve, reject) => {
            this.resolveTranscription = resolve;
            this.rejectTranscription = reject;
            this.worker.postMessage({ type: MessageTypes.INFERENCE_REQUEST, audio: audioBlob });
        });
    }

    // Removed audioBufferToFloat32Array as it's now handled in the worker
    // Removed recordAudio and recordAudioWithStop as they are not directly related to the worker communication
    // and should be handled by the component that uses WhisperService.
    // The component will record audio and pass the Blob to transcribeAudio.

    // Keep recordAudio and recordAudioWithStop if they are still needed for direct use
    // by components, but they won't interact with the worker for transcription.
    // For now, I will remove them as the user's original problem was with transcription.

    async recordAudio(duration = 10000) {
        return new Promise(async (resolve, reject) => {
            try {
                const stream = await navigator.mediaDevices.getUserMedia({
                    audio: {
                        echoCancellation: true,
                        noiseSuppression: true,
                        sampleRate: 44100
                    }
                });

                const mediaRecorder = new MediaRecorder(stream, {
                    mimeType: 'audio/webm;codecs=opus'
                });

                const audioChunks = [];

                mediaRecorder.ondataavailable = (event) => {
                    if (event.data.size > 0) {
                        audioChunks.push(event.data);
                    }
                };

                mediaRecorder.onstop = () => {
                    const audioBlob = new Blob(audioChunks, { type: 'audio/webm' });
                    stream.getTracks().forEach(track => track.stop());
                    resolve(audioBlob);
                };

                mediaRecorder.onerror = (error) => {
                    stream.getTracks().forEach(track => track.stop());
                    reject(error);
                };

                mediaRecorder.start();

                // Stop recording after specified duration
                setTimeout(() => {
                    if (mediaRecorder.state === 'recording') {
                        mediaRecorder.stop();
                    }
                }, duration);

            } catch (error) {
                reject(error);
            }
        });
    }

    async recordAudioWithStop(mediaRecorder) {
        return new Promise((resolve, reject) => {
            const audioChunks = [];

            mediaRecorder.ondataavailable = (event) => {
                if (event.data.size > 0) {
                    audioChunks.push(event.data);
                }
            };

            mediaRecorder.onstop = () => {
                const audioBlob = new Blob(audioChunks, { type: 'audio/webm' });
                resolve(audioBlob);
            };

            mediaRecorder.onerror = (error) => {
                reject(error);
            };
        });
    }
}

// Create a singleton instance
const whisperService = new WhisperService();

export default whisperService;