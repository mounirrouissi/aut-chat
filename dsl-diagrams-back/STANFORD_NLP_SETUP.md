# Stanford CoreNLP Integration Guide

## 🎯 Overview

This guide shows you how to optionally integrate Stanford CoreNLP with your existing NLP system for enhanced accuracy and capabilities.

## 🚀 Quick Start (Recommended)

**Your current system works great without Stanford CoreNLP!** Only follow these steps if you need the advanced features.

### Step 1: Test Current System
```bash
# Your current system is already working with rule-based NLP
# Test it first at: http://localhost:8080/api/nlp-status
```

### Step 2: Add Dependencies (Optional)
Only add these to your `pom.xml` if you want Stanford CoreNLP:

```xml
<!-- Add to pom.xml -->
<dependency>
    <groupId>edu.stanford.nlp</groupId>
    <artifactId>stanford-corenlp</artifactId>
    <version>4.5.1</version>
</dependency>
<dependency>
    <groupId>edu.stanford.nlp</groupId>
    <artifactId>stanford-corenlp</artifactId>
    <version>4.5.1</version>
    <classifier>models</classifier>
</dependency>
```

### Step 3: Enable Stanford NLP
```properties
# In application.properties
nlp.use-stanford=true
nlp.confidence-threshold=0.6
```

## 🔧 How It Works

### Without Stanford CoreNLP (Current - Fast & Efficient)
- ✅ Rule-based intent recognition
- ✅ Regex entity extraction  
- ✅ Pattern-based sentiment analysis
- ✅ Fast response times
- ✅ Low memory usage
- ✅ Domain-specific accuracy

### With Stanford CoreNLP (Enhanced - More Accurate)
- ✅ All above features PLUS:
- 🆕 Advanced named entity recognition
- 🆕 Sophisticated sentiment analysis
- 🆕 Complex grammatical parsing
- 🆕 Better handling of ambiguous queries
- ⚠️ Slower startup (model loading)
- ⚠️ Higher memory usage (500MB+)

## 🎛️ Configuration Options

```properties
# Enable/disable Stanford CoreNLP
nlp.use-stanford=false

# Confidence threshold for enhancement
# If basic NLP confidence > threshold, Stanford won't be used
nlp.confidence-threshold=0.6

# Stanford-specific settings
nlp.stanford.annotators=tokenize,ssplit,pos,lemma,ner,parse,sentiment
nlp.stanford.timeout=30000
nlp.stanford.memory=2g
```

## 📊 Performance Comparison

| Feature | Rule-Based | Hybrid (Recommended) | Stanford Only |
|---------|------------|---------------------|---------------|
| Speed | ⚡ Very Fast | 🚀 Smart (Fast when possible) | 🐌 Slower |
| Memory | 💚 Low | 💛 Medium | 🔴 High |
| Accuracy (Automotive) | 💚 High | 💚 Very High | 💛 Good |
| Accuracy (General) | 💛 Medium | 💚 High | 💚 Very High |
| Setup Complexity | 💚 Simple | 💛 Medium | 🔴 Complex |

## 🎯 My Recommendation

**Start with your current rule-based system** - it's already excellent for automotive service scenarios!

**Consider adding Stanford CoreNLP only if:**
- You need to handle very complex customer queries
- You're expanding beyond automotive services
- You have users with poor grammar/spelling
- You need advanced sentiment analysis for customer satisfaction

## 🧪 Testing

### Test Current System
```bash
curl -X GET http://localhost:8080/api/nlp-status
```

### Test Message Analysis
```bash
curl -X POST http://localhost:8080/api/chat/analyze \
  -H "Content-Type: application/json" \
  -d '{"message": "My 2020 Honda Civic needs an oil change", "context": {}}'
```

## 🔄 Migration Path

1. **Phase 1**: Keep using your current system (it's great!)
2. **Phase 2**: Add Stanford dependencies and enable hybrid mode
3. **Phase 3**: Monitor performance and adjust confidence threshold
4. **Phase 4**: Fine-tune based on real user feedback

## 💡 Best Practices

- **Start with `nlp.use-stanford=false`** (your current setup)
- **Set `nlp.confidence-threshold=0.7`** to use Stanford only for difficult cases
- **Monitor memory usage** if you enable Stanford CoreNLP
- **Use caching** for frequently asked questions

## 🆘 Troubleshooting

### Stanford CoreNLP Not Loading
```bash
# Check if models are downloaded
ls ~/.m2/repository/edu/stanford/nlp/stanford-corenlp/

# Check application logs
tail -f logs/application.log | grep Stanford
```

### High Memory Usage
```properties
# Reduce memory usage
nlp.stanford.annotators=tokenize,ssplit,ner,sentiment
nlp.stanford.memory=1g
```

### Slow Performance
```properties
# Use Stanford only for low-confidence cases
nlp.confidence-threshold=0.8
```

## 📈 Monitoring

Check system status:
```bash
curl http://localhost:8080/api/nlp-status
```

Response example:
```json
{
  "basicNLPAvailable": true,
  "enhancedNLPAvailable": true,
  "stanfordNLPAvailable": true,
  "stanfordNLPEnabled": true,
  "confidenceThreshold": 0.6
}
```