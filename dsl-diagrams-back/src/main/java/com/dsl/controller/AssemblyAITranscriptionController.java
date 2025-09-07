package com.dsl.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.client.RestTemplate;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.TimeUnit;

@RestController
@RequestMapping("/api")
@CrossOrigin(origins = "http://localhost:5173") // Allow requests from frontend
public class AssemblyAITranscriptionController {

    // IMPORTANT: Store your API key securely, e.g., in application.properties or environment variables.
    // For demonstration purposes, it's directly here.
    private final String ASSEMBLYAI_API_KEY = "03476e45401c40b2b5d5771c17b2ed66";
    private final String ASSEMBLYAI_UPLOAD_URL = "https://api.assemblyai.com/v2/upload";
    private final String ASSEMBLYAI_TRANSCRIPT_URL = "https://api.assemblyai.com/v2/transcript";

    private final RestTemplate restTemplate = new RestTemplate();
    private final ObjectMapper objectMapper = new ObjectMapper();

    @PostMapping("/transcribe-audio")
    public ResponseEntity<Map<String, String>> transcribeAudio(@RequestParam("audio") MultipartFile audioFile) {
        try {
            // 1. Upload audio file to AssemblyAI
            String uploadUrl = uploadAudioToAssemblyAI(audioFile);
            if (uploadUrl == null) {
                return ResponseEntity.status(500).body(createErrorResponse("Failed to upload audio to AssemblyAI."));
            }

            // 2. Start transcription
            String transcriptId = startTranscription(uploadUrl);
            if (transcriptId == null) {
                return ResponseEntity.status(500).body(createErrorResponse("Failed to start transcription with AssemblyAI."));
            }

            // 3. Poll for transcription result
            String transcribedText = pollForTranscriptionResult(transcriptId);
            if (transcribedText == null) {
                return ResponseEntity.status(500).body(createErrorResponse("Transcription failed or timed out."));
            }

            Map<String, String> response = new HashMap<>();
            response.put("text", transcribedText);
            return ResponseEntity.ok(response);

        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(500).body(createErrorResponse("An error occurred during transcription: " + e.getMessage()));
        }
    }

    private String uploadAudioToAssemblyAI(MultipartFile audioFile) throws IOException {
        HttpHeaders headers = new HttpHeaders();
        headers.set("authorization", ASSEMBLYAI_API_KEY);
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM); // For raw audio upload

        HttpEntity<byte[]> requestEntity = new HttpEntity<>(audioFile.getBytes(), headers);

        ResponseEntity<String> response = restTemplate.postForEntity(ASSEMBLYAI_UPLOAD_URL, requestEntity, String.class);

        if (response.getStatusCode().is2xxSuccessful() && response.getBody() != null) {
            JsonNode root = objectMapper.readTree(response.getBody());
            return root.has("upload_url") ? root.get("upload_url").asText() : null;
        }
        return null;
    }

    private String startTranscription(String audioUrl) throws IOException {
        HttpHeaders headers = new HttpHeaders();
        headers.set("authorization", ASSEMBLYAI_API_KEY);
        headers.setContentType(MediaType.APPLICATION_JSON);

        Map<String, String> body = new HashMap<>();
        body.put("audio_url", audioUrl);
        body.put("language_code", "en"); // Specify language code

        HttpEntity<Map<String, String>> requestEntity = new HttpEntity<>(body, headers);

        ResponseEntity<String> response = restTemplate.postForEntity(ASSEMBLYAI_TRANSCRIPT_URL, requestEntity, String.class);

        if (response.getStatusCode().is2xxSuccessful() && response.getBody() != null) {
            JsonNode root = objectMapper.readTree(response.getBody());
            return root.has("id") ? root.get("id").asText() : null;
        }
        return null;
    }

    private String pollForTranscriptionResult(String transcriptId) throws InterruptedException, IOException {
        HttpHeaders headers = new HttpHeaders();
        headers.set("authorization", ASSEMBLYAI_API_KEY);

        String pollingUrl = ASSEMBLYAI_TRANSCRIPT_URL + "/" + transcriptId;

        HttpEntity<String> entity = new HttpEntity<>(headers); // Create an HttpEntity with headers

        for (int i = 0; i < 20; i++) {
            TimeUnit.SECONDS.sleep(2);

            // Use exchange with HttpEntity to include headers
            ResponseEntity<String> response = restTemplate.exchange(pollingUrl, org.springframework.http.HttpMethod.GET, entity, String.class);

            if (response.getStatusCode().is2xxSuccessful() && response.getBody() != null) {
                JsonNode root = objectMapper.readTree(response.getBody());
                String status = root.has("status") ? root.get("status").asText() : "unknown";

                if ("completed".equals(status)) {
                    return root.has("text") ? root.get("text").asText() : null;
                } else if ("failed".equals(status)) {
                    System.err.println("AssemblyAI transcription failed: " + root.toString());
                    return null;
                }
            }
        }
        return null; // Timed out
    }

    private Map<String, String> createErrorResponse(String message) {
        Map<String, String> errorResponse = new HashMap<>();
        errorResponse.put("error", message);
        return errorResponse;
    }
}
