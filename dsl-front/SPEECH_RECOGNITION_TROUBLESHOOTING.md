# Speech Recognition Troubleshooting Guide

## Common Issues and Solutions

### 1. "Network Error" - Most Common Issue

**Error**: `Speech recognition error: network`

**Causes**:
- Browser can't connect to Google's speech recognition servers
- Internet connection issues
- Firewall blocking speech recognition service
- Browser security settings
- HTTPS requirement not met

**Solutions**:

#### Option A: Check Internet Connection
1. Ensure you have a stable internet connection
2. Try accessing other websites to verify connectivity
3. Check if your firewall is blocking the connection

#### Option B: Browser Settings
1. **Chrome**: Go to Settings → Privacy and Security → Site Settings → Microphone
2. **Firefox**: Go to about:preferences#privacy → Permissions → Microphone
3. **Edge**: Go to Settings → Site permissions → Microphone

#### Option C: HTTPS Requirement
- Speech recognition requires HTTPS in production
- For local development, use `http://localhost` (should work)
- For production, ensure your site uses HTTPS

#### Option D: Try Different Browser
- Chrome: Usually works best
- Firefox: Good support
- Edge: Good support
- Safari: Limited support

### 2. "Not Allowed" Error

**Error**: `Microphone access denied`

**Solution**:
1. Click the microphone icon in the browser address bar
2. Select "Allow" for microphone access
3. Refresh the page and try again

### 3. "No Speech" Error

**Error**: `No speech detected`

**Solutions**:
1. Speak louder and closer to the microphone
2. Check microphone volume levels
3. Ensure microphone is not muted
4. Try a different microphone if available

### 4. "Audio Capture" Error

**Error**: `Microphone not found`

**Solutions**:
1. Check if microphone is connected
2. Check system audio settings
3. Try a different microphone
4. Restart the browser

## Browser-Specific Solutions

### Chrome
1. Go to `chrome://settings/content/microphone`
2. Ensure the site is allowed
3. Check if "Ask before accessing" is enabled

### Firefox
1. Go to `about:preferences#privacy`
2. Scroll to "Permissions" → "Microphone"
3. Click "Settings" and allow the site

### Edge
1. Go to Settings → Site permissions → Microphone
2. Add your site to the allowed list
3. Ensure microphone access is enabled

## Development Environment

### Local Development
- Use `http://localhost:5173` (should work without HTTPS)
- Ensure microphone permissions are granted
- Check browser console for additional error details

### Production Environment
- **MUST** use HTTPS for speech recognition to work
- Ensure SSL certificate is valid
- Check that speech recognition services are not blocked

## Alternative Solutions

### If Speech Recognition Still Doesn't Work

1. **Use the Quick Voice Input** (🎤 button):
   - This uses a simpler speech recognition approach
   - May work when the advanced recorder doesn't

2. **Manual Text Input**:
   - Type your message directly in the chat input
   - This always works as a fallback

3. **Browser Compatibility**:
   - Try Chrome (best support)
   - Avoid Safari if possible
   - Update your browser to the latest version

## Testing Steps

1. **Check Browser Console**:
   - Open Developer Tools (F12)
   - Look for error messages in the Console tab
   - Check Network tab for failed requests

2. **Test Microphone**:
   - Go to any online microphone test
   - Verify your microphone is working
   - Check audio levels

3. **Test Speech Recognition**:
   - Try Google's speech recognition demo
   - Visit: https://www.google.com/intl/en/chrome/demos/speech.html
   - If this doesn't work, the issue is with your setup

## Quick Fixes to Try

1. **Refresh the page** and try again
2. **Clear browser cache** and cookies
3. **Restart the browser**
4. **Check system audio settings**
5. **Try incognito/private mode**
6. **Disable browser extensions** temporarily
7. **Update browser** to latest version

## Still Having Issues?

If none of the above solutions work:

1. Check the browser console for detailed error messages
2. Try a different device or computer
3. Contact your IT department if on a corporate network
4. Consider using the text input as an alternative

The speech recognition feature is a browser-dependent service, so some issues may be outside of the application's control.
