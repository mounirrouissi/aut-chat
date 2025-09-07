///*
//package com.dsl.controller;
//
//import com.dsl.service.DatabaseChatService;
//import lombok.AllArgsConstructor;
//import org.springframework.http.ResponseEntity;
//import org.springframework.web.bind.annotation.*;
//import com.fasterxml.jackson.databind.ObjectMapper;
//
//import java.time.LocalDateTime;
//import java.util.HashMap;
//import java.util.Map;
//import java.util.UUID;
//
//@RestController
//@RequestMapping("/api/v2/chat")
//@CrossOrigin(origins = "*")
//@AllArgsConstructor
//public class AdvancedChatControllerV3 {
//
//    private final EnhancedNLPService enhancedNLPService;
//    private final DatabaseChatService chatService;
//
//    @PostMapping("/message")
//    public ResponseEntity<Map<String, Object>> processMessage(@RequestBody ChatRequest request) {
//        try {
//            // Add a 3-second delay to simulate human-like response time
//            Thread.sleep(3000);
//
//            // Generate session ID if not provided
//            String sessionId = request.getSessionId() != null ? request.getSessionId() : UUID.randomUUID().toString();
//
//            // Initialize or update context
//            UserContext context = request.getContext() != null ? request.getContext() : new UserContext();
//            context.setLastInteraction(LocalDateTime.now());
//            context.setMessageCount(context.getMessageCount() + 1);
//
//            // Process message and generate response using enhanced NLP and chat service
//            ChatMessageResponse response = chatService.processMessage(sessionId, request.getMessage(), context);
//
//            // Get the NLP result for additional response data
//            NLPResult nlpResult = enhancedNLPService.processMessage(request.getMessage(), context);
//
//            // Prepare enhanced response
//            Map<String, Object> responseMap = new HashMap<>();
//            responseMap.put("message", response.getMessage());
//            responseMap.put("sessionId", sessionId);
//            responseMap.put("intent", nlpResult.getIntent());
//            responseMap.put("confidence", nlpResult.getConfidence());
//            responseMap.put("sentiment", nlpResult.getSentiment());
//            responseMap.put("entities", nlpResult.getEntities());
//            responseMap.put("quickReplies", response.getQuickReplies());
//            responseMap.put("requiresHumanHandoff", nlpResult.isRequiresHumanHandoff());
//            responseMap.put("context", response.getContext());
//            responseMap.put("timestamp", LocalDateTime.now());
//
//            // Add debug information if requested
//            if (request.isDebugMode()) {
//                responseMap.put("debug", createDebugInfo(nlpResult, request.getMessage()));
//            }
//
//            return ResponseEntity.ok(responseMap);
//
//        } catch (Exception e) {
//            Map<String, Object> errorResponse = new HashMap<>();
//            errorResponse.put("error", "Failed to process message");
//            errorResponse.put("message", "I'm sorry, I encountered an error. Please try again or contact support.");
//            errorResponse.put("timestamp", LocalDateTime.now());
//            return ResponseEntity.status(500).body(errorResponse);
//        }
//    }
//
//    @PostMapping("/transcribe")
//    public ResponseEntity<Map<String, Object>> transcribeAudio(@RequestBody byte[] audioBytes,
//                                                               @RequestParam String sessionId,
//                                                               @RequestParam(required = false) String contextJson) {
//        try {
//            // Add a 3-second delay to simulate human-like response time
//            Thread.sleep(3000); // Keep the delay for consistency
//
//            // Transcribe audio
////            String transcribedText = huggingFaceSTTService.transcribeAudio(audioBytes).block(); // Blocking for simplicity
////
//            // Deserialize contextJson to UserContext
//            UserContext context = new UserContext(); // Default empty context
//            if (contextJson != null && !contextJson.isEmpty()) {
//                ObjectMapper mapper = new ObjectMapper();
//                context = mapper.readValue(contextJson, UserContext.class);
//            }
//
//            // Generate session ID if not provided (should be provided from frontend)
//            if (sessionId == null || sessionId.isEmpty()) {
//                sessionId = UUID.randomUUID().toString();
//            }
//
//            // Initialize or update context
//            context.setLastInteraction(LocalDateTime.now());
//            context.setMessageCount(context.getMessageCount() + 1);
//
//            // Process transcribed text as a regular message
//            ChatRequest chatRequest = new ChatRequest();
//            chatRequest.setSessionId(sessionId);
//            chatRequest.setMessage(transcribedText);
//            chatRequest.setContext(context);
//            chatRequest.setDebugMode(false); // Assuming debug mode is not enabled for voice input by default
//
//            return processMessage(chatRequest); // Reuse existing message processing logic
//
//        } catch (Exception e) {
//            Map<String, Object> errorResponse = new HashMap<>();
//            errorResponse.put("error", "Failed to transcribe audio or process message");
//            errorResponse.put("message", "I'm sorry, I encountered an error during voice processing. Please try again.");
//            errorResponse.put("timestamp", LocalDateTime.now());
//            return ResponseEntity.status(500).body(errorResponse);
//        }
//    }
//
//    @PostMapping("/whisper-transcribe")
//    public ResponseEntity<Map<String, Object>> processWhisperTranscription(@RequestBody Map<String, Object> request) {
//        try {
//            String transcribedText = (String) request.get("transcribedText");
//            String sessionId = (String) request.get("sessionId");
//            Map<String, Object> contextData = (Map<String, Object>) request.get("context");
//
//            if (transcribedText == null || transcribedText.trim().isEmpty()) {
//                Map<String, Object> errorResponse = new HashMap<>();
//                errorResponse.put("error", "No transcribed text provided");
//                errorResponse.put("message", "I didn't receive any transcribed text. Please try again.");
//                return ResponseEntity.badRequest().body(errorResponse);
//            }
//
//            // Generate session ID if not provided
//            if (sessionId == null || sessionId.isEmpty()) {
//                sessionId = UUID.randomUUID().toString();
//            }
//
//            // Convert context data to UserContext
//            UserContext context = new UserContext();
//            if (contextData != null) {
//                if (contextData.containsKey("customerName")) {
//                    context.setCustomerName((String) contextData.get("customerName"));
//                }
//                if (contextData.containsKey("conversationState")) {
//                    context.setConversationState((String) contextData.get("conversationState"));
//                }
//                if (contextData.containsKey("currentService")) {
//                    context.setCurrentService((String) contextData.get("currentService"));
//                }
//                if (contextData.containsKey("emergencyMode")) {
//                    context.setEmergencyMode((Boolean) contextData.get("emergencyMode"));
//                }
//            }
//
//            // Initialize or update context
//            context.setLastInteraction(LocalDateTime.now());
//            context.setMessageCount(context.getMessageCount() + 1);
//
//            // Process transcribed text as a regular message
//            ChatRequest chatRequest = new ChatRequest();
//            chatRequest.setSessionId(sessionId);
//            chatRequest.setMessage(transcribedText);
//            chatRequest.setContext(context);
//            chatRequest.setDebugMode(false);
//
//            return processMessage(chatRequest);
//
//        } catch (Exception e) {
//            Map<String, Object> errorResponse = new HashMap<>();
//            errorResponse.put("error", "Failed to process Whisper transcription");
//            errorResponse.put("message", "I'm sorry, I encountered an error processing your voice message. Please try again.");
//            errorResponse.put("timestamp", LocalDateTime.now());
//            return ResponseEntity.status(500).body(errorResponse);
//        }
//    }
//
//    @GetMapping("/history/{sessionId}")
//    public ResponseEntity<Map<String, Object>> getChatHistory(@PathVariable String sessionId) {
//        try {
//            var history = chatService.getChatHistory(sessionId);
//            Map<String, Object> response = new HashMap<>();
//            response.put("sessionId", sessionId);
//            response.put("messages", history);
//            response.put("messageCount", history.size());
//            return ResponseEntity.ok(response);
//        } catch (Exception e) {
//            return ResponseEntity.status(500).body(Map.of("error", "Failed to retrieve chat history"));
//        }
//    }
//
//    @PostMapping("/analyze")
//    public ResponseEntity<Map<String, Object>> analyzeMessage(@RequestBody AnalyzeRequest request) {
//        try {
//            NLPResult result = enhancedNLPService.processMessage(request.getMessage(), request.getContext());
//
//            Map<String, Object> analysis = new HashMap<>();
//            analysis.put("intent", result.getIntent());
//            analysis.put("confidence", result.getConfidence());
//            analysis.put("sentiment", result.getSentiment());
//            analysis.put("entities", result.getEntities());
//            analysis.put("intentConfidences", result.getIntentConfidences());
//            analysis.put("requiresHumanHandoff", result.isRequiresHumanHandoff());
//            analysis.put("suggestedResponse", result.getSuggestedResponse());
//
//            return ResponseEntity.ok(analysis);
//        } catch (Exception e) {
//            return ResponseEntity.status(500).body(Map.of("error", "Failed to analyze message"));
//        }
//    }
//
//    @PostMapping("/feedback")
//    public ResponseEntity<Map<String, Object>> submitFeedback(@RequestBody FeedbackRequest request) {
//        // This would typically save feedback to improve the NLP model
//        Map<String, Object> response = new HashMap<>();
//        response.put("status", "received");
//        response.put("message", "Thank you for your feedback!");
//        return ResponseEntity.ok(response);
//    }
//
//    @GetMapping("/status")
//    public ResponseEntity<Map<String, Object>> getSystemStatus() {
//        try {
//            Map<String, Object> status = enhancedNLPService.getSystemStatus();
//            status.put("timestamp", LocalDateTime.now());
//            status.put("version", "2.0");
//            return ResponseEntity.ok(status);
//        } catch (Exception e) {
//            return ResponseEntity.status(500).body(Map.of("error", "Failed to get system status"));
//        }
//    }
//
//    private Map<String, Object> createDebugInfo(NLPResult nlpResult, String originalMessage) {
//        Map<String, Object> debug = new HashMap<>();
//        debug.put("originalMessage", originalMessage);
//        debug.put("intentConfidences", nlpResult.getIntentConfidences());
//        debug.put("extractedEntities", nlpResult.getEntities());
//        debug.put("sentiment", nlpResult.getSentiment());
//        debug.put("confidence", nlpResult.getConfidence());
//        debug.put("suggestedResponse", nlpResult.getSuggestedResponse());
//        return debug;
//    }
//}
//*/
