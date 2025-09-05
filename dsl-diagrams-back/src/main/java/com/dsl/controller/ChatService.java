package com.dsl.controller;


import org.springframework.stereotype.Service;

import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

@Service
public class ChatService {
    
    // In-memory storage for demo (replace with database in production)
    private final Map<String, List<ChatMessage>> chatHistory = new ConcurrentHashMap<>();
    private final Map<String, UserContext> sessionContexts = new ConcurrentHashMap<>();

    public ChatMessageResponse generateResponse(String sessionId, String userMessage, NLPResult nlpResult, UserContext context) {
        
        // Get or create session context
        UserContext sessionContext = sessionContexts.getOrDefault(sessionId, new UserContext());
        if (context != null) {
            // Merge incoming context with session context
            mergeContext(sessionContext, context);
        }
        
        String intent = nlpResult.getIntent();
        Map<String, String> entities = nlpResult.getEntities();
        
        String responseMessage;
        List<QuickReply> quickReplies = new ArrayList<>();
        
        switch (intent) {
            case "greeting":
                responseMessage = handleGreeting(sessionContext, entities);
                quickReplies = Arrays.asList(
                    new QuickReply("I need service for my car"),
                    new QuickReply("I want to book an appointment"),
                    new QuickReply("Check my service history")
                );
                break;
                
            case "provide_name":
                responseMessage = handleNameProvision(sessionContext, entities);
                quickReplies = Arrays.asList(
                    new QuickReply("Yes, that's correct"),
                    new QuickReply("No, let me spell it")
                );
                break;
                
            case "vehicle_info":
                responseMessage = handleVehicleInfo(sessionContext, entities);
                quickReplies = getServiceQuickReplies();
                break;
                
            case "service_inquiry":
                responseMessage = handleServiceInquiry(sessionContext, entities);
                quickReplies = getServiceQuickReplies();
                break;
                
            case "booking_request":
                responseMessage = handleBookingRequest(sessionContext, entities);
                quickReplies = getTimeSlotQuickReplies();
                break;
                
            case "confirmation":
                responseMessage = handleConfirmation(sessionContext, entities);
                break;
                
            default:
                responseMessage = handleDefault(sessionContext);
                quickReplies = Arrays.asList(
                    new QuickReply("I need car service"),
                    new QuickReply("Book appointment"),
                    new QuickReply("Talk to human")
                );
        }
        
        // Update session context
        sessionContexts.put(sessionId, sessionContext);
        
        return new ChatMessageResponse(responseMessage, intent, sessionContext, quickReplies);
    }
    
    private String handleGreeting(UserContext context, Map<String, String> entities) {
        if (context.getCustomerName() != null) {
            return String.format("Welcome back, %s! How can I help you with your vehicle today?", context.getCustomerName());
        }
        
        // Check if name was provided in the greeting
        String name = entities.get("person_name");
        if (name != null) {
            context.setCustomerName(name);
            context.setConversationState("name_provided");
            return String.format("Nice to meet you, %s! I'm here to help with your automotive needs. What vehicle do you need service for?", name);
        }
        
        context.setConversationState("awaiting_name");
        return "Hello! I'm your auto service assistant. I can help you with vehicle maintenance, service bookings, and answer questions about your car. What's your name?";
    }
    
    private String handleNameProvision(UserContext context, Map<String, String> entities) {
        String name = entities.get("person_name");
        if (name != null) {
            context.setCustomerName(name);
            context.setConversationState("name_provided");
            return String.format("Nice to meet you, %s! What vehicle do you need service for? Please tell me the make, model, and year.", name);
        }
        return "I didn't catch your name. Could you please tell me your name again?";
    }
    
    private String handleVehicleInfo(UserContext context, Map<String, String> entities) {
        VehicleDTO vehicleDTO = context.getVehicle();
        if (vehicleDTO == null) {
            vehicleDTO = new VehicleDTO();
            context.setVehicle(vehicleDTO);
        }
        
        // Extract vehicle information from entities
        if (entities.containsKey("vehicle_make")) {
            vehicleDTO.setMake(entities.get("vehicle_make"));
        }
        if (entities.containsKey("vehicle_model")) {
            vehicleDTO.setModel(entities.get("vehicle_model"));
        }
        if (entities.containsKey("vehicle_year")) {
            try {
                vehicleDTO.setYear(Integer.parseInt(entities.get("vehicle_year")));
            } catch (NumberFormatException e) {
                // Handle invalid year
            }
        }

        context.setConversationState("vehicle_provided");
        
        if (vehicleDTO != null && vehicleDTO.getMake() != null && vehicleDTO.getModel() != null && vehicleDTO.getYear() != null) {
            return String.format("Great! I have your %d %s %s on file. What service do you need today?",
                vehicleDTO.getYear(), vehicleDTO.getMake(), vehicleDTO.getModel());
        } else {
            return "I need a bit more information about your vehicle. Could you tell me the make, model, and year? For example: '2020 Honda Civic'";
        }
    }

