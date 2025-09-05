package com.dsl.controller;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ChatMessageResponse {
    private String message;
    private String intent;
    private UserContext context;
    private List<QuickReply> quickReplies;
    private boolean requiresHumanHandoff;
    private String sentiment;

    public ChatMessageResponse(String s, String error, UserContext context,         List<QuickReply> quickReplies
) {
        this.message = s;
        this.intent = error;
        this.context = context;
        this.quickReplies = quickReplies != null ? quickReplies : new ArrayList<>();
        this.requiresHumanHandoff = false;
        this.sentiment = null;
    }
}