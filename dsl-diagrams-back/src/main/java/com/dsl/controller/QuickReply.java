package com.dsl.controller;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class QuickReply {
    private String text;
    private String payload;
    private String type = "text";

    public QuickReply(String text, String payload) {
        this.text = text;
        this.payload = payload;
    }

    public QuickReply(String text) {
        this.text = text;
        this.payload = text.toLowerCase().replace(" ", "_");
    }
}