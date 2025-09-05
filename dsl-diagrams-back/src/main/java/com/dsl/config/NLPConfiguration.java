package com.dsl.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

@Configuration
@ConfigurationProperties(prefix = "nlp")
public class NLPConfiguration {
    
    private boolean useStanford = false;
    private double confidenceThreshold = 0.6;
    private boolean cacheEnabled = true;
    private int cacheSize = 1000;
    private boolean asyncProcessing = false;
    
    private Stanford stanford = new Stanford();
    
    // Getters and setters
    public boolean isUseStanford() {
        return useStanford;
    }
    
    public void setUseStanford(boolean useStanford) {
        this.useStanford = useStanford;
    }
    
    public double getConfidenceThreshold() {
        return confidenceThreshold;
    }
    
    public void setConfidenceThreshold(double confidenceThreshold) {
        this.confidenceThreshold = confidenceThreshold;
    }
    
    public boolean isCacheEnabled() {
        return cacheEnabled;
    }
    
    public void setCacheEnabled(boolean cacheEnabled) {
        this.cacheEnabled = cacheEnabled;
    }
    
    public int getCacheSize() {
        return cacheSize;
    }
    
    public void setCacheSize(int cacheSize) {
        this.cacheSize = cacheSize;
    }
    
    public boolean isAsyncProcessing() {
        return asyncProcessing;
    }
    
    public void setAsyncProcessing(boolean asyncProcessing) {
        this.asyncProcessing = asyncProcessing;
    }
    
    public Stanford getStanford() {
        return stanford;
    }
    
    public void setStanford(Stanford stanford) {
        this.stanford = stanford;
    }
    
    public static class Stanford {
        private String annotators = "tokenize,ssplit,pos,lemma,ner,parse,sentiment";
        private int timeout = 30000;
        private String memory = "2g";
        
        // Getters and setters
        public String getAnnotators() {
            return annotators;
        }
        
        public void setAnnotators(String annotators) {
            this.annotators = annotators;
        }
        
        public int getTimeout() {
            return timeout;
        }
        
        public void setTimeout(int timeout) {
            this.timeout = timeout;
        }
        
        public String getMemory() {
            return memory;
        }
        
        public void setMemory(String memory) {
            this.memory = memory;
        }
    }
}