package com.dsl.controller;

import edu.stanford.nlp.ling.CoreAnnotations;
import edu.stanford.nlp.ling.CoreLabel;
import edu.stanford.nlp.neural.rnn.RNNCoreAnnotations;
import edu.stanford.nlp.pipeline.Annotation;
import edu.stanford.nlp.pipeline.StanfordCoreNLP;
import edu.stanford.nlp.sentiment.SentimentCoreAnnotations;
import edu.stanford.nlp.trees.Tree;
import edu.stanford.nlp.util.CoreMap;
import jakarta.annotation.PostConstruct;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class StanfordNLPService {
    
    private StanfordCoreNLP pipeline;
    private boolean initialized = false;
    
    @PostConstruct
    public void initialize() {
        try {
            System.out.println("Initializing Stanford CoreNLP pipeline...");
            initializeStanfordPipeline();
            initialized = true;
            System.out.println("Stanford CoreNLP pipeline initialized successfully!");
        } catch (Exception e) {
            System.err.println("Failed to initialize Stanford CoreNLP: " + e.getMessage());
            e.printStackTrace();
            initialized = false;
        }
    }
    
    private void initializeStanfordPipeline() {
        // Set up pipeline properties
        Properties props = new Properties();
        props.setProperty("annotators", "tokenize,ssplit,pos,lemma,ner,parse,sentiment");
        props.setProperty("outputFormat", "json");
        props.setProperty("ner.useSUTime", "false"); // Disable SUTime for faster processing
        props.setProperty("ner.applyNumericClassifiers", "false"); // Faster processing
        props.setProperty("ner.applyFineGrained", "false"); // Faster processing
        
        // Create the pipeline
        pipeline = new StanfordCoreNLP(props);
    }
    
    public StanfordNLPResult analyze(String text) {
        if (!initialized || pipeline == null) {
            throw new RuntimeException("Stanford CoreNLP not initialized");
        }
        
        if (text == null || text.trim().isEmpty()) {
            throw new IllegalArgumentException("Text cannot be null or empty");
        }
        
        try {
            long startTime = System.currentTimeMillis();
            StanfordNLPResult result = performAnalysis(text.trim());
            long endTime = System.currentTimeMillis();
            result.setProcessingTime((endTime - startTime) + "ms");
            return result;
        } catch (Exception e) {
            System.err.println("Stanford CoreNLP analysis failed for text: " + text);
            e.printStackTrace();
            throw new RuntimeException("Stanford CoreNLP analysis failed: " + e.getMessage(), e);
        }
    }
    
    private StanfordNLPResult performAnalysis(String text) {
        // Create annotation
        Annotation annotation = new Annotation(text);
        
        // Process the annotation
        pipeline.annotate(annotation);
        
        // Extract results
        StanfordNLPResult result = new StanfordNLPResult();
        
        // Extract entities
        Map<String, String> entities = extractEntities(annotation);
        result.setEntities(entities != null ? entities : new HashMap<>());
        
        // Extract sentiment
        String sentiment = extractSentiment(annotation);
        Double sentimentScore = extractSentimentScore(annotation);
        result.setSentiment(sentiment != null ? sentiment : "neutral");
        result.setSentimentScore(sentimentScore != null ? sentimentScore : 0.0);
        
        // Extract intent (basic classification based on sentence structure)
        String intent = classifyIntent(annotation);
        Map<String, Double> intentConfidences = new HashMap<>();
        intentConfidences.put(intent, 0.7);
        result.setIntent(intent != null ? intent : "UNKNOWN");
        result.setIntentConfidence(0.7);
        result.setIntentConfidences(intentConfidences);
        
        // Calculate complexity score
        double complexityScore = calculateComplexityScore(annotation);
        result.setComplexityScore(complexityScore);
        
        // Overall confidence
        result.setOverallConfidence(calculateOverallConfidence(result));
        
        return result;
    }
    
    private Map<String, String> extractEntities(Annotation annotation) {
        Map<String, String> entities = new HashMap<>();
        
        try {
            // Get sentences from annotation
            List<CoreMap> sentences = annotation.get(CoreAnnotations.SentencesAnnotation.class);
            
            if (sentences == null || sentences.isEmpty()) {
                return entities;
            }
            
            for (CoreMap sentence : sentences) {
                // Get tokens from sentence
                List<CoreLabel> tokens = sentence.get(CoreAnnotations.TokensAnnotation.class);
                
                if (tokens == null || tokens.isEmpty()) {
                    continue;
                }
                
                StringBuilder currentEntity = new StringBuilder();
                String currentEntityType = null;
                
                for (CoreLabel token : tokens) {
                    String word = token.get(CoreAnnotations.TextAnnotation.class);
                    String nerTag = token.get(CoreAnnotations.NamedEntityTagAnnotation.class);
                    
                    if (word == null) continue;
                    
                    if (nerTag != null && !nerTag.equals("O")) {
                        // This token is part of a named entity
                        if (currentEntityType == null || !currentEntityType.equals(nerTag)) {
                            // Starting a new entity or changing entity type
                            if (currentEntity.length() > 0 && currentEntityType != null) {
                                // Save the previous entity
                                String entityKey = currentEntityType.toLowerCase();
                                String entityValue = currentEntity.toString().trim();
                                if (!entityValue.isEmpty()) {
                                    entities.put(entityKey, entityValue);
                                }
                            }
                            currentEntity = new StringBuilder(word);
                            currentEntityType = nerTag;
                        } else {
                            // Continuing the same entity
                            currentEntity.append(" ").append(word);
                        }
                    } else {
                        // Not part of a named entity
                        if (currentEntity.length() > 0 && currentEntityType != null) {
                            // Save the current entity
                            String entityKey = currentEntityType.toLowerCase();
                            String entityValue = currentEntity.toString().trim();
                            if (!entityValue.isEmpty()) {
                                entities.put(entityKey, entityValue);
                            }
                            currentEntity = new StringBuilder();
                            currentEntityType = null;
                        }
                    }
                }
                
                // Don't forget the last entity if the sentence ends with one
                if (currentEntity.length() > 0 && currentEntityType != null) {
                    String entityKey = currentEntityType.toLowerCase();
                    String entityValue = currentEntity.toString().trim();
                    if (!entityValue.isEmpty()) {
                        entities.put(entityKey, entityValue);
                    }
                }
            }
        } catch (Exception e) {
            System.err.println("Error extracting entities: " + e.getMessage());
            // Return empty map on error
        }
        
        return entities;
    }
    
    private String extractSentiment(Annotation annotation) {
        try {
            List<CoreMap> sentences = annotation.get(CoreAnnotations.SentencesAnnotation.class);
            
            if (sentences == null || sentences.isEmpty()) {
                return "neutral";
            }
            
            // Get sentiment from the first sentence (or you could average all sentences)
            CoreMap sentence = sentences.get(0);
            Tree sentimentTree = sentence.get(SentimentCoreAnnotations.SentimentAnnotatedTree.class);
            
            if (sentimentTree == null) {
                return "neutral";
            }
            
            int sentimentInt = RNNCoreAnnotations.getPredictedClass(sentimentTree);
            
            // Stanford CoreNLP sentiment scale: 0=very negative, 1=negative, 2=neutral, 3=positive, 4=very positive
            switch (sentimentInt) {
                case 0:
                case 1:
                    return "negative";
                case 3:
                case 4:
                    return "positive";
                default:
                    return "neutral";
            }
        } catch (Exception e) {
            System.err.println("Error extracting sentiment: " + e.getMessage());
            return "neutral";
        }
    }
    
    private Double extractSentimentScore(Annotation annotation) {
        try {
            List<CoreMap> sentences = annotation.get(CoreAnnotations.SentencesAnnotation.class);
            
            if (sentences == null || sentences.isEmpty()) {
                return 0.0;
            }
            
            CoreMap sentence = sentences.get(0);
            Tree sentimentTree = sentence.get(SentimentCoreAnnotations.SentimentAnnotatedTree.class);
            
            if (sentimentTree == null) {
                return 0.0;
            }
            
            int sentimentInt = RNNCoreAnnotations.getPredictedClass(sentimentTree);
            
            // Convert Stanford's 0-4 scale to -1 to 1 scale
            // 0=very negative (-1), 1=negative (-0.5), 2=neutral (0), 3=positive (0.5), 4=very positive (1)
            switch (sentimentInt) {
                case 0: return -1.0;
                case 1: return -0.5;
                case 2: return 0.0;
                case 3: return 0.5;
                case 4: return 1.0;
                default: return 0.0;
            }
        } catch (Exception e) {
            System.err.println("Error extracting sentiment score: " + e.getMessage());
            return 0.0;
        }
    }
    
    private String classifyIntent(Annotation annotation) {
        try {
            List<CoreMap> sentences = annotation.get(CoreAnnotations.SentencesAnnotation.class);
            
            if (sentences == null || sentences.isEmpty()) {
                return "UNKNOWN";
            }
            
            CoreMap sentence = sentences.get(0);
            List<CoreLabel> tokens = sentence.get(CoreAnnotations.TokensAnnotation.class);
            
            if (tokens == null || tokens.isEmpty()) {
                return "UNKNOWN";
            }
            
            // Get full text for pattern matching
            String fullText = annotation.get(CoreAnnotations.TextAnnotation.class);
            if (fullText == null) {
                return "UNKNOWN";
            }
            fullText = fullText.toLowerCase();
            
            // Simple intent classification based on POS tags and patterns
            String firstWord = tokens.get(0).get(CoreAnnotations.TextAnnotation.class);
            if (firstWord == null) {
                return "UNKNOWN";
            }
            firstWord = firstWord.toLowerCase();
            
            // Question patterns
            if (firstWord.matches("what|when|where|who|why|how|can|could|would|will|do|does|did|is|are|was|were")) {
                return "QUESTION";
            }
            
            // Request patterns
            if (firstWord.matches("please|schedule|book|reserve") || 
                fullText.contains("i need") || fullText.contains("i want") || fullText.contains("i would like")) {
                return "REQUEST";
            }
            
            // Greeting patterns
            if (firstWord.matches("hello|hi|hey|good")) {
                return "GREETING";
            }
            
            // Affirmation patterns
            if (firstWord.matches("yes|yeah|yep|sure|ok|okay|right|correct")) {
                return "AFFIRMATION";
            }
            
            // Negation patterns
            if (firstWord.matches("no|nope|not|never|wrong|incorrect")) {
                return "NEGATION";
            }
            
            // Check for complaint indicators
            if (fullText.contains("problem") || fullText.contains("issue") || fullText.contains("complaint") || 
                fullText.contains("terrible") || fullText.contains("awful") || fullText.contains("bad")) {
                return "COMPLAINT";
            }
            
            // Default to statement
            return "STATEMENT";
        } catch (Exception e) {
            System.err.println("Error classifying intent: " + e.getMessage());
            return "UNKNOWN";
        }
    }
    
    private double calculateComplexityScore(Annotation annotation) {
        try {
            List<CoreMap> sentences = annotation.get(CoreAnnotations.SentencesAnnotation.class);
            
            if (sentences == null || sentences.isEmpty()) {
                return 0.0;
            }
            
            double totalComplexity = 0.0;
            
            for (CoreMap sentence : sentences) {
                List<CoreLabel> tokens = sentence.get(CoreAnnotations.TokensAnnotation.class);
                
                if (tokens == null || tokens.isEmpty()) continue;
                
                double sentenceComplexity = 0.0;
                
                // Factor 1: Sentence length (longer = more complex)
                int tokenCount = tokens.size();
                sentenceComplexity += Math.min(tokenCount / 20.0, 0.4); // Cap at 0.4
                
                // Factor 2: Vocabulary complexity (count of complex POS tags)
                int complexPOSCount = 0;
                for (CoreLabel token : tokens) {
                    String pos = token.get(CoreAnnotations.PartOfSpeechAnnotation.class);
                    if (pos != null && (pos.startsWith("VB") || pos.startsWith("NN") || pos.startsWith("JJ"))) {
                        complexPOSCount++;
                    }
                }
                if (tokenCount > 0) {
                    sentenceComplexity += Math.min(complexPOSCount / (double) tokenCount, 0.3); // Cap at 0.3
                }
                
                // Factor 3: Named entities (more entities = more complex)
                int entityCount = 0;
                for (CoreLabel token : tokens) {
                    String ner = token.get(CoreAnnotations.NamedEntityTagAnnotation.class);
                    if (ner != null && !ner.equals("O")) {
                        entityCount++;
                    }
                }
                if (tokenCount > 0) {
                    sentenceComplexity += Math.min(entityCount / (double) tokenCount, 0.3); // Cap at 0.3
                }
                
                totalComplexity += sentenceComplexity;
            }
            
            return Math.min(totalComplexity / sentences.size(), 1.0);
        } catch (Exception e) {
            System.err.println("Error calculating complexity score: " + e.getMessage());
            return 0.5; // Default complexity
        }
    }
    
    private double calculateOverallConfidence(StanfordNLPResult result) {
        try {
            // Calculate confidence based on various factors
            double confidence = 0.7; // Base confidence
            
            // Adjust based on entity count
            if (result.getEntities() != null && result.getEntities().size() > 0) {
                confidence += 0.1;
            }
            
            // Adjust based on sentiment confidence
            if (result.getSentimentScore() != null && Math.abs(result.getSentimentScore()) > 0.5) {
                confidence += 0.1;
            }
            
            // Adjust based on complexity (more complex = potentially less confident)
            if (result.getComplexityScore() != null && result.getComplexityScore() > 0.7) {
                confidence -= 0.1;
            }
            
            return Math.max(0.1, Math.min(1.0, confidence));
        } catch (Exception e) {
            System.err.println("Error calculating overall confidence: " + e.getMessage());
            return 0.7; // Default confidence
        }
    }
    
    public boolean isInitialized() {
        return initialized;
    }
    
    public String getStatus() {
        if (!initialized) {
            return "Not initialized";
        }
        if (pipeline == null) {
            return "Pipeline is null";
        }
        return "Ready";
    }
}