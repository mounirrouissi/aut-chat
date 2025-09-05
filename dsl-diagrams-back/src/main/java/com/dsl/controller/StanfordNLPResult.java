
package com.dsl.controller;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Map;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class StanfordNLPResult {
    private Map<String, String> entities;
    private String sentiment;
    private Double sentimentScore; // -1.0 to 1.0
    private String intent;
    private Double intentConfidence;
    private Map<String, Double> intentConfidences;
    private Double complexityScore; // 0.0 to 1.0
    private Double overallConfidence;
    private String processingTime;
}