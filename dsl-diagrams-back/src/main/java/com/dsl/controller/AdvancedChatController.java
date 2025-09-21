package com.dsl.controller;

import com.dsl.service.DatabaseChatService;
import com.dsl.service.EnhancedNLPService;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("/api/v2/chat")
@CrossOrigin(origins = "*")
@AllArgsConstructor
public class AdvancedChatController {

    private final EnhancedNLPService enhancedNLPService;
    private final DatabaseChatService chatService;

    @PostMapping("/message")
    public ResponseEntity<Map<String, Object>> processMessage(@RequestBody ChatRequest request) {
        try {
            // Add a 3-second delay to simulate human-like response time
            Thread.sleep(3000);

            // Generate session ID if not provided
            String sessionId = request.getSessionId() != null ? request.getSessionId() : UUID.randomUUID().toString();

            // Initialize or update context
            UserContext context = request.getContext() != null ? request.getContext() : new UserContext();
            context.setLastInteraction(LocalDateTime.now());
            context.setMessageCount(context.getMessageCount() + 1);

            // Process message and generate response using enhanced NLP and chat service
            ChatMessageResponse response = chatService.processMessage(sessionId, request.getMessage(), context);

            // Get the NLP result for additional response data
            NLPResult nlpResult = enhancedNLPService.processMessage(request.getMessage(), context);

            // Prepare enhanced response
            Map<String, Object> responseMap = new HashMap<>();
            responseMap.put("message", response.getMessage());
            responseMap.put("sessionId", sessionId);
            responseMap.put("intent", nlpResult.getIntent());
            responseMap.put("confidence", nlpResult.getConfidence());
            responseMap.put("sentiment", nlpResult.getSentiment());
            responseMap.put("entities", nlpResult.getEntities());
            responseMap.put("quickReplies", response.getQuickReplies());
            responseMap.put("requiresHumanHandoff", nlpResult.isRequiresHumanHandoff());
            responseMap.put("context", response.getContext());
            responseMap.put("timestamp", LocalDateTime.now());

            // Add debug information if requested
            if (request.isDebugMode()) {
                responseMap.put("debug", createDebugInfo(nlpResult, request.getMessage()));
            }

            return ResponseEntity.ok(responseMap);

        } catch (Exception e) {
            Map<String, Object> errorResponse = new HashMap<>();
            errorResponse.put("error", "Failed to process message");
            errorResponse.put("message", "I'm sorry, I encountered an error. Please try again or contact support.");
            errorResponse.put("timestamp", LocalDateTime.now());
            return ResponseEntity.status(500).body(errorResponse);
        }
    }

    @GetMapping("/history/{sessionId}")
    public ResponseEntity<Map<String, Object>> getChatHistory(@PathVariable String sessionId) {
        try {
            var history = chatService.getChatHistory(sessionId);
            Map<String, Object> response = new HashMap<>();
            response.put("sessionId", sessionId);
            response.put("messages", history);
            response.put("messageCount", history.size());
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            return ResponseEntity.status(500).body(Map.of("error", "Failed to retrieve chat history"));
        }
    }

    @PostMapping("/analyze")
    public ResponseEntity<Map<String, Object>> analyzeMessage(@RequestBody AnalyzeRequest request) {
        try {
            NLPResult result = enhancedNLPService.processMessage(request.getMessage(), request.getContext());

            Map<String, Object> analysis = new HashMap<>();
            analysis.put("intent", result.getIntent());
            analysis.put("confidence", result.getConfidence());
            analysis.put("sentiment", result.getSentiment());
            analysis.put("entities", result.getEntities());
            analysis.put("intentConfidences", result.getIntentConfidences());
            analysis.put("requiresHumanHandoff", result.isRequiresHumanHandoff());
            analysis.put("suggestedResponse", result.getSuggestedResponse());

            return ResponseEntity.ok(analysis);
        } catch (Exception e) {
            return ResponseEntity.status(500).body(Map.of("error", "Failed to analyze message"));
        }
    }

    @PostMapping("/feedback")
    public ResponseEntity<Map<String, Object>> submitFeedback(@RequestBody FeedbackRequest request) {
        // This would typically save feedback to improve the NLP model
        Map<String, Object> response = new HashMap<>();
        response.put("status", "received");
        response.put("message", "Thank you for your feedback!");
        return ResponseEntity.ok(response);
    }

    @GetMapping("/status")
    public ResponseEntity<Map<String, Object>> getSystemStatus() {
        try {
            Map<String, Object> status = enhancedNLPService.getSystemStatus();
            status.put("timestamp", LocalDateTime.now());
            status.put("version", "2.0");
            return ResponseEntity.ok(status);
        } catch (Exception e) {
            return ResponseEntity.status(500).body(Map.of("error", "Failed to get system status"));
        }
    }

    private Map<String, Object> createDebugInfo(NLPResult nlpResult, String originalMessage) {
        Map<String, Object> debug = new HashMap<>();
        debug.put("originalMessage", originalMessage);
        debug.put("intentConfidences", nlpResult.getIntentConfidences());
        debug.put("extractedEntities", nlpResult.getEntities());
        debug.put("sentiment", nlpResult.getSentiment());
        debug.put("confidence", nlpResult.getConfidence());
        debug.put("suggestedResponse", nlpResult.getSuggestedResponse());
        return debug;
    }
}
