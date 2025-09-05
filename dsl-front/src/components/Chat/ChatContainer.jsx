import React, { useState, useEffect, useCallback, useRef } from "react";
import MessageList from "./MessageList";
import ChatInput from "./ChatInput";
import TypingIndicator from "./TypingIndicator";
import { sendMessage } from "../../services/chatApi";
import "./Chat.css";

const ChatContainer = ({ initialContext = null }) => {
  const [messages, setMessages] = useState([]);
  const [isTyping, setIsTyping] = useState(false);
  const [sessionId, setSessionId] = useState(null);
  const [userContext, setUserContext] = useState({
    customerId: null,
    customerName: null,
    vehicle: null,
    currentService: null,
  });
  const [pendingInitialMessage, setPendingInitialMessage] = useState(null);
  const userContextRef = useRef(userContext);

  const getChannelWelcomeMessage = (channel, customerInfo) => {
    const vehicleDisplay = customerInfo.vehicle 
      ? (typeof customerInfo.vehicle === 'string' 
          ? customerInfo.vehicle 
          : `${customerInfo.vehicle.year || ''} ${customerInfo.vehicle.make || ''} ${customerInfo.vehicle.model || ''}`.trim())
      : "vehicle";

    switch (channel) {
      case "sms":
        return `Hi ${customerInfo.name}! I received your text message. I'm your auto service assistant and I'm here to help you with your ${vehicleDisplay}. Let me assist you right away.`;
      case "email":
        return `Hello ${customerInfo.name}, thank you for your email${
          customerInfo.subject ? ` regarding "${customerInfo.subject}"` : ""
        }. I'm your auto service assistant and I'll help you with your inquiry about your ${vehicleDisplay}.`;
      default:
        return `Hello ${customerInfo.name}! I'm your auto service assistant. I'm here to help you with your ${vehicleDisplay}.`;
    }
  };

  const handleSendMessage = useCallback(
    async (messageText, skipAddingMessage = false) => {
      if (!messageText.trim() || !sessionId) return;

      // Add user message to chat (unless it's already added from channel)
      if (!skipAddingMessage) {
        const userMessage = {
          id: Date.now(),
          text: messageText,
          sender: "user",
          timestamp: new Date().toISOString(),
        };

        console.log('Adding user message:', userMessage);
        setMessages((prev) => {
          console.log('Previous messages before adding user message:', prev);
          const newMessages = [...prev, userMessage];
          console.log('Messages after adding user message:', newMessages);
          return newMessages;
        });
      }
      setIsTyping(true);

      try {
        // Send message to backend
        const response = await sendMessage({
          sessionId,
          message: messageText,
          context: userContextRef.current,
        });

        console.log('Backend response:', response);

        // Add bot response to chat
        const botMessage = {
          id: Date.now() + 1,
          text: response.message || "I'm here to help with your automotive needs. How can I assist you?",
          sender: "bot",
          timestamp: new Date().toISOString(),
          intent: response.intent,
          quickReplies: response.quickReplies || [],
        };

        console.log('Bot message to add:', botMessage);
        
        setMessages((prev) => [...prev, botMessage]);

        // Update user context if provided
        if (response.context) {
          setUserContext((prev) => {
            const newContext = { ...prev, ...response.context };
            userContextRef.current = newContext;
            return newContext;
          });
        }
      } catch (error) {
        console.error("Error sending message:", error);

        // Add error message
        const errorMessage = {
          id: Date.now() + 1,
          text: "Sorry, I'm having trouble connecting. Please try again.",
          sender: "bot",
          timestamp: new Date().toISOString(),
          isError: true,
        };

        setMessages((prev) => [...prev, errorMessage]);
      } finally {
        setIsTyping(false);
      }
    },
    [sessionId]
  );

  // Initialize session and handle initial context
  useEffect(() => {
    const initializeSession = async () => {
      try {
        // Generate a new session ID
        const newSessionId = `session_${Date.now()}_${Math.random()
          .toString(36)
          .substring(2, 11)}`;
        setSessionId(newSessionId);

        // Set initial context if provided
        if (initialContext) {
          // Map the customer info properly
          const mappedContext = {
            ...initialContext,
            customerName:
              initialContext.customerInfo?.name || initialContext.customerName,
            customerId:
              initialContext.customerInfo?.customerId ||
              initialContext.customerId,
            vehicle:
              initialContext.customerInfo?.vehicle || initialContext.vehicle,
          };

          setUserContext((prev) => {
            const newContext = { ...prev, ...mappedContext };
            userContextRef.current = newContext;
            return newContext;
          });

          // If there's an initial message from a channel, store it
          if (initialContext.initialMessage) {
            setPendingInitialMessage(initialContext.initialMessage);
          }
        }
      } catch (error) {
        console.error("Error initializing session:", error);
      }
    };

    initializeSession();
  }, [initialContext]);

  // Handle welcome message and initial message processing
  useEffect(() => {
    if (!sessionId) return;

    const processInitialMessage = async () => {
      // Add welcome message
      const welcomeMessage = {
        id: Date.now(),
        text: userContext.customerName
          ? getChannelWelcomeMessage(initialContext?.channel || "default", {
              name: userContext.customerName,
              vehicle: userContext.vehicle,
              subject: initialContext?.subject,
            })
          : "Hello! I'm your auto service assistant. How can I help you today?",
        sender: "bot",
        timestamp: new Date().toISOString(),
      };

      setMessages([welcomeMessage]);

      // If there's a pending initial message, process it
      if (pendingInitialMessage) {
        // Add the initial user message
        const initialUserMessage = {
          id: Date.now() + 1,
          text: pendingInitialMessage,
          sender: "user",
          timestamp: new Date().toISOString(),
        };

        setMessages((prev) => [...prev, initialUserMessage]);

        // Process the initial message through the bot
        setTimeout(() => {
          handleSendMessage(pendingInitialMessage, true);
        }, 100);

        setPendingInitialMessage(null);
      }
    };

    processInitialMessage();
  }, [sessionId, pendingInitialMessage]);

  const handleQuickReply = (replyText) => {
    handleSendMessage(replyText);
  };

  return (
    <div className="chat-container">
      <div className="chat-header">
        <h3>Auto Service Assistant</h3>
        {userContext.customerName && (
          <span className="customer-info">
            Welcome, {userContext.customerName}
            {userContext.vehicle && (() => {
              if (typeof userContext.vehicle === 'string') {
                return ` | ${userContext.vehicle}`;
              } else {
                const vehicleStr = `${userContext.vehicle.year || ''} ${userContext.vehicle.make || ''} ${userContext.vehicle.model || ''}`.trim();
                return vehicleStr ? ` | ${vehicleStr}` : '';
              }
            })()}
          </span>
        )}
      </div>

      <MessageList messages={messages} onQuickReply={handleQuickReply} />

      {isTyping && <TypingIndicator />}

      <ChatInput onSendMessage={handleSendMessage} disabled={isTyping} />
    </div>
  );
};

export default ChatContainer;
