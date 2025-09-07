// src/services/assemblyAITranscriptionService.js

// Assuming your backend is running on localhost:8080
const BACKEND_TRANSCRIPTION_URL = "http://localhost:8080/api/transcribe-audio";

class AssemblyAITranscriptionService {
    constructor() {
        // No complex initialization needed for client-side here,
        // as the heavy lifting is done by the backend and AssemblyAI.
    }

    async transcribeAudio(audioBlob) {
        console.log("Sending audio to backend for AssemblyAI transcription...");

        try {
            const formData = new FormData();
            formData.append("audio", audioBlob, "audio.webm"); // 'audio' is the field name the backend will expect

            const response = await fetch(BACKEND_TRANSCRIPTION_URL, {
                method: "POST",
                body: formData,
                // No 'Content-Type' header needed for FormData, browser sets it automatically
            });

            if (!response.ok) {
                const errorText = await response.text();
                throw new Error(`Backend transcription failed: ${response.status} - ${errorText}`);
            }

            const result = await response.json();
            console.log("AssemblyAI transcription result:", result);

            // Assuming the backend returns an object with a 'text' field
            return result.text;

        } catch (error) {
            console.error("Error during AssemblyAI transcription:", error);
            throw error;
        }
    }

    // Keep recordAudio and recordAudioWithStop as they are for recording audio
    // on the client-side, which is still needed.
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

const assemblyAITranscriptionService = new AssemblyAITranscriptionService();

export default assemblyAITranscriptionService;
