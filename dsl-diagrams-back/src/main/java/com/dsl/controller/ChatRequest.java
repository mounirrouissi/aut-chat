package com.dsl.controller;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ChatRequest {
    private String message;
    private String sessionId;
    private UserContext context;
    private boolean debugMode = false;
}