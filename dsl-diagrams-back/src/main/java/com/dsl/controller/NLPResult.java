package com.dsl.controller;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Map;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class NLPResult {
    private String intent;
    private Map<String, String> entities;
    private double confidence;
    private String sentiment;
    private Map<String, Double> intentConfidences;
    private boolean requiresHumanHandoff;
    private String suggestedResponse;
    private String processingMethod; // "rule-based", "hybrid", "rule-based-fallback"
}