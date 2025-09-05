package com.dsl.controller;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class FeedbackRequest {
    private String sessionId;
    private String messageId;
    private String feedback; // "helpful", "not_helpful", "incorrect"
    private String comment;
    private int rating; // 1-5 scale
}