package com.dsl.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class EnhancedNLPServiceV2 {

    private final NLPService basicNLPService;
    private final StanfordNLPService stanfordNLPService;

    @Value("${nlp.confidence-threshold:0.6}")
    private double confidenceThreshold;

    @Autowired
    public EnhancedNLPServiceV2(NLPService basicNLPService, StanfordNLPService stanfordNLPService) {
        this.basicNLPService = basicNLPService;
        this.stanfordNLPService = stanfordNLPService;
    }

    public NLPResult processMessage(String message, UserContext context) {
        // Always try basic NLP first (fast and domain-specific)
        NLPResult basicResult = basicNLPService.processMessage(message, context);

        // Always use Stanford NLP for enhancement (hybrid approach)
        try {
            NLPResult enhancedResult = enhanceWithStanfordNLP(message, basicResult, context);
            enhancedResult.setProcessingMethod("hybrid");
            return enhancedResult;
        } catch (Exception e) {
            System.err.println("Stanford NLP enhancement failed, falling back to basic result: " + e.getMessage());
            // Fallback to basic result if Stanford NLP fails
            basicResult.setProcessingMethod("rule-based-fallback");
            return basicResult;
        }
    }

    private NLPResult enhanceWithStanfordNLP(String message, NLPResult basicResult, UserContext context) {
        // Get Stanford NLP analysis
        StanfordNLPResult stanfordResult = stanfordNLPService.analyze(message);

        // Merge results intelligently
        NLPResult enhancedResult = new NLPResult();

        // Use the better intent classification
        String finalIntent = chooseBestIntent(basicResult, stanfordResult, context);
        enhancedResult.setIntent(finalIntent);

        // Merge entities (Stanford NLP often finds more)
        Map<String, String> mergedEntities = mergeEntities(basicResult.getEntities(), stanfordResult.getEntities());
        enhancedResult.setEntities(mergedEntities);

        // Use Stanford's sentiment if available, otherwise use basic
        String sentiment = stanfordResult.getSentiment() != null ?
                stanfordResult.getSentiment() : basicResult.getSentiment();
        enhancedResult.setSentiment(sentiment);

        // Calculate enhanced confidence
        double enhancedConfidence = calculateEnhancedConfidence(basicResult, stanfordResult);
        enhancedResult.setConfidence(enhancedConfidence);

        // Merge intent confidences
        Map<String, Double> mergedIntentConfidences = mergeIntentConfidences(
                basicResult.getIntentConfidences(), stanfordResult.getIntentConfidences());
        enhancedResult.setIntentConfidences(mergedIntentConfidences);

        // Enhanced human handoff detection
        boolean requiresHandoff = shouldHandoffToHuman(enhancedResult, stanfordResult, context);
        enhancedResult.setRequiresHumanHandoff(requiresHandoff);

        // Generate suggested response
        String suggestedResponse = generateEnhancedResponse(enhancedResult, context);
        enhancedResult.setSuggestedResponse(suggestedResponse);

        return enhancedResult;
    }

    private String chooseBestIntent(NLPResult basicResult, StanfordNLPResult stanfordResult, UserContext context) {
        // If basic NLP has high confidence for automotive-specific intents, prefer it
        if (basicResult.getConfidence() > 0.7 && isAutomotiveIntent(basicResult.getIntent())) {
            return basicResult.getIntent();
        }

        // If Stanford found a clear intent with high confidence, use it
        if (stanfordResult.getIntentConfidence() >= 0.7) {
            return mapStanfordIntentToOurs(stanfordResult.getIntent());
        }

        // Default to basic result
        return basicResult.getIntent();
    }

    private boolean isAutomotiveIntent(String intent) {
        return Arrays.asList("service_inquiry", "vehicle_info", "booking_request",
                "emergency", "complaint", "time_expression", "oil_assistance", "tire_assistance").contains(intent);
    }

    private String mapStanfordIntentToOurs(String stanfordIntent) {
        // Map Stanford's generic intents to our domain-specific ones
        Map<String, String> intentMapping = new HashMap<>();
        intentMapping.put("QUESTION", "service_inquiry");
        intentMapping.put("REQUEST", "booking_request");
        intentMapping.put("COMPLAINT", "complaint");
        intentMapping.put("GREETING", "greeting");
        intentMapping.put("AFFIRMATION", "confirmation");
        intentMapping.put("NEGATION", "negation");

        return intentMapping.getOrDefault(stanfordIntent, "unknown");
    }

    private Map<String, String> mergeEntities(Map<String, String> basicEntities, Map<String, String> stanfordEntities) {
        Map<String, String> merged = new HashMap<>(basicEntities);

        // Add Stanford entities that we don't have
        for (Map.Entry<String, String> entry : stanfordEntities.entrySet()) {
            String key = entry.getKey();
            String value = entry.getValue();

            // Map Stanford entity types to our types
            String mappedKey = mapStanfordEntityType(key);
            if (mappedKey != null && !merged.containsKey(mappedKey)) {
                merged.put(mappedKey, value);
            }
        }

        return merged;
    }

    private String mapStanfordEntityType(String stanfordType) {
        Map<String, String> entityMapping = new HashMap<>();
        entityMapping.put("PERSON", "person_name");
        entityMapping.put("ORGANIZATION", "company_name");
        entityMapping.put("DATE", "time_expression");
        entityMapping.put("TIME", "time_expression");
        entityMapping.put("MONEY", "price");
        entityMapping.put("NUMBER", "mileage");

        return entityMapping.get(stanfordType);
    }

    private double calculateEnhancedConfidence(NLPResult basicResult, StanfordNLPResult stanfordResult) {
        // Weighted average of both confidences
        double basicWeight = 0.6; // Prefer domain-specific rules
        double stanfordWeight = 0.4;

        return (basicResult.getConfidence() * basicWeight) +
                (stanfordResult.getOverallConfidence() * stanfordWeight);
    }

    private Map<String, Double> mergeIntentConfidences(Map<String, Double> basic, Map<String, Double> stanford) {
        Map<String, Double> merged = new HashMap<>(basic);

        // Add Stanford confidences for intents we don't have
        if (stanford != null) {
            for (Map.Entry<String, Double> entry : stanford.entrySet()) {
                String mappedIntent = mapStanfordIntentToOurs(entry.getKey());
                if (!merged.containsKey(mappedIntent)) {
                    merged.put(mappedIntent, entry.getValue() * 0.8); // Slightly lower weight
                }
            }
        }

        return merged;
    }

    private boolean shouldHandoffToHuman(NLPResult enhancedResult, StanfordNLPResult stanfordResult, UserContext context) {
        // Enhanced handoff logic using both systems

        // If basic system already flagged for handoff
        if (enhancedResult.isRequiresHumanHandoff()) {
            return true;
        }

        // If Stanford detected complex emotional language
        if (stanfordResult.getSentimentScore() != null &&
                Math.abs(stanfordResult.getSentimentScore()) > 0.8) {
            return true;
        }

        // If both systems have low confidence
        if (enhancedResult.getConfidence() < 0.4) {
            return true;
        }

        // If Stanford detected complex grammatical structures (indicating complex query)
        if (stanfordResult.getComplexityScore() > 0.7) {
            return true;
        }

        return false;
    }

    private String generateEnhancedResponse(NLPResult result, UserContext context) {
        // Use the basic service's response generation but with enhanced context
        return basicNLPService.generateSuggestedResponsePublic(
                result.getIntent(), result.getEntities(), context, result.getSentiment());
    }

    // Configuration methods
    public void setConfidenceThreshold(double threshold) {
        this.confidenceThreshold = threshold;
    }

    public boolean isStanfordNLPAvailable() {
        return stanfordNLPService != null && stanfordNLPService.isInitialized();
    }

    public Map<String, Object> getSystemStatus() {
        Map<String, Object> status = new HashMap<>();
        status.put("basicNLPAvailable", true);
        status.put("stanfordNLPAvailable", stanfordNLPService != null);
        status.put("stanfordNLPInitialized", stanfordNLPService != null && stanfordNLPService.isInitialized());
        status.put("stanfordNLPStatus", stanfordNLPService != null ? stanfordNLPService.getStatus() : "Not available");
        status.put("confidenceThreshold", confidenceThreshold);
        status.put("processingMode", "hybrid");
        return status;
    }
}