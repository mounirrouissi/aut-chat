import React, { useState } from "react";
import AdvancedChatInterface from "../Chat/AdvancedChatInterface";
import "./NLPDemo.css";

const NLPDemo = () => {
  const [selectedDemo, setSelectedDemo] = useState("chat");
  const [testMessage, setTestMessage] = useState("");
  const [analysisResult, setAnalysisResult] = useState(null);
  const [isAnalyzing, setIsAnalyzing] = useState(false);

  const demoMessages = [
    "Hello, my name is John Smith",
    "I drive a 2020 Honda Civic",
    "I need an oil change for my car",
    "Can you schedule an appointment for tomorrow?",
    "My car broke down and won't start! This is an emergency!",
    "I'm really unhappy with the service I received",
    "Yes, that sounds perfect",
    "No, that doesn't work for me",
  ];

  const analyzeMessage = async () => {
    if (!testMessage.trim()) return;

    setIsAnalyzing(true);
    try {
      const response = await fetch("http://localhost:8080/api/chat/analyze", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          message: testMessage,
          context: {},
        }),
      });

      const result = await response.json();
      setAnalysisResult(result);
    } catch (error) {
      console.error("Analysis failed:", error);
      setAnalysisResult({ error: "Failed to analyze message" });
    } finally {
      setIsAnalyzing(false);
    }
  };

  const loadDemoMessage = (message) => {
    setTestMessage(message);
  };

  const testStanfordNLP = async () => {
    setIsAnalyzing(true);
    try {
      const response = await fetch("/api/chat/test-stanford", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          message:
            testMessage ||
            "Hello, my name is John Smith and I drive a 2020 Honda Civic. I'm very unhappy with the service!",
        }),
      });

      const result = await response.json();

      if (result.success) {
        // Show comparison between basic and enhanced NLP
        setAnalysisResult({
          ...result.enhancedNLP,
          comparison: {
            basic: result.basicNLP,
            enhanced: result.enhancedNLP,
            testMessage: result.testMessage,
          },
        });
      } else {
        setAnalysisResult({
          error: result.error || "Stanford CoreNLP test failed",
        });
      }
    } catch (error) {
      console.error("Stanford test failed:", error);
      setAnalysisResult({ error: "Failed to test Stanford CoreNLP" });
    } finally {
      setIsAnalyzing(false);
    }
  };

  const getConfidenceColor = (confidence) => {
    if (confidence >= 0.8) return "#4CAF50";
    if (confidence >= 0.6) return "#FF9800";
    return "#F44336";
  };

  const getSentimentColor = (sentiment) => {
    switch (sentiment) {
      case "positive":
        return "#4CAF50";
      case "negative":
        return "#F44336";
      case "neutral":
        return "#9E9E9E";
      default:
        return "#9E9E9E";
    }
  };

  return (
    <div className="nlp-demo-container">
      <div className="demo-header">
        <h1>Advanced NLP Auto Service Assistant</h1>
        <p>
          Experience our enhanced natural language processing capabilities with
          context awareness, sentiment analysis, and intelligent intent
          recognition.
        </p>
      </div>

      <div className="demo-tabs">
        <button
          className={`tab-button ${selectedDemo === "chat" ? "active" : ""}`}
          onClick={() => setSelectedDemo("chat")}
        >
          Interactive Chat
        </button>
        <button
          className={`tab-button ${
            selectedDemo === "analyzer" ? "active" : ""
          }`}
          onClick={() => setSelectedDemo("analyzer")}
        >
          Message Analyzer
        </button>
        <button
          className={`tab-button ${
            selectedDemo === "features" ? "active" : ""
          }`}
          onClick={() => setSelectedDemo("features")}
        >
          Features Overview
        </button>
      </div>

      <div className="demo-content">
        {selectedDemo === "chat" && (
          <div className="chat-demo">
            <div className="demo-instructions">
              <h3>Try the Advanced Chat Interface</h3>
              <p>
                Enable debug mode to see detailed NLP analysis including intent
                confidence, sentiment, and extracted entities.
              </p>
              <div className="sample-messages">
                <strong>Try these sample messages:</strong>
                <ul>
                  <li>"Hello, my name is Sarah Johnson"</li>
                  <li>"I drive a 2019 Toyota Camry"</li>
                  <li>"My car won't start! This is an emergency!"</li>
                  <li>"I need an oil change appointment"</li>
                </ul>
              </div>
            </div>
            <AdvancedChatInterface />
          </div>
        )}

        {selectedDemo === "analyzer" && (
          <div className="analyzer-demo">
            <div className="analyzer-section">
              <h3>Message Analysis Tool</h3>
              <p>
                Test individual messages to see how our NLP engine processes
                them.
              </p>

              <div className="demo-messages">
                <h4>Quick Test Messages:</h4>
                <div className="demo-message-buttons">
                  {demoMessages.map((message, index) => (
                    <button
                      key={index}
                      className="demo-message-btn"
                      onClick={() => loadDemoMessage(message)}
                    >
                      {message}
                    </button>
                  ))}
                </div>
              </div>

              <div className="analyzer-input">
                <textarea
                  value={testMessage}
                  onChange={(e) => setTestMessage(e.target.value)}
                  placeholder="Enter a message to analyze..."
                  className="analysis-textarea"
                  rows="3"
                />
                <div className="button-group">
                  <button
                    onClick={analyzeMessage}
                    disabled={!testMessage.trim() || isAnalyzing}
                    className="analyze-button"
                  >
                    {isAnalyzing ? "Analyzing..." : "Analyze Message"}
                  </button>
                  <button
                    onClick={testStanfordNLP}
                    disabled={isAnalyzing}
                    className="test-stanford-button"
                  >
                    Test Stanford CoreNLP
                  </button>
                </div>
              </div>

              {analysisResult && (
                <div className="analysis-results">
                  <h4>Analysis Results</h4>
                  {analysisResult.error ? (
                    <div className="error-result">
                      Error: {analysisResult.error}
                    </div>
                  ) : (
                    <div className="result-grid">
                      <div className="result-card">
                        <h5>Primary Intent</h5>
                        <div className="intent-result">
                          <span className="intent-name">
                            {analysisResult.intent}
                          </span>
                          <span
                            className="confidence-badge"
                            style={{
                              backgroundColor: getConfidenceColor(
                                analysisResult.confidence
                              ),
                            }}
                          >
                            {(analysisResult.confidence * 100).toFixed(1)}%
                          </span>
                        </div>
                      </div>

                      <div className="result-card">
                        <h5>Sentiment</h5>
                        <div
                          className="sentiment-result"
                          style={{
                            color: getSentimentColor(analysisResult.sentiment),
                          }}
                        >
                          {analysisResult.sentiment}
                        </div>
                      </div>

                      <div className="result-card">
                        <h5>Extracted Entities</h5>
                        <div className="entities-result">
                          {Object.keys(analysisResult.entities).length > 0 ? (
                            Object.entries(analysisResult.entities).map(
                              ([key, value]) => (
                                <div key={key} className="entity-item">
                                  <strong>{key}:</strong> {value}
                                </div>
                              )
                            )
                          ) : (
                            <span className="no-entities">
                              No entities detected
                            </span>
                          )}
                        </div>
                      </div>

                      <div className="result-card">
                        <h5>Intent Confidence Scores</h5>
                        <div className="intent-scores">
                          {Object.entries(
                            analysisResult.intentConfidences || {}
                          )
                            .sort(([, a], [, b]) => b - a)
                            .slice(0, 5)
                            .map(([intent, confidence]) => (
                              <div key={intent} className="intent-score-item">
                                <span className="intent-label">{intent}</span>
                                <div className="confidence-bar">
                                  <div
                                    className="confidence-fill"
                                    style={{
                                      width: `${confidence * 100}%`,
                                      backgroundColor:
                                        getConfidenceColor(confidence),
                                    }}
                                  />
                                </div>
                                <span className="confidence-value">
                                  {(confidence * 100).toFixed(1)}%
                                </span>
                              </div>
                            ))}
                        </div>
                      </div>

                      {analysisResult.requiresHumanHandoff && (
                        <div className="result-card handoff-card">
                          <h5>⚠️ Human Handoff Recommended</h5>
                          <p>
                            This message requires human intervention due to
                            complexity, low confidence, or sensitive nature.
                          </p>
                        </div>
                      )}

                      {analysisResult.suggestedResponse && (
                        <div className="result-card">
                          <h5>Suggested Response</h5>
                          <div className="suggested-response">
                            {analysisResult.suggestedResponse}
                          </div>
                        </div>
                      )}

                      {analysisResult.comparison && (
                        <div className="result-card comparison-card">
                          <h5>🔬 Basic vs Enhanced NLP Comparison</h5>
                          <div className="comparison-grid">
                            <div className="comparison-section">
                              <h6>Rule-Based NLP</h6>
                              <div className="comparison-item">
                                <strong>Intent:</strong>{" "}
                                {analysisResult.comparison.basic.intent}
                                <span
                                  className="confidence-badge"
                                  style={{
                                    backgroundColor: getConfidenceColor(
                                      analysisResult.comparison.basic.confidence
                                    ),
                                  }}
                                >
                                  {(
                                    analysisResult.comparison.basic.confidence *
                                    100
                                  ).toFixed(1)}
                                  %
                                </span>
                              </div>
                              <div className="comparison-item">
                                <strong>Sentiment:</strong>{" "}
                                {analysisResult.comparison.basic.sentiment}
                              </div>
                              <div className="comparison-item">
                                <strong>Entities:</strong>{" "}
                                {
                                  Object.keys(
                                    analysisResult.comparison.basic.entities ||
                                      {}
                                  ).length
                                }
                              </div>
                              <div className="comparison-item">
                                <strong>Method:</strong>{" "}
                                {analysisResult.comparison.basic
                                  .processingMethod || "rule-based"}
                              </div>
                            </div>

                            <div className="comparison-section">
                              <h6>Enhanced NLP (with Stanford CoreNLP)</h6>
                              <div className="comparison-item">
                                <strong>Intent:</strong>{" "}
                                {analysisResult.comparison.enhanced.intent}
                                <span
                                  className="confidence-badge"
                                  style={{
                                    backgroundColor: getConfidenceColor(
                                      analysisResult.comparison.enhanced
                                        .confidence
                                    ),
                                  }}
                                >
                                  {(
                                    analysisResult.comparison.enhanced
                                      .confidence * 100
                                  ).toFixed(1)}
                                  %
                                </span>
                              </div>
                              <div className="comparison-item">
                                <strong>Sentiment:</strong>{" "}
                                {analysisResult.comparison.enhanced.sentiment}
                              </div>
                              <div className="comparison-item">
                                <strong>Entities:</strong>{" "}
                                {
                                  Object.keys(
                                    analysisResult.comparison.enhanced
                                      .entities || {}
                                  ).length
                                }
                              </div>
                              <div className="comparison-item">
                                <strong>Method:</strong>{" "}
                                {analysisResult.comparison.enhanced
                                  .processingMethod || "hybrid"}
                              </div>
                            </div>
                          </div>
                          <div className="test-message">
                            <strong>Test Message:</strong> "
                            {analysisResult.comparison.testMessage}"
                          </div>
                        </div>
                      )}
                    </div>
                  )}
                </div>
              )}
            </div>
          </div>
        )}

        {selectedDemo === "features" && (
          <div className="features-demo">
            <h3>Advanced NLP Features</h3>

            <div className="features-grid">
              <div className="feature-card">
                <h4>🎯 Enhanced Intent Recognition</h4>
                <p>
                  Weighted keyword matching with context awareness for more
                  accurate intent classification.
                </p>
                <ul>
                  <li>Multi-word phrase recognition</li>
                  <li>Context-based intent boosting</li>
                  <li>Confidence scoring for all intents</li>
                </ul>
              </div>

              <div className="feature-card">
                <h4>🔍 Advanced Entity Extraction</h4>
                <p>
                  Comprehensive entity recognition for automotive service
                  scenarios.
                </p>
                <ul>
                  <li>Vehicle information (make, model, year)</li>
                  <li>Service types and maintenance items</li>
                  <li>Contact information and scheduling</li>
                  <li>Pricing and mileage detection</li>
                </ul>
              </div>

              <div className="feature-card">
                <h4>😊 Sentiment Analysis</h4>
                <p>
                  Real-time emotion detection to provide appropriate responses.
                </p>
                <ul>
                  <li>Positive, negative, and neutral classification</li>
                  <li>Complaint and satisfaction detection</li>
                  <li>Emergency situation identification</li>
                </ul>
              </div>

              <div className="feature-card">
                <h4>🧠 Context Awareness</h4>
                <p>
                  Maintains conversation state for personalized interactions.
                </p>
                <ul>
                  <li>Customer information persistence</li>
                  <li>Vehicle history tracking</li>
                  <li>Conversation flow management</li>
                </ul>
              </div>

              <div className="feature-card">
                <h4>🔧 Spell Correction</h4>
                <p>
                  Automatic correction of common automotive terminology
                  misspellings.
                </p>
                <ul>
                  <li>Service-specific corrections</li>
                  <li>Text normalization</li>
                  <li>Abbreviation expansion</li>
                </ul>
              </div>

              <div className="feature-card">
                <h4>🤝 Smart Handoff</h4>
                <p>
                  Intelligent detection of when human intervention is needed.
                </p>
                <ul>
                  <li>Emergency situation detection</li>
                  <li>Low confidence threshold monitoring</li>
                  <li>Complaint escalation</li>
                </ul>
              </div>
            </div>
          </div>
        )}
      </div>
    </div>
  );
};

export default NLPDemo;
