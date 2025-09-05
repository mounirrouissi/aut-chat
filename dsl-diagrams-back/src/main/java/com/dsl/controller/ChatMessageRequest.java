package com.dsl.controller;// DTO Classes for Chat API

import java.util.List;
import java.util.Map;

// Request/Response DTOs
public class ChatMessageRequest {
    private String sessionId;
    private String message;
    private UserContext context;
    private String timestamp;
    
    // Constructors, getters, setters
    public ChatMessageRequest() {}
    
    public ChatMessageRequest(String sessionId, String message, UserContext context, String timestamp) {
        this.sessionId = sessionId;
        this.message = message;
        this.context = context;
        this.timestamp = timestamp;
    }
    
    // Getters and setters
    public String getSessionId() { return sessionId; }
    public void setSessionId(String sessionId) { this.sessionId = sessionId; }
    
    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }
    
    public UserContext getContext() { return context; }
    public void setContext(UserContext context) { this.context = context; }
    
    public String getTimestamp() { return timestamp; }
    public void setTimestamp(String timestamp) { this.timestamp = timestamp; }
}



// Context and Entity Classes





// NLP Result Classes