    private String handleServiceInquiry(UserContext context, Map<String, String> entities) {
        String service = entities.get("service_type");
        if (service != null) {
            context.setCurrentService(service);
            context.setConversationState("service_selected");
            
            return String.format("Perfect! I can help you with %s service. Based on your vehicle, this typically takes about 30-45 minutes and costs around $50-80. Would you like to schedule an appointment?", service);
        }
        
        return "What type of service do you need? We offer oil changes, tire rotations, brake inspections, and more.";
    }
    
    private String handleBookingRequest(UserContext context, Map<String, String> entities) {
        if (context.getVehicle() == null || context.getCurrentService() == null) {
            return "I'll need your vehicle information and the service you want before we can book an appointment. What car do you drive and what service do you need?";
        }
        
        context.setConversationState("booking_appointment");
        return "I'd be happy to schedule that for you! What day and time works best? We're open Monday-Friday 8AM-6PM and Saturday 9AM-4PM.";
    }
    
    private String handleConfirmation(UserContext context, Map<String, String> entities) {
        if ("booking_appointment".equals(context.getConversationState())) {
            context.setConversationState("appointment_confirmed");
            
            if (context.getVehicle() != null && context.getCurrentService() != null) {
                return String.format("Perfect! I've scheduled your %s appointment for your %s %s %s. You'll receive a confirmation text shortly. Is there anything else I can help you with?",
                    context.getCurrentService(),
                    context.getVehicle().getYear() != null ? context.getVehicle().getYear().toString() : "",
                    context.getVehicle().getMake() != null ? context.getVehicle().getMake() : "",
                    context.getVehicle().getModel() != null ? context.getVehicle().getModel() : "");
            } else {
                return "Perfect! I've scheduled your appointment. You'll receive a confirmation text shortly. Is there anything else I can help you with?";
            }
        }
        
        return "Thank you for confirming! Is there anything else I can help you with today?";
    }
    
    private String handleDefault(UserContext context) {
        return "I'm here to help with your automotive needs. You can ask me about services, schedule appointments, or get information about vehicle maintenance. What would you like to know?";
    }
    
    private List<QuickReply> getServiceQuickReplies() {
        return Arrays.asList(
            new QuickReply("Oil change"),
            new QuickReply("Tire rotation"),
            new QuickReply("Brake inspection"),
            new QuickReply("General maintenance")
        );
    }
    
    private List<QuickReply> getTimeSlotQuickReplies() {
        return Arrays.asList(
            new QuickReply("Tomorrow morning"),
            new QuickReply("This afternoon"),
            new QuickReply("Next week"),
            new QuickReply("Show available times")
        );
    }
    
    private void mergeContext(UserContext sessionContext, UserContext incomingContext) {
        if (incomingContext.getCustomerName() != null) {
            sessionContext.setCustomerName(incomingContext.getCustomerName());
        }
        if (incomingContext.getVehicle() != null) {
            sessionContext.setVehicle(incomingContext.getVehicle());
        }
        if (incomingContext.getCurrentService() != null) {
            sessionContext.setCurrentService(incomingContext.getCurrentService());
        }
        if (incomingContext.getConversationState() != null) {
            sessionContext.setConversationState(incomingContext.getConversationState());
        }
    }
    
    public void saveMessage(String sessionId, String message, String sender, String intent) {
        ChatMessage chatMessage = new ChatMessage(sessionId, message, sender, intent);
        chatHistory.computeIfAbsent(sessionId, k -> new ArrayList<>()).add(chatMessage);
    }
    
    public List<ChatMessage> getChatHistory(String sessionId) {
        return chatHistory.getOrDefault(sessionId, new ArrayList<>());
    }
    
    public UserContext updateContext(String sessionId, UserContext context) {
        sessionContexts.put(sessionId, context);
        return context;
    }
}