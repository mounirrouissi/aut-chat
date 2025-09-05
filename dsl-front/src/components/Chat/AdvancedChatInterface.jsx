import React, { useState, useEffect, useRef } from "react";
import "./AdvancedChat.css";

const AdvancedChatInterface = ({ initialContext = null }) => {
  const [messages, setMessages] = useState([]);
  const [inputMessage, setInputMessage] = useState("");
  const [sessionId, setSessionId] = useState(null);
  const [isTyping, setIsTyping] = useState(false);
  const [debugMode, setDebugMode] = useState(false);
  const [context, setContext] = useState({});
  const messagesEndRef = useRef(null);
  const API_BASE_URL = "http://localhost:8080/api/chat";

  useEffect(() => {
    // Initialize context from channel simulator if provided
    if (initialContext) {
      const mappedContext = {
        customerName: initialContext.customerInfo?.name || initialContext.customerName,
        customerId: initialContext.customerInfo?.customerId || initialContext.customerId,
        vehicle: initialContext.customerInfo?.vehicle || initialContext.vehicle,
        channel: initialContext.channel,
      };
      setContext(mappedContext);
      
      // Generate session ID
      const newSessionId = `session_${Date.now()}_${Math.random().toString(36).substring(2, 11)}`;
      setSessionId(newSessionId);
      
      // Create channel-specific welcome message
      const vehicleDisplay = mappedContext.vehicle 
        ? (typeof mappedContext.vehicle === 'string' 
            ? mappedContext.vehicle 
            : `${mappedContext.vehicle.year || ''} ${mappedContext.vehicle.make || ''} ${mappedContext.vehicle.model || ''}`.trim())
        : "vehicle";

      let welcomeText;
      switch (initialContext.channel) {
        case "sms":
          welcomeText = `Hi ${mappedContext.customerName}! I received your text message. I'm your advanced auto service assistant and I'm here to help you with your ${vehicleDisplay}. Let me assist you right away.`;
          break;
        case "email":
          welcomeText = `Hello ${mappedContext.customerName}, thank you for your email${
            initialContext.subject ? ` regarding "${initialContext.subject}"` : ""
          }. I'm your advanced auto service assistant and I'll help you with your inquiry about your ${vehicleDisplay}.`;
          break;
        default:
          welcomeText = `Hello ${mappedContext.customerName}! I'm your advanced auto service assistant. I'm here to help you with your ${vehicleDisplay}.`;
      }

      addMessage({
        text: welcomeText,
        sender: "bot",
        timestamp: new Date(),
        intent: "greeting",
        confidence: 1.0,
        sentiment: "positive",
      });

      // If there's an initial message, process it
      if (initialContext.initialMessage) {
        setTimeout(() => {
          addMessage({
            text: initialContext.initialMessage,
            sender: "user",
            timestamp: new Date(),
          });
          setInputMessage(initialContext.initialMessage);
          setTimeout(() => sendMessage(), 100);
        }, 500);
      }
    } else {
      // Default welcome message
      addMessage({
        text: "Hello! I'm your advanced auto service assistant. I can help with vehicle maintenance, service bookings, and answer questions about your car. What's your name?",
        sender: "bot",
        timestamp: new Date(),
        intent: "greeting",
        confidence: 1.0,
        sentiment: "positive",
      });
    }
  }, [initialContext]);

  useEffect(() => {
    scrollToBottom();
  }, [messages]);

  const scrollToBottom = () => {
    messagesEndRef.current?.scrollIntoView({ behavior: "smooth" });
  };

  const addMessage = (message) => {
    setMessages((prev) => [...prev, { ...message, id: Date.now() }]);
  };

  const sendMessage = async () => {
    debugger;
    if (!inputMessage.trim()) return;

    const userMessage = {
      text: inputMessage,
      sender: "user",
      timestamp: new Date(),
    };

    addMessage(userMessage);
    setInputMessage("");
    setIsTyping(true);

    try {
      const response = await fetch(
        "http://localhost:8080/api/v2/chat/message",
        {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify({
            message: inputMessage,
            sessionId: sessionId || `session_${Date.now()}`,
            context: context,
            timestamp: new Date().toISOString(),
          }),
        }
      );

      const data = await response.json();

      if (response.ok) {
        const sessionIdToUse = sessionId || `session_${Date.now()}`;
        setSessionId(sessionIdToUse);
        setContext(data.context || {});

        const botMessage = {
          text: data.message,
          sender: "bot",
          timestamp: new Date(),
          intent: data.intent,
          confidence: 0.8, // Default confidence since the basic API doesn't return this
          sentiment: "neutral", // Default sentiment
          entities: {}, // Default entities
          quickReplies: data.quickReplies || [],
          requiresHumanHandoff: false, // Default
          debug: debugMode
            ? {
                intent: data.intent,
                confidence: 0.8,
                sentiment: "neutral",
                entities: {},
              }
            : null,
        };

        addMessage(botMessage);
      } else {
        addMessage({
          text:
            data.message || "Sorry, I encountered an error. Please try again.",
          sender: "bot",
          timestamp: new Date(),
          type: "error",
        });
      }
    } catch (error) {
      addMessage({
        text: "I'm having trouble connecting. Please check your internet connection and try again.",
        sender: "bot",
        timestamp: new Date(),
        type: "error",
      });
    } finally {
      setIsTyping(false);
    }
  };

  const handleQuickReply = (reply) => {
    setInputMessage(reply.text);
    setTimeout(() => sendMessage(), 100);
  };

  const handleKeyPress = (e) => {
    if (e.key === "Enter" && !e.shiftKey) {
      e.preventDefault();
      sendMessage();
    }
  };

  const formatTimestamp = (timestamp) => {
    return new Date(timestamp).toLocaleTimeString([], {
      hour: "2-digit",
      minute: "2-digit",
    });
  };

  const getConfidenceColor = (confidence) => {
    if (confidence >= 0.8) return "#4CAF50";
    if (confidence >= 0.6) return "#FF9800";
    return "#F44336";
  };

  const getSentimentEmoji = (sentiment) => {
    switch (sentiment) {
      case "positive":
        return "😊";
      case "negative":
        return "😟";
      case "neutral":
        return "😐";
      default:
        return "";
    }
  };

  return (
    <div className="advanced-chat-container">
      <div className="chat-header">
        <h3>Advanced Auto Service Assistant</h3>
        <div className="chat-controls">
          <label className="debug-toggle">
            <input
              type="checkbox"
              checked={debugMode}
              onChange={(e) => setDebugMode(e.target.checked)}
            />
            Debug Mode
          </label>
        </div>
      </div>

      <div className="messages-container">
        {messages.map((message) => (
          <div key={message.id} className={`message ${message.sender}`}>
            <div className="message-content">
              <div className="message-text">{message.text}</div>

              {message.quickReplies && (
                <div className="quick-replies">
                  {message.quickReplies.map((reply, index) => (
                    <button
                      key={index}
                      className="quick-reply-btn"
                      onClick={() => handleQuickReply(reply)}
                    >
                      {reply.text}
                    </button>
                  ))}
                </div>
              )}

              {debugMode && message.sender === "bot" && message.debug && (
                <div className="debug-info">
                  <div className="debug-header">Debug Information</div>
                  <div className="debug-item">
                    <strong>Intent:</strong> {message.intent}
                    <span
                      className="confidence-badge"
                      style={{
                        backgroundColor: getConfidenceColor(message.confidence),
                      }}
                    >
                      {(message.confidence * 100).toFixed(1)}%
                    </span>
                    {message.debug?.processingMethod && (
                      <span className="processing-method">
                        ({message.debug.processingMethod})
                      </span>
                    )}
                  </div>
                  <div className="debug-item">
                    <strong>Sentiment:</strong> {message.sentiment}{" "}
                    {getSentimentEmoji(message.sentiment)}
                  </div>
                  {message.entities &&
                    Object.keys(message.entities).length > 0 && (
                      <div className="debug-item">
                        <strong>Entities:</strong>
                        <div className="entities-list">
                          {Object.entries(message.entities).map(
                            ([key, value]) => (
                              <span key={key} className="entity-tag">
                                {key}: {value}
                              </span>
                            )
                          )}
                        </div>
                      </div>
                    )}
                  {message.requiresHumanHandoff && (
                    <div className="debug-item handoff-indicator">
                      <strong>⚠️ Human handoff recommended</strong>
                    </div>
                  )}
                </div>
              )}
            </div>

            <div className="message-meta">
              <span className="timestamp">
                {formatTimestamp(message.timestamp)}
              </span>
              {!debugMode && message.sender === "bot" && message.confidence && (
                <span
                  className="confidence-indicator"
                  style={{ color: getConfidenceColor(message.confidence) }}
                  title={`Confidence: ${(message.confidence * 100).toFixed(
                    1
                  )}%`}
                >
                  ●
                </span>
              )}
            </div>
          </div>
        ))}

        {isTyping && (
          <div className="message bot typing">
            <div className="typing-indicator">
              <span></span>
              <span></span>
              <span></span>
            </div>
          </div>
        )}

        <div ref={messagesEndRef} />
      </div>

      <div className="input-container">
        <textarea
          value={inputMessage}
          onChange={(e) => setInputMessage(e.target.value)}
          onKeyPress={handleKeyPress}
          placeholder="Type your message here..."
          className="message-input"
          rows="1"
        />
        <button
          onClick={sendMessage}
          className="send-button"
          disabled={!inputMessage.trim() || isTyping}
        >
          Send
        </button>
      </div>
    </div>
  );
};

export default AdvancedChatInterface;
