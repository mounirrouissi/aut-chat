package com.dsl.controller;

import com.dsl.service.EnhancedNLPService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/chat")
@CrossOrigin(origins = "http://localhost:5173")
public class ChatController {

    @Autowired
    private ChatService chatService;
    
    @Autowired
    private NLPService nlpService;
    
    @Autowired(required = false)
    private EnhancedNLPService enhancedNLPService;

    @PostMapping("/send")
    public ResponseEntity<ChatMessageResponse> sendMessage(@RequestBody ChatMessageRequest request) {
        try {
            // Process the message through NLP (use enhanced if available)
            NLPResult nlpResult = enhancedNLPService != null ? 
                enhancedNLPService.processMessage(request.getMessage(), request.getContext()) :
                nlpService.processMessage(request.getMessage(), request.getContext());
            
            // Generate response based on intent and context
            ChatMessageResponse response = chatService.generateResponse(
                request.getSessionId(),
                request.getMessage(),
                nlpResult,
                request.getContext()
            );
            
            // Save the conversation
            chatService.saveMessage(request.getSessionId(), request.getMessage(), "user", nlpResult.getIntent());
            chatService.saveMessage(request.getSessionId(), response.getMessage(), "bot", response.getIntent());
            
            return ResponseEntity.ok(response);
            
        } catch (Exception e) {
            // Return error response
            ChatMessageResponse errorResponse = new ChatMessageResponse(
                "I'm sorry, I'm having trouble understanding. Could you please try again?",
                "error",
                request.getContext(),
                null
            );
            return ResponseEntity.ok(errorResponse);
        }
    }

    @GetMapping("/history/{sessionId}")
    public ResponseEntity<List<ChatMessage>> getChatHistory(@PathVariable String sessionId) {
        try {
            List<ChatMessage> history = chatService.getChatHistory(sessionId);
            return ResponseEntity.ok(history);
        } catch (Exception e) {
            return ResponseEntity.notFound().build();
        }
    }

    @PutMapping("/context")
    public ResponseEntity<UserContext> updateContext(@RequestBody ContextUpdateRequest request) {
        try {
            UserContext updatedContext = chatService.updateContext(request.getSessionId(), request.getContext());
            return ResponseEntity.ok(updatedContext);
        } catch (Exception e) {
            return ResponseEntity.badRequest().build();
        }
    }

    @PostMapping("/analyze")
    public ResponseEntity<NLPResult> analyzeMessage(@RequestBody AnalyzeMessageRequest request) {
        try {
            // Use enhanced NLP if available
            NLPResult result = enhancedNLPService != null ? 
                enhancedNLPService.processMessage(request.getMessage(), request.getContext()) :
                nlpService.processMessage(request.getMessage(), request.getContext());
            return ResponseEntity.ok(result);
        } catch (Exception e) {
            return ResponseEntity.status(500).build();
        }
    }
    
    @GetMapping("/nlp-status")
    public ResponseEntity<Map<String, Object>> getNLPStatus() {
        Map<String, Object> status = new HashMap<>();
        status.put("basicNLPAvailable", true);
        status.put("enhancedNLPAvailable", enhancedNLPService != null);
        
        if (enhancedNLPService != null) {
            status.putAll(enhancedNLPService.getSystemStatus());
        }
        
        return ResponseEntity.ok(status);
    }
    
    @PostMapping("/test-stanford")
    public ResponseEntity<Map<String, Object>> testStanford(@RequestBody Map<String, String> request) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            String testMessage = request.getOrDefault("message", "Hello, my name is John Smith and I drive a 2020 Honda Civic. I'm very unhappy with the service!");
            
            // Test basic NLP
            NLPResult basicResult = nlpService.processMessage(testMessage, new UserContext());
            response.put("basicNLP", basicResult);
            
            // Test enhanced NLP if available
            if (enhancedNLPService != null) {
                NLPResult enhancedResult = enhancedNLPService.processMessage(testMessage, new UserContext());
                response.put("enhancedNLP", enhancedResult);
            }
            
            response.put("success", true);
            response.put("testMessage", testMessage);
            
        } catch (Exception e) {
            response.put("success", false);
            response.put("error", e.getMessage());
            e.printStackTrace();
        }
        
        return ResponseEntity.ok(response);
    }

    @GetMapping("/health")
    public ResponseEntity<String> healthCheck() {
        return ResponseEntity.ok("Chat service is running");
    }
}

// Additional DTO for context updates
class ContextUpdateRequest {
    private String sessionId;
    private UserContext context;
    
    public ContextUpdateRequest() {}
    
    // Getters and setters
    public String getSessionId() { return sessionId; }
    public void setSessionId(String sessionId) { this.sessionId = sessionId; }
    
    public UserContext getContext() { return context; }
    public void setContext(UserContext context) { this.context = context; }
}

// Additional DTO for message analysis
class AnalyzeMessageRequest {
    private String message;
    private UserContext context;
    
    public AnalyzeMessageRequest() {}
    
    // Getters and setters
    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }
    
    public UserContext getContext() { return context; }
    public void setContext(UserContext context) { this.context = context; }
}

// Chat message entity for history
class ChatMessage {
    private Long id;
    private String sessionId;
    private String message;
    private String sender;
    private String intent;
    private String timestamp;
    
    public ChatMessage() {}
    
    public ChatMessage(String sessionId, String message, String sender, String intent) {
        this.sessionId = sessionId;
        this.message = message;
        this.sender = sender;
        this.intent = intent;
        this.timestamp = java.time.Instant.now().toString();
    }
    
    // Getters and setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public String getSessionId() { return sessionId; }
    public void setSessionId(String sessionId) { this.sessionId = sessionId; }
    
    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }
    
    public String getSender() { return sender; }
    public void setSender(String sender) { this.sender = sender; }
    
    public String getIntent() { return intent; }
    public void setIntent(String intent) { this.intent = intent; }
    
    public String getTimestamp() { return timestamp; }
    public void setTimestamp(String timestamp) { this.timestamp = timestamp; }
}