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
            initializeResponseTemplates();
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
        extractVehicleEntities(annotation, entities); // New call for vehicle entities
        result.setEntities(entities != null ? entities : new HashMap<>());

        // Extract customer name using enhanced logic
        String customerName = extractCustomerName(annotation, entities);
        if (customerName != null) {
            result.setCustomerName(customerName);
            // Also add it to the entities map for consistency, using the mapped key
            entities.put("person_name", customerName);
        }
        
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

        // Generate suggested response
        String suggestedResponse = generateSuggestedResponse(result.getIntent(), result.getEntities(), result.getSentiment());
        result.setSuggestedResponse(suggestedResponse);
        
        return result;
    }
    
    private String extractCustomerName(Annotation annotation, Map<String, String> entities) {
        // 1. Prioritize NER result if it exists and is valid
        if (entities.containsKey("person")) {
            String person = entities.get("person");
            // Simple validation: check if it's not just a single character or a common non-name word
            if (person.length() > 1 && !person.equalsIgnoreCase("customer") && person.split(" ").length <= 3) {
                return person;
            }
        }

        // 2. Rule-based extraction as a fallback
        return extractCustomerNameWithRules(annotation);
    }

    private String extractCustomerNameWithRules(Annotation annotation) {
        String text = annotation.get(CoreAnnotations.TextAnnotation.class);
        List<CoreMap> sentences = annotation.get(CoreAnnotations.SentencesAnnotation.class);
        if (sentences == null || sentences.isEmpty()) {
            return null;
        }

        // Regex to find patterns like "my name is John Doe"
        java.util.regex.Pattern pattern = java.util.regex.Pattern.compile(
            "(?i)(?:my name is|I'm|I am|call me)\s+([A-Z][a-z]+(?:\s+[A-Z][a-z]+)?)");
        java.util.regex.Matcher matcher = pattern.matcher(text);

        if (matcher.find()) {
            return matcher.group(1).trim();
        }

        // Look for a name at the beginning of the first sentence (e.g., "John Doe here...")
        CoreMap firstSentence = sentences.get(0);
        List<CoreLabel> tokens = firstSentence.get(CoreAnnotations.TokensAnnotation.class);
        if (tokens != null && tokens.size() >= 2) {
            String token1 = tokens.get(0).get(CoreAnnotations.TextAnnotation.class);
            String token2 = tokens.get(1).get(CoreAnnotations.TextAnnotation.class);

            // Check if the first two tokens are capitalized (potential first and last name)
            if (Character.isUpperCase(token1.charAt(0)) && token1.length() > 1 &&
                Character.isUpperCase(token2.charAt(0)) && token2.length() > 1) {
                // Avoid common sentence starters that are capitalized
                if (!token1.equalsIgnoreCase("I") && !token1.equalsIgnoreCase("The")) {
                    return token1 + " " + token2;
                }
            }
            // Check for "Hi, I'm John"
            if (tokens.size() >= 3 && token1.equalsIgnoreCase("Hi,") && token2.equalsIgnoreCase("I'm")) {
                 return tokens.get(2).get(CoreAnnotations.TextAnnotation.class);
            }
        }

        return null; // No name found
    }
    
    private String generateSuggestedResponse(String intent, Map<String, String> entities, String sentiment) {
        // Prioritize specific responses based on intent and entities
        if ("GREETING".equals(intent)) {
            if (entities.containsKey("person_name")) {
                return getRandomTemplate("GREETING") + " " + entities.get("person_name") + "! How can I help you today?";
            }
            return getRandomTemplate("GREETING");
        }
        if ("COMPLAINT".equals(intent) && "negative".equals(sentiment)) {
            return getRandomTemplate("COMPLAINT");
        }
        if ("QUESTION".equals(intent)) {
            return getRandomTemplate("QUESTION");
        }
        if ("REQUEST".equals(intent)) {
            return getRandomTemplate("REQUEST");
        }
        if ("AFFIRMATION".equals(intent)) {
            return getRandomTemplate("AFFIRMATION");
        }
        if ("NEGATION".equals(intent)) {
            return getRandomTemplate("NEGATION");
        }

        // Fallback to general templates
        return getRandomTemplate(intent);
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
    
    private void extractVehicleEntities(Annotation annotation, Map<String, String> entities) {
        List<CoreMap> sentences = annotation.get(CoreAnnotations.SentencesAnnotation.class);
        if (sentences == null || sentences.isEmpty()) {
            return;
        }

        for (CoreMap sentence : sentences) {
            List<CoreLabel> tokens = sentence.get(CoreAnnotations.TokensAnnotation.class);
            if (tokens == null || tokens.isEmpty()) {
                continue;
            }

            // Look for patterns like "YEAR MAKE MODEL" or "MAKE MODEL"
            for (int i = 0; i < tokens.size(); i++) {
                CoreLabel token = tokens.get(i);
                String word = token.get(CoreAnnotations.TextAnnotation.class);
                String pos = token.get(CoreAnnotations.PartOfSpeechAnnotation.class);

                // Try to extract year (NNP or CD and looks like a year)
                if (pos != null && (pos.equals("CD") || pos.equals("NNP")) && word.matches("^(19|20)\\d{2}$")) {
                    entities.putIfAbsent("vehicle_year", word);
                    // Look for make and model after the year
                    if (i + 1 < tokens.size()) {
                        CoreLabel nextToken = tokens.get(i + 1);
                        String nextWord = nextToken.get(CoreAnnotations.TextAnnotation.class);
                        String nextPos = nextToken.get(CoreAnnotations.PartOfSpeechAnnotation.class);

                        // Simple check for capitalized words as potential make/model
                        if (nextPos != null && nextPos.equals("NNP") && Character.isUpperCase(nextWord.charAt(0))) {
                            entities.putIfAbsent("vehicle_make", nextWord);
                            if (i + 2 < tokens.size()) {
                                CoreLabel thirdToken = tokens.get(i + 2);
                                String thirdWord = thirdToken.get(CoreAnnotations.TextAnnotation.class);
                                String thirdPos = thirdToken.get(CoreAnnotations.PartOfSpeechAnnotation.class);
                                if (thirdPos != null && thirdPos.equals("NNP") && Character.isUpperCase(thirdWord.charAt(0))) {
                                    entities.putIfAbsent("vehicle_model", thirdWord);
                                }
                            }
                        }
                    }
                }
                // Try to extract make and model without year (e.g., "Honda Civic")
                else if (pos != null && pos.equals("NNP") && Character.isUpperCase(word.charAt(0))) {
                    // Check if it's a common car make (simple heuristic)
                    List<String> commonMakes = Arrays.asList("Honda", "Toyota", "Ford", "Chevrolet", "Nissan", "BMW", "Mercedes", "Audi", "Volkswagen", "Hyundai", "Kia", "Subaru", "Mazda", "Jeep", "Tesla");
                    if (commonMakes.contains(word)) {
                        entities.putIfAbsent("vehicle_make", word);
                        if (i + 1 < tokens.size()) {
                            CoreLabel nextToken = tokens.get(i + 1);
                            String nextWord = nextToken.get(CoreAnnotations.TextAnnotation.class);
                            String nextPos = nextToken.get(CoreAnnotations.PartOfSpeechAnnotation.class);
                            if (nextPos != null && nextPos.equals("NNP") && Character.isUpperCase(nextWord.charAt(0))) {
                                entities.putIfAbsent("vehicle_model", nextWord);
                            }
                        }
                    }
                }
            }
        }
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

            String fullText = annotation.get(CoreAnnotations.TextAnnotation.class).toLowerCase();

            // Keyword-based classification for simple intents
            if (fullText.matches(".*\\b(hello|hi|hey|good morning|good afternoon|good evening|howdy|greetings)\\b.*")) {
                return "GREETING";
            }
            if (fullText.matches(".*\\b(yes|yeah|yep|sure|ok|okay|right|correct|confirm|absolutely|definitely)\\b.*")) {
                return "AFFIRMATION";
            }
            if (fullText.matches(".*\\b(no|nope|not|never|wrong|incorrect|cancel)\\b.*")) {
                return "NEGATION";
            }
            if (fullText.contains("problem") || fullText.contains("issue") || fullText.contains("complaint") ||
                fullText.contains("terrible") || fullText.contains("awful") || fullText.contains("bad")) {
                return "COMPLAINT";
            }

            // POS-based classification for more complex intents
            String firstTokenPos = tokens.get(0).get(CoreAnnotations.PartOfSpeechAnnotation.class);
            String firstTokenText = tokens.get(0).get(CoreAnnotations.TextAnnotation.class).toLowerCase();

            if (firstTokenPos.startsWith("W") || firstTokenText.matches("can|could|would|will|do|does|did|is|are|was|were")) {
                return "QUESTION";
            }

            if (firstTokenPos.startsWith("VB")) {
                return "REQUEST";
            }
            
            if (fullText.contains("i need") || fullText.contains("i want") || fullText.contains("i would like") || fullText.contains("please")) {
                return "REQUEST";
            }

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
    
    private final Map<String, List<String>> responseTemplates = new HashMap<>();

    private void initializeResponseTemplates() {
        responseTemplates.put("GREETING", Arrays.asList(
                "Hello! I'm your auto service assistant. How can I help you today?",
                "Hi there! Welcome. What can I do for you?",
                "Good day! How may I assist you with your automotive needs?"
        ));
        responseTemplates.put("QUESTION", Arrays.asList(
                "That's a good question. What specifically would you like to know?",
                "I can help with that. What information are you looking for?"
        ));
        responseTemplates.put("REQUEST", Arrays.asList(
                "I can help with that request. Please tell me more.",
                "Understood. What exactly do you need assistance with?"
        ));
        responseTemplates.put("COMPLAINT", Arrays.asList(
                "I understand your concern. Please tell me more about the issue.",
                "I'm sorry to hear that. How can I help resolve this problem?"
        ));
        responseTemplates.put("AFFIRMATION", Arrays.asList(
                "Great!",
                "Understood.",
                "Okay."
        ));
        responseTemplates.put("NEGATION", Arrays.asList(
                "No problem.",
                "Understood. Is there anything else I can help with?"
        ));
        responseTemplates.put("UNKNOWN", Arrays.asList(
                "I'm not sure I understand. Could you rephrase that?",
                "I'm still learning. Can you provide more details?"
        ));
    }

    private String getRandomTemplate(String templateKey) {
        List<String> templates = responseTemplates.get(templateKey);
        if (templates != null && !templates.isEmpty()) {
            return templates.get(new Random().nextInt(templates.size()));
        }
        return "I'm here to help you.";
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