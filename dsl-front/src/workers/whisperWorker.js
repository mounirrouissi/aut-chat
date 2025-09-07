import { pipeline } from '@xenova/transformers';

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

class MyTranscriptionPipeline {
    static task = 'automatic-speech-recognition';
    // You can change this to a local path if you download the model files
    // For example: './models/whisper-tiny.en' if you place the model files in src/workers/models/whisper-tiny.en
    static model = 'Xenova/whisper-tiny.en';
    static instance = null;

    static async getInstance(progress_callback = null) {
        if (this.instance === null) {
            console.log('Initializing pipeline in worker...');
            // The second argument to pipeline can be null if the model is specified in the class
            // or a local path.
            this.instance = await pipeline(this.task, MyTranscriptionPipeline.model, { progress_callback });
            console.log('Pipeline initialized in worker.');
        }
        return this.instance;
    }
}

self.addEventListener('message', async (event) => {
    const { type, audio } = event.data;
    if (type === MessageTypes.INFERENCE_REQUEST) {
        try {
            await transcribe(audio);
        } catch (error) {
            console.error('Error during transcription in worker:', error);
            self.postMessage({
                type: MessageTypes.ERROR,
                message: error.message,
                stack: error.stack
            });
        }
    }
});

async function transcribe(audio) {
    sendLoadingMessage('loading');

    let pipelineInstance;

    try {
        pipelineInstance = await MyTranscriptionPipeline.getInstance(load_model_callback);
    } catch (err) {
        console.error('Failed to initialize pipeline in worker:', err);
        sendLoadingMessage('error'); // Indicate loading error
        throw err; // Re-throw to be caught by the message event listener
    }

    sendLoadingMessage('success');

    const stride_length_s = 5; // This value might need tuning

    try {
        // Assuming audio is an AudioBuffer or similar format expected by pipeline
        const result = await pipelineInstance(audio, {
            chunk_length_s: 30,
            stride_length_s: stride_length_s,
            language: 'english', // Ensure language is set if needed
            task: 'transcribe',
            return_timestamps: true, // Useful for partial results
        });

        // For simplicity, sending the full result once done.
        self.postMessage({
            type: MessageTypes.RESULT,
            results: result.text // Assuming result.text contains the full transcription
        });

    } catch (error) {
        console.error('Transcription failed in worker:', error);
        self.postMessage({
            type: MessageTypes.ERROR,
            message: error.message,
            stack: error.stack
        });
    }
}

async function load_model_callback(data) {
    const { status } = data;
    if (status === 'progress') {
        const { file, progress, loaded, total } = data;
        sendDownloadingMessage(file, progress, loaded, total);
    }
}

function sendLoadingMessage(status) {
    self.postMessage({
        type: MessageTypes.LOADING,
        status
    });
}

async function sendDownloadingMessage(file, progress, loaded, total) {
    self.postMessage({
        type: MessageTypes.DOWNLOADING,
        file,
        progress,
        loaded,
        total
    });
}