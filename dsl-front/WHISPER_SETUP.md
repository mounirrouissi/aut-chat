# Whisper AI Voice Transcription Setup

This guide explains how to set up and use the Whisper AI voice transcription feature in your DSL Diagrams application.

## Features

- **Whisper AI Transcription**: Uses OpenAI's Whisper model for high-quality speech-to-text
- **Client-side Processing**: All transcription happens in the browser using @xenova/transformers
- **Real-time Audio Recording**: Records audio using MediaRecorder API
- **Progress Tracking**: Shows initialization and transcription progress
- **Seamless Integration**: Works with your existing chat backend
- **Cross-browser Support**: Works on Chrome, Firefox, Edge, and Safari

## Installation

1. **Dependencies**: The voice transcription uses @xenova/transformers for Whisper AI.

2. **Install Dependencies**:
   ```bash
   npm install
   ```

3. **Build the Application**:
   ```bash
   npm run build
   ```

## Usage

### In the Chat Interface

1. **Quick Voice Input** (Browser Speech Recognition):
   - Click the 🎤 button for instant voice input
   - Uses browser's built-in speech recognition
   - Fast and works immediately

2. **Advanced Voice Recorder** (Whisper AI):
   - Click the 🎙️ button to open the Whisper voice recorder
   - Uses OpenAI's Whisper model for high-quality transcription
   - Records audio and processes it with AI

### Whisper Voice Recorder Features

- **AI-Powered Transcription**: Uses Whisper AI for accurate speech-to-text
- **Audio Recording**: Records high-quality audio using MediaRecorder API
- **Progress Tracking**: Shows initialization and transcription progress
- **Auto-send**: Automatically sends transcribed text to your chat backend
- **Error Handling**: Graceful fallback if transcription fails
- **Model Caching**: Whisper model is cached after first download

## Technical Details

### Components

- **`VoiceRecorder.jsx`**: Main Whisper voice recording interface
- **`Transcribing.jsx`**: Loading animation during transcription
- **`whisperService.js`**: Service for managing Whisper AI transcription
- **`@xenova/transformers`**: JavaScript library for running Whisper in the browser

### API Integration

- **Client-side Processing**: All transcription happens in the browser
- **No Backend Endpoint Required**: Whisper runs entirely on the client
- **Auto-send**: Transcribed text is automatically sent to your chat backend

### Configuration

The Whisper model used is `Xenova/whisper-tiny.en` for optimal performance and size balance.

## Browser Compatibility

- **Chrome/Edge**: Full support
- **Firefox**: Full support
- **Safari**: Limited support (Web Workers may have restrictions)
- **Mobile**: Supported on modern mobile browsers

## Performance Considerations

- **Model Download**: First use downloads ~39MB Whisper model
- **Memory Usage**: ~100-200MB RAM during transcription
- **Processing Time**: 2-5 seconds for typical voice messages
- **Caching**: Model is cached after first download
- **Audio Quality**: Records at 44.1kHz for optimal transcription quality

## Troubleshooting

### Common Issues

1. **Model Download Fails**:
   - Check internet connection
   - Ensure sufficient disk space
   - Try refreshing the page
   - Check browser console for detailed error messages

2. **Microphone Access Denied**:
   - Grant microphone permissions in browser
   - Check browser settings
   - Try a different browser
   - Ensure HTTPS in production

3. **Transcription Errors**:
   - Ensure clear audio input
   - Check microphone quality
   - Try shorter recordings
   - Check browser console for error details

4. **Initialization Issues**:
   - Wait for "Initializing Whisper AI..." to complete
   - Check internet connection during model download
   - Try refreshing the page if stuck

### Debug Mode

Enable debug logging by opening browser console and looking for:
- Whisper service initialization messages
- Transcription progress updates
- Error messages and stack traces

## Customization

### Changing Whisper Model

Edit `src/services/whisperService.js`:
```javascript
this.modelName = 'Xenova/whisper-base.en'; // Larger, more accurate
// or
this.modelName = 'Xenova/whisper-small.en'; // Balanced option
```

### Styling

Modify `VoiceRecorder.css` to customize:
- Recording button appearance
- Loading animations
- Transcription result display
- Error message styling

### Backend Integration

The transcribed text is automatically sent to your chat backend through the existing message flow. No special backend endpoints are required.

## Security Considerations

- **Client-side Processing**: Audio is processed locally, not sent to external servers
- **Privacy**: No audio data is transmitted, only transcribed text
- **HTTPS Required**: Web Workers require secure context in production
- **CORS**: Ensure backend allows requests from your frontend domain

## Future Enhancements

Potential improvements:
- Multiple language support
- Custom model training
- Voice activity detection
- Audio preprocessing
- Batch transcription
- Offline mode support
