package com.dsl.service;

import com.dsl.controller.*;
import com.dsl.entity.*;
import com.dsl.repository.*;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.*;

@Service
@Transactional
@AllArgsConstructor
public class DatabaseChatService {
    @Autowired
    private ChatMessageRepository chatMessageRepository;
    @Autowired
    private ChatSessionRepository chatSessionRepository;
    @Autowired
    private CustomerRepository customerRepository;
    @Autowired
    private VehicleRepository vehicleRepository;

    @Autowired
    private ServiceRepository serviceRepository;

    @Autowired
    private AppointmentRepository appointmentRepository;

    @Autowired
    private ServiceHistoryRepository serviceHistoryRepository;

    @Autowired
    private EnhancedNLPService enhancedNLPService;

    public DatabaseChatService() {
    }

    public ChatMessageResponse processMessage(String sessionId, String userMessage, UserContext context) {
        // Use enhanced NLP service for processing
        NLPResult nlpResult = enhancedNLPService.processMessage(userMessage, context);

        // Generate response using the NLP result
        return generateResponse(sessionId, userMessage, nlpResult, context);
    }

    public ChatMessageResponse generateResponse(String sessionId, String userMessage, NLPResult nlpResult,
            UserContext context) {

        // Get or create chat session
        ChatSession session = getOrCreateSession(sessionId);

        // Save user message
        ChatMessage userMsg = new ChatMessage(session, userMessage, MessageSender.USER, nlpResult.getIntent());
        userMsg.setEntities(convertEntitiesToMap(nlpResult.getEntities()));
        userMsg.setConfidence(BigDecimal.valueOf(nlpResult.getConfidence()));
        chatMessageRepository.save(userMsg);

        // Update session context
        updateSessionContext(session, context);

        // Generate response based on intent and context
        String responseMessage;
        List<QuickReply> quickReplies = new ArrayList<>();
        UserContext updatedContext = mergeContextFromSession(session, context);

        String intent = nlpResult.getIntent();
        Map<String, String> entities = nlpResult.getEntities();

        // Check conversation state for context-specific handling
        String conversationState = updatedContext.getConversationState();

        // Override intent based on conversation state
        if ("tire_service_options".equals(conversationState) &&
                ("tire_service_choice".equals(intent) || isValidTireChoice(userMessage))) {
            intent = "tire_service_choice";
        } else if ("oil_diagnosis_needed".equals(conversationState) &&
                ("oil_service_choice".equals(intent) || isValidOilChoice(userMessage))) {
            intent = "oil_service_choice";
        } else if ("oil_service_selection".equals(conversationState) ||
                "tire_service_selection".equals(conversationState)) {
            intent = "service_selection";
        } else if ("time_expression".equals(intent) && 
                   ("booking_appointment".equals(conversationState) || 
                    "scheduling_declined".equals(conversationState) ||
                    "time_declined".equals(conversationState) ||
                    "service_selected".equals(conversationState))) {
            intent = "time_preference";
        } else if ("time_expression".equals(intent)) {
            // Handle time expressions in any context as scheduling intent
            intent = "scheduling_request";
        }

        switch (intent) {
            case "greeting":
                responseMessage = handleGreeting(updatedContext, entities, session);
                quickReplies = getGreetingQuickReplies();
                break;

            case "provide_name":
                responseMessage = handleNameProvision(updatedContext, entities, session);
                quickReplies = getVehicleInfoQuickReplies();
                break;

            case "vehicle_info":
                responseMessage = handleVehicleInfo(updatedContext, entities, session);
                quickReplies = getServiceQuickReplies();
                break;

            case "service_inquiry":
                responseMessage = handleServiceInquiry(updatedContext, entities, session);
                quickReplies = getBookingQuickReplies();
                break;

            case "booking_request":
                responseMessage = handleBookingRequest(updatedContext, entities, session);
                quickReplies = getTimeSlotQuickReplies();
                break;

            case "confirmation":
                responseMessage = handleConfirmation(updatedContext, entities, session);
                break;

            case "negation":
                responseMessage = handleNegation(updatedContext, entities, session, userMessage);
                quickReplies = getNegationQuickReplies(updatedContext);
                break;

            case "emergency":
                responseMessage = handleEmergency(updatedContext, entities, session, userMessage);
                quickReplies = getEmergencyQuickReplies();
                break;

            case "complaint":
                responseMessage = handleComplaint(updatedContext, entities, session);
                quickReplies = getComplaintQuickReplies();
                break;

            case "tire_assistance":
                responseMessage = handleTireAssistance(updatedContext, entities, session, userMessage);
                quickReplies = getTireAssistanceQuickReplies();
                break;

            case "tire_service_choice":
                responseMessage = handleTireServiceChoice(updatedContext, userMessage, session);
                quickReplies = getTireLocationQuickReplies();
                break;

            case "location_provided":
                responseMessage = handleLocationProvided(updatedContext, entities, session);
                quickReplies = getTireConfirmationQuickReplies();
                break;

            case "oil_assistance":
                responseMessage = handleOilAssistance(updatedContext, entities, session, userMessage);
                // Set quick replies based on conversation state
                if ("oil_service_selection".equals(updatedContext.getConversationState())) {
                    quickReplies = getOilAssistanceQuickReplies();
                } else {
                    quickReplies = getOilAssistanceQuickReplies();
                }
                break;

            case "oil_service_choice":
                responseMessage = handleOilServiceChoice(updatedContext, userMessage, session);
                quickReplies = getOilLocationQuickReplies();
                break;

            case "service_selection":
                responseMessage = handleServiceSelection(updatedContext, userMessage, session);
                quickReplies = getServiceBookingQuickReplies();
                break;
                
            case "time_preference":
                responseMessage = handleTimePreference(updatedContext, userMessage, session);
                quickReplies = getTimeConfirmationQuickReplies();
                break;
                
            case "scheduling_request":
                responseMessage = handleSchedulingRequest(updatedContext, userMessage, session);
                quickReplies = getSchedulingQuickReplies();
                break;

            default:
                // responseMessage = handleDefault(updatedContext, userMessage);
                responseMessage = "I'm here to help with your automotive needs. Could you please provide more details or specify what assistance you require?";
                quickReplies = getDefaultQuickReplies();
        }

        // Save bot response
        ChatMessage botMsg = new ChatMessage(session, responseMessage, MessageSender.BOT, intent);
        chatMessageRepository.save(botMsg);

        // Update session activity
        session.setLastActivity(LocalDateTime.now());
        chatSessionRepository.save(session);

        return new ChatMessageResponse(responseMessage, intent, updatedContext, quickReplies);
    }

    private ChatSession getOrCreateSession(String sessionId) {
        return chatSessionRepository.findBySessionId(sessionId)
                .orElseGet(() -> {
                    ChatSession newSession = new ChatSession(sessionId);
                    return chatSessionRepository.save(newSession);
                });
    }

    private void updateSessionContext(ChatSession session, UserContext context) {
        if (context != null) {
            Map<String, Object> contextData = session.getContextData();
            if (contextData == null) {
                contextData = new HashMap<>();
            }

            if (context.getCustomerName() != null) {
                contextData.put("customerName", context.getCustomerName());
            }
            if (context.getVehicle() != null) {
                contextData.put("vehicle", convertVehicleToMap(context.getVehicle()));
            }
            if (context.getCurrentService() != null) {
                contextData.put("currentService", context.getCurrentService());
            }
            if (context.getConversationState() != null) {
                contextData.put("conversationState", context.getConversationState());
            }

            session.setContextData(contextData);
        }
    }

    private UserContext mergeContextFromSession(ChatSession session, UserContext incomingContext) {
        UserContext context = incomingContext != null ? incomingContext : new UserContext();

        Map<String, Object> sessionData = session.getContextData();
        if (sessionData != null) {
            if (context.getCustomerName() == null && sessionData.containsKey("customerName")) {
                context.setCustomerName((String) sessionData.get("customerName"));
            }
            if (context.getVehicle() == null && sessionData.containsKey("vehicle")) {
                context.setVehicle(convertMapToVehicle((Map<String, Object>) sessionData.get("vehicle")));
            }
            if (context.getCurrentService() == null && sessionData.containsKey("currentService")) {
                context.setCurrentService((String) sessionData.get("currentService"));
            }
            if (context.getConversationState() == null && sessionData.containsKey("conversationState")) {
                context.setConversationState((String) sessionData.get("conversationState"));
            }
        }

        return context;
    }

    private String handleGreeting(UserContext context, Map<String, String> entities, ChatSession session) {
        // Check if we have an existing customer
        if (context.getCustomerId() != null) {
            Optional<Customer> customer = customerRepository.findById(context.getCustomerId());
            if (customer.isPresent()) {
                session.setCustomer(customer.get());
                return String.format("Welcome back, %s! How can I help you with your vehicle today?",
                        customer.get().getFirstName());
            }
        }

        // Check if name was provided in greeting
        String name = entities.get("person_name");
        if (name != null) {
            // Try to find existing customer
            List<Customer> customers = customerRepository.searchByName(name);
            if (!customers.isEmpty()) {
                Customer customer = customers.get(0);
                session.setCustomer(customer);
                context.setCustomerId(customer.getId());
                context.setCustomerName(customer.getFullName());
                return String.format("Welcome back, %s! I see you have a %s. How can I help you today?",
                        customer.getFirstName(), getCustomerVehicleInfo(customer));
            } else {
                context.setCustomerName(name);
                context.setConversationState("new_customer");
                return String.format(
                        "Nice to meet you, %s! I'm here to help with your automotive needs. What vehicle do you need service for?",
                        name);
            }
        }

        return "Hey! 👋 I'm AutoAssist. What can I help you with today?";
    }

    /*
     * private String handleNameProvision(UserContext context, Map<String, String>
     * entities, ChatSession session) {
     * String name = entities.get("person_name");
     * if (name != null) {
     * context.setCustomerName(name);
     * 
     * // Try to find existing customer
     * List<Customer> customers = customerRepository.searchByName(name);
     * if (!customers.isEmpty()) {
     * Customer customer = customers.get(0);
     * session.setCustomer(customer);
     * context.setCustomerId(customer.getId());
     * context.setCustomerName(customer.getFullName());
     * }
     * 
     * // Check if this is part of tire assistance flow
     * if ("tire_assistance_need_name".equals(context.getConversationState())) {
     * context.setConversationState("tire_service_options");
     * return String.
     * format("Thanks, %s — I've got you. Here's what we can do for tire problems:\n\n"
     * +
     * "• Replace the tire (we bring a matching spare and swap it on-site)\n" +
     * "• Temporary inflation & patch (gets you to a nearby garage if the spare isn't available)\n"
     * +
     * "• Mobile repair estimate (technician will check the puncture and tell you if it's repairable)\n\n"
     * +
     * "I can send a technician now. I have two options:\n" +
     * "• Immediate dispatch — technician arrives in ~20–30 minutes\n" +
     * "• Scheduled — set a time that suits you (e.g., 10:30 AM or 2:00 PM)\n\n" +
     * "Which do you prefer, %s? (You can also type your location now so I can confirm ETA.)"
     * ,
     * name, name);
     * }
     * 
     * // Regular name provision flow
     * if (!customers.isEmpty()) {
     * Customer customer = customers.get(0);
     * List<Vehicle> vehicles =
     * vehicleRepository.findByCustomerId(customer.getId());
     * if (!vehicles.isEmpty()) {
     * Vehicle primaryVehicle = vehicles.get(0);
     * context.setVehicle(convertEntityToDto(primaryVehicle));
     * return String.
     * format("Great to see you again, %s! I see you have a %s. What service do you need today?"
     * ,
     * customer.getFirstName(), primaryVehicle.getDisplayName());
     * }
     * return
     * String.format("Welcome back, %s! What vehicle do you need service for?",
     * customer.getFirstName());
     * } else {
     * context.setConversationState("new_customer");
     * return String.
     * format("Nice to meet you, %s! What vehicle do you need service for? Please tell me the make, model, and year."
     * , name);
     * }
     * }
     * return "I didn't catch your name. Could you please tell me your name again?";
     * }
     */

    private String handleNameProvision(UserContext context, Map<String, String> entities, ChatSession session) {
        String name = entities.get("person_name");
        if (name != null) {
            context.setCustomerName(name);

            // Try to find existing customer
            List<Customer> customers = customerRepository.searchByName(name);
            if (!customers.isEmpty()) {
                Customer customer = customers.get(0);
                session.setCustomer(customer);
                context.setCustomerId(customer.getId());
                context.setCustomerName(customer.getFullName());
            }

            // Check if this is part of tire assistance flow
            if ("tire_assistance_need_name".equals(context.getConversationState())) {
                context.setConversationState("tire_service_options");
                return String.format("Thanks, %s — I've got you. Here are your tire service options:", name);
            }

            // Regular name provision flow
            if (!customers.isEmpty()) {
                Customer customer = customers.get(0);
                List<Vehicle> vehicles = vehicleRepository.findByCustomerId(customer.getId());
                if (!vehicles.isEmpty()) {
                    Vehicle primaryVehicle = vehicles.get(0);
                    context.setVehicle(convertEntityToDto(primaryVehicle));
                    return String.format(
                            "Great to see you again, %s! I see you have a %s. What service do you need today?",
                            customer.getFirstName(), primaryVehicle.getDisplayName());
                }
                return String.format("Welcome back, %s! What vehicle do you need service for?",
                        customer.getFirstName());
            } else {
                context.setConversationState("new_customer");
                return String.format(
                        "Nice to meet you, %s! What vehicle do you need service for? Please tell me the make, model, and year.",
                        name);
            }
        }
        return "I didn't catch your name. Could you please tell me your name again?";
    }

    private String handleVehicleInfo(UserContext context, Map<String, String> entities, ChatSession session) {
        String make = entities.get("vehicle_make");
        String model = entities.get("vehicle_model");
        String yearStr = entities.get("vehicle_year");

        if (make != null) {
            VehicleDTO vehicleDto = context.getVehicle();
            if (vehicleDto == null) {
                vehicleDto = new VehicleDTO();
                context.setVehicle(vehicleDto);
            }

            vehicleDto.setMake(make);
            if (model != null)
                vehicleDto.setModel(model);
            if (yearStr != null) {
                try {
                    vehicleDto.setYear(Integer.parseInt(yearStr));
                } catch (NumberFormatException e) {
                    // Handle invalid year
                }
            }

            // If we have a customer, try to find or create the vehicle
            if (session.getCustomer() != null) {
                List<Vehicle> existingVehicleDTOS = vehicleRepository.findByCustomerIdAndMake(
                        session.getCustomer().getId(), make);

                if (!existingVehicleDTOS.isEmpty()) {
                    Vehicle vehicleDTO = existingVehicleDTOS.get(0);
                    context.setVehicle(convertEntityToDto(vehicleDTO));

                    // Get service recommendations
                    List<ServiceHistory> history = serviceHistoryRepository
                            .findByVehicleIdOrderByServiceDateDesc(vehicleDTO.getId());
                    String recommendations = getServiceRecommendations(vehicleDTO, history);

                    return String.format("Perfect! I have your %s on file. %s What service do you need today?",
                            vehicleDTO.getDisplayName(), recommendations);
                }
            }

            context.setConversationState("vehicle_provided");
            return String.format("Great! I have your %s %s %s. What service do you need today?",
                    yearStr != null ? yearStr : "", make, model != null ? model : "");
        }

        return "I need a bit more information about your vehicle. Could you tell me the make, model, and year? For example: '2020 Honda Civic'";
    }

    private String handleServiceInquiry(UserContext context, Map<String, String> entities, ChatSession session) {
        String serviceType = entities.get("service_type");
        if (serviceType != null) {
            // Find matching service
            List<com.dsl.entity.Service> services = serviceRepository.searchByNameOrDescription(serviceType);
            if (!services.isEmpty()) {
                com.dsl.entity.Service service = services.get(0);
                context.setCurrentService(service.getName());

                return String.format(
                        "Perfect! I can help you with %s. This service typically takes about %d minutes and costs $%.2f. Would you like to schedule an appointment?",
                        service.getName(), service.getDurationMinutes(), service.getPrice());
            }

            context.setCurrentService(serviceType);
            return String.format("I can help you with %s service. Would you like to schedule an appointment?",
                    serviceType);
        }

        return "What type of service do you need? We offer oil changes, tire rotations, brake inspections, and more.";
    }

    private String handleBookingRequest(UserContext context, Map<String, String> entities, ChatSession session) {
        if (context.getVehicle() == null || context.getCurrentService() == null) {
            return "I'll need your vehicle information and the service you want before we can book an appointment. What car do you drive and what service do you need?";
        }

        // Check availability and suggest times
        List<String> availableSlots = getAvailableTimeSlots();
        context.setConversationState("booking_appointment");

        return String.format(
                "I'd be happy to schedule your %s for your %s. Here are some available times: %s. Which works best for you?",
                context.getCurrentService(),
                getVehicleDisplayName(context.getVehicle()),
                String.join(", ", availableSlots.subList(0, Math.min(3, availableSlots.size()))));
    }

    private String handleEmergency(UserContext context, Map<String, String> entities, ChatSession session,
            String userMessage) {
        context.setConversationState("emergency_mode");
        context.setEmergencyMode(true);

        // Analyze the emergency type and symptoms
        String emergencyType = analyzeEmergencyType(userMessage);
        String location = entities.get("location");
        String symptom = entities.get("car_symptom");

        StringBuilder response = new StringBuilder();

        if (emergencyType.equals("wont_start")) {
            response.append(
                    "I'm sorry to hear that your car won't start and you're stuck. Let me help you right away. ");

            // Check for specific symptoms mentioned
            if (symptom != null && symptom.toLowerCase().contains("click")) {
                response.append("You mentioned it clicks - that usually indicates a weak or dead battery. ");
                context.setConversationState("battery_issue_diagnosed");
                context.setEmergencyType("battery_dead");
            } else if (userMessage.toLowerCase().contains("click")) {
                response.append("Thank you, that clicking sound usually indicates a weak or dead battery. ");
                context.setConversationState("battery_issue_diagnosed");
                context.setEmergencyType("battery_dead");
            } else {
                response.append("Could you tell me if the car makes any sound when you try to start it? ");
                context.setConversationState("diagnosing_startup_issue");
            }
        } else if (emergencyType.equals("breakdown")) {
            response.append(
                    "I understand you're having car trouble and are stranded. I'm here to help get you back on the road safely. ");
            context.setConversationState("diagnosing_breakdown");
        } else {
            response.append("I can see this is urgent. Let me get you the help you need right away. ");
        }

        // Handle location information
        if (location != null) {
            response.append(String.format("Got it ✅. I've pinned your location at %s. ", location));
            context.setCurrentLocation(location);

            if ("battery_issue_diagnosed".equals(context.getConversationState())) {
                response.append(
                        "The nearest technician is about 15 minutes away. Would you like me to also check if your battery needs replacement while they're there?");
                context.setConversationState("roadside_dispatched");
            }
        } else if ("battery_issue_diagnosed".equals(context.getConversationState())) {
            response.append(
                    "I can send roadside assistance to jump-start your car. Can you share your current location so I can dispatch help?");
        }

        return response.toString();
    }

    private String handleComplaint(UserContext context, Map<String, String> entities, ChatSession session) {
        context.setConversationState("handling_complaint");

        return "I understand your concern and I sincerely apologize for any inconvenience. Your satisfaction is very important to us. "
                +
                "Let me connect you with a specialist who can address this issue properly and make things right. " +
                "In the meantime, could you please provide more details about what happened?";
    }

    private String handleTireAssistance(UserContext context, Map<String, String> entities, ChatSession session,
            String userMessage) {
        context.setConversationState("tire_assistance");
        context.setCurrentService("tire_assistance");

        // Check if we need to ask for name first
        if (context.getCustomerName() == null && session.getCustomer() == null) {
            context.setConversationState("tire_assistance_need_name");
            return "Sorry that happened — that sounds like a tire problem. Before I arrange help, may I have your name please?";
        }

        // If we have the name, provide detailed tire service options
        String customerName = context.getCustomerName() != null ? context.getCustomerName()
                : (session.getCustomer() != null ? session.getCustomer().getFirstName() : "");

        if ("tire_assistance_need_name".equals(context.getConversationState()) && !customerName.isEmpty()) {
            context.setConversationState("tire_service_selection");
            return String.format("Thanks, %s — I've got you. Here are the available tire services:", customerName);
        }

        // For general tire assistance, show available services
        if (customerName != null && !customerName.isEmpty()) {
            context.setConversationState("tire_service_selection");
            return String.format("I can help with your tire issue, %s. Here are the available tire services:",
                    customerName);
        }

        return "I can help with your tire issue. What specific problem are you experiencing?";
    }

    private String handleTireServiceChoice(UserContext context, String choice, ChatSession session) {
        String customerName = context.getCustomerName() != null ? context.getCustomerName()
                : (session.getCustomer() != null ? session.getCustomer().getFirstName() : "");

        switch (choice.toLowerCase()) {
            case "replace the tire":
                context.setConversationState("tire_replacement_selected");
                return String.format(
                        "Perfect choice, %s! I'll send a technician with a matching tire to replace it on-site. " +
                                "This typically takes 15-20 minutes. Can you share your current location so I can dispatch help?",
                        customerName);

            case "temporary patch":
                context.setConversationState("tire_patch_selected");
                return String.format("Good option, %s! I'll send someone to temporarily patch and inflate your tire. " +
                        "This will get you safely to a nearby garage for a permanent fix. Where are you located?",
                        customerName);

            case "mobile repair estimate":
                context.setConversationState("tire_estimate_selected");
                return String.format(
                        "Smart approach, %s! I'll send a technician to assess the damage and provide a repair estimate. "
                                +
                                "They'll tell you if it's repairable or needs replacement. What's your location?",
                        customerName);

            case "immediate dispatch":
                context.setConversationState("tire_immediate_dispatch");
                return String.format("Understood, %s! I'll dispatch the nearest technician right away. " +
                        "They'll arrive in approximately 20-30 minutes. Please share your location to confirm the ETA.",
                        customerName);

            case "schedule for later":
                context.setConversationState("tire_scheduled_service");
                return String.format("No problem, %s! When would you like to schedule the tire service? " +
                        "I have availability today at 2:00 PM, 4:00 PM, or tomorrow morning at 9:00 AM.", customerName);

            default:
                return "I didn't catch that option. Please choose from the available tire service options.";
        }
    }

    private String handleOilAssistance(UserContext context, Map<String, String> entities, ChatSession session,
            String userMessage) {
        context.setConversationState("oil_assistance");
        context.setCurrentService("oil_assistance");

        String oilIssue = entities.get("oil_issue");
        String location = entities.get("location");

        StringBuilder response = new StringBuilder();

        // Analyze the specific oil problem
        String lowerMessage = userMessage.toLowerCase();

        if (lowerMessage.contains("oil light")) {
            response.append("Thanks for letting me know. That oil light means your engine oil is low. ");
            response.append("I can send oil delivery and refill service. Would you like me to arrange that now?");
            context.setConversationState("oil_light_on");

        } else if (lowerMessage.contains("out of oil") || lowerMessage.contains("empty")) {
            response.append(
                    "Of course. I'll send a technician with engine oil to top up your car so you can drive safely again. ");
            response.append("Can you share your location?");
            context.setConversationState("oil_empty");
            context.setEmergencyMode(true); // Empty oil is urgent

        } else if (lowerMessage.contains("engine fluids")) {
            response.append(
                    "Yes, we provide oil assistance. If your oil is low or empty, we can deliver and refill it for you. ");
            response.append("Is that what you need right now?");
            context.setConversationState("oil_service_inquiry");

        } else if (lowerMessage.contains("low oil")) {
            response.append(
                    "I can help with low oil. We'll send someone to check your oil level and top it up if needed. ");
            response.append("Where are you located?");
            context.setConversationState("oil_low");

        } else {
            response.append("I can help with oil-related services. Here are the available oil services:");
            context.setConversationState("oil_service_selection");
        }

        // Handle location if provided
        if (location != null) {
            context.setCurrentLocation(location);
            response.append(String.format(" I have your location as %s.", location));
        }

        return response.toString();
    }

    private String handleConfirmation(UserContext context, Map<String, String> entities, ChatSession session) {
        String conversationState = context.getConversationState();

        if ("booking_appointment".equals(conversationState)) {
            // Create the appointment
            if (session.getCustomer() != null && context.getVehicle() != null && context.getCurrentService() != null) {
                try {
                    createAppointment(session.getCustomer(), context);
                    context.setConversationState("appointment_confirmed");
                    return String.format(
                            "Perfect! I've scheduled your %s appointment for your %s. You'll receive a confirmation shortly. Is there anything else I can help you with?",
                            context.getCurrentService(), getVehicleDisplayName(context.getVehicle()));
                } catch (Exception e) {
                    return "I'm sorry, there was an issue scheduling your appointment. Let me try again or you can call us directly.";
                }
            }
        } else if ("battery_issue_diagnosed".equals(conversationState)) {
            // User confirmed they want roadside assistance
            if (context.getCurrentLocation() != null) {
                context.setConversationState("roadside_dispatched");
                return String.format(
                        "Great! ✅ I've dispatched roadside assistance to %s. The nearest technician is about 15 minutes away. "
                                +
                                "Would you like me to also check if your battery needs replacement while they're there?",
                        context.getCurrentLocation());
            } else {
                return "I'll be happy to send roadside assistance. Can you please share your current location?";
            }
        } else if ("roadside_dispatched".equals(conversationState)) {
            // User confirmed they want battery check
            context.setConversationState("full_service_scheduled");
            return "Perfect! I've noted that for a battery replacement check. You'll receive a text update when the technician is on the way. "
                    +
                    "For your safety, please stay inside your vehicle with hazard lights on. 🚨 " +
                    "I'll stay connected and update you every 5 minutes until help arrives.";
        } else if ("tire_assistance".equals(conversationState) || "punctured_tire".equals(conversationState)) {
            // User confirmed tire service
            if (context.getCurrentLocation() != null) {
                context.setConversationState("tire_service_dispatched");
                return String.format(
                        "Excellent! I've dispatched a tire technician to %s. They'll arrive in about 20-30 minutes with the necessary equipment. "
                                +
                                "Please stay safe and keep your hazard lights on if you're on the roadside. 🚨",
                        context.getCurrentLocation());
            } else {
                return "Great! I'll arrange tire assistance. Can you please share your current location so I can dispatch help?";
            }
        } else if ("oil_assistance".equals(conversationState) || "oil_light_on".equals(conversationState)
                || "oil_empty".equals(conversationState)) {
            // User confirmed oil service
            if (context.getCurrentLocation() != null) {
                context.setConversationState("oil_service_dispatched");
                String urgencyNote = "oil_empty".equals(conversationState) ? "This is urgent since you're out of oil. "
                        : "";
                return String.format(
                        "Perfect! %sI've arranged oil service to %s. A technician will arrive in 15-25 minutes with fresh engine oil. "
                                +
                                "Please avoid driving until they arrive to prevent engine damage.",
                        urgencyNote, context.getCurrentLocation());
            } else {
                return "Understood! I'll send oil assistance. Can you please share your location so I can dispatch a technician?";
            }
        }

        return "Thank you for confirming! Is there anything else I can help you with today?";
    }

    private String analyzeEmergencyType(String message) {
        String lowerMessage = message.toLowerCase();

        if (lowerMessage.contains("won't start") || lowerMessage.contains("wont start") ||
                lowerMessage.contains("doesn't start") || lowerMessage.contains("not starting")) {
            return "wont_start";
        } else if (lowerMessage.contains("broke down") || lowerMessage.contains("broken down") ||
                lowerMessage.contains("stuck") || lowerMessage.contains("stranded")) {
            return "breakdown";
        } else if (lowerMessage.contains("accident") || lowerMessage.contains("crash")) {
            return "accident";
        } else if (lowerMessage.contains("smoke") || lowerMessage.contains("fire") ||
                lowerMessage.contains("burning")) {
            return "fire_hazard";
        }

        return "general_emergency";
    }

    private String handleDefault(UserContext context) {
        String conversationState = context.getConversationState();

        // Emergency mode responses
        if ("diagnosing_startup_issue".equals(conversationState)) {
            return "Please let me know what sounds your car makes when you try to start it - this will help me diagnose the issue better.";
        } else if ("battery_issue_diagnosed".equals(conversationState)) {
            if (context.getCurrentLocation() != null) {
                return "I'm ready to send roadside assistance for a jump-start to " + context.getCurrentLocation() +
                        ". Should I dispatch them now?";
            } else {
                return "I'm ready to send roadside assistance for a jump-start. I just need your location to dispatch help.";
            }
        } else if ("roadside_dispatched".equals(conversationState)) {
            return "Your roadside assistance is on the way! I'll keep you updated. In the meantime, please stay safe in your vehicle with hazard lights on. 🚨";
        } else if ("full_service_scheduled".equals(conversationState)) {
            return "Everything is set up! The technician will be there soon and will also check your battery. I'll update you every 5 minutes until they arrive.";
        } else if ("emergency_mode".equals(conversationState)) {
            return "I'm still here to help with your emergency. What additional information can you provide?";
        }

        // Handle location-only messages during emergency
        if (context.isEmergencyMode() && context.getCurrentLocation() == null) {
            // Check if the message might be a location
            // String location = extractLocationFromMessage(userMessage);
            String location = "ATlanta GA"; // Placeholder for actual extraction logic
            if (location != null) {
                context.setCurrentLocation(location);
                if ("battery_issue_diagnosed".equals(conversationState)) {
                    return String.format(
                            "Got it ✅. I've pinned your location at %s. The nearest technician is about 15 minutes away. "
                                    +
                                    "Would you like me to also check if your battery needs replacement while they're there?",
                            location);
                }
            }
            return handlePotentialLocation(context);
        }

        return "I'm here to help with your automotive needs. You can ask me about services, schedule appointments, or get information about vehicle maintenance. What would you like to know?";
    }

    private String extractLocationFromMessage(String message) {
        // Simple location extraction - look for common location patterns
        String lowerMessage = message.toLowerCase();

        // Check for "I'm at/near/on" patterns
        if (lowerMessage.matches(".*\\b(at|near|on)\\s+.*")) {
            // Extract everything after the preposition
            String[] parts = message.split("\\b(?:at|near|on)\\s+", 2);
            if (parts.length > 1) {
                return parts[1].trim();
            }
        }

        // Check for street/location keywords
        if (lowerMessage.contains("street") || lowerMessage.contains("avenue") ||
                lowerMessage.contains("road") || lowerMessage.contains("station") ||
                lowerMessage.contains("mall") || lowerMessage.contains("center")) {
            return message.trim();
        }

        return null;
    }

    private String handlePotentialLocation(UserContext context) {
        return "Got it! Let me confirm - are you saying that's your current location? If so, I can dispatch roadside assistance right away.";
    }

    private String handleTimePreference(UserContext context, String userMessage, ChatSession session) {
        String customerName = context.getCustomerName() != null ? context.getCustomerName() : 
                             (session.getCustomer() != null ? session.getCustomer().getFirstName() : "");
        
        String timePreference = extractTimeFromMessage(userMessage);
        context.setConversationState("time_selected");
        
        if (context.getCurrentService() != null) {
            return String.format("Perfect, %s! I'll schedule your %s for %s. " +
                "Let me confirm the details and book this appointment for you.", 
                customerName != null ? customerName : "",
                context.getCurrentService(),
                timePreference);
        } else {
            return String.format("Great, %s! I have %s noted as your preferred time. " +
                "What service would you like to schedule for that time?", 
                customerName != null ? customerName : "",
                timePreference);
        }
    }

    private String handleSchedulingRequest(UserContext context, String userMessage, ChatSession session) {
        String customerName = context.getCustomerName() != null ? context.getCustomerName() : 
                             (session.getCustomer() != null ? session.getCustomer().getFirstName() : "");
        
        String timePreference = extractTimeFromMessage(userMessage);
        context.setConversationState("scheduling_initiated");
        
        if (context.getCurrentService() != null && context.getVehicle() != null) {
            // We have service and vehicle info, can proceed with booking
            return String.format("Excellent, %s! I can schedule your %s for %s. " +
                "Let me book this appointment for your %s.", 
                customerName != null ? customerName : "",
                context.getCurrentService(),
                timePreference,
                getVehicleDisplayName(context.getVehicle()));
        } else if (context.getCurrentService() != null) {
            // We have service but need vehicle info
            return String.format("Great, %s! I can schedule your %s for %s. " +
                "I'll just need your vehicle information to complete the booking. " +
                "What car do you drive?", 
                customerName != null ? customerName : "",
                context.getCurrentService(),
                timePreference);
        } else {
            // We need both service and vehicle info
            return String.format("Perfect, %s! I can help you schedule an appointment for %s. " +
                "What service do you need and what vehicle is it for?", 
                customerName != null ? customerName : "",
                timePreference);
        }
    }

    private String extractTimeFromMessage(String message) {
        String lowerMessage = message.toLowerCase();
        
        // Extract common time expressions
        if (lowerMessage.contains("tomorrow morning")) return "tomorrow morning";
        if (lowerMessage.contains("tomorrow afternoon")) return "tomorrow afternoon";
        if (lowerMessage.contains("tomorrow evening")) return "tomorrow evening";
        if (lowerMessage.contains("next week")) return "next week";
        if (lowerMessage.contains("monday")) return "Monday";
        if (lowerMessage.contains("tuesday")) return "Tuesday";
        if (lowerMessage.contains("wednesday")) return "Wednesday";
        if (lowerMessage.contains("thursday")) return "Thursday";
        if (lowerMessage.contains("friday")) return "Friday";
        if (lowerMessage.contains("saturday")) return "Saturday";
        if (lowerMessage.contains("sunday")) return "Sunday";
        if (lowerMessage.contains("tomorrow")) return "tomorrow";
        if (lowerMessage.contains("today")) return "today";
        
        return message.trim(); // Return original if no specific pattern found
    }

    private List<QuickReply> getTimeConfirmationQuickReplies() {
        return Arrays.asList(
            new QuickReply("Yes, confirm booking"),
            new QuickReply("Different time"),
            new QuickReply("Add more details"),
            new QuickReply("Cancel booking")
        );
    }

    private List<QuickReply> getSchedulingQuickReplies() {
        return Arrays.asList(
            new QuickReply("Oil Change Service"),
            new QuickReply("Tire Service"),
            new QuickReply("Brake Inspection"),
            new QuickReply("General Maintenance")
        );
    }

    // Helper methods
    private boolean isValidTireChoice(String message) {
        String lowerMessage = message.toLowerCase();
        return lowerMessage.contains("replace the tire") ||
                lowerMessage.contains("temporary patch") ||
                lowerMessage.contains("mobile repair estimate") ||
                lowerMessage.contains("immediate dispatch") ||
                lowerMessage.contains("schedule for later") ||
                lowerMessage.contains("patch") ||
                lowerMessage.contains("replace") ||
                lowerMessage.contains("estimate") ||
                lowerMessage.contains("immediate") ||
                lowerMessage.contains("schedule");
    }

    private boolean isValidOilChoice(String message) {
        String lowerMessage = message.toLowerCase();
        return lowerMessage.contains("oil light is on") ||
                lowerMessage.contains("out of oil completely") ||
                lowerMessage.contains("low oil level") ||
                lowerMessage.contains("need oil change") ||
                lowerMessage.contains("emergency oil delivery") ||
                lowerMessage.contains("oil light") ||
                lowerMessage.contains("completely out") ||
                lowerMessage.contains("low level") ||
                lowerMessage.contains("oil change") ||
                lowerMessage.contains("emergency delivery");
    }

    private String getCustomerVehicleInfo(Customer customer) {
        List<Vehicle> vehicleDTOS = vehicleRepository.findByCustomerId(customer.getId());
        if (!vehicleDTOS.isEmpty()) {
            return vehicleDTOS.get(0).getDisplayName();
        }
        return "vehicle";
    }

    private String getServiceRecommendations(Vehicle vehicleDTO, List<ServiceHistory> history) {
        if (history.isEmpty()) {
            return "I don't see any recent service history.";
        }

        ServiceHistory lastService = history.get(0);
        return String.format("Your last service was %s on %s.",
                lastService.getService().getName(), lastService.getServiceDate());
    }

    private List<String> getAvailableTimeSlots() {
        // Simplified - in real implementation, check actual availability
        return Arrays.asList("Tomorrow 9:00 AM", "Tomorrow 2:00 PM", "Friday 10:00 AM", "Friday 3:00 PM");
    }

    private void createAppointment(Customer customer, UserContext context) {
        // Find or create vehicle
        Vehicle vehicleDTO = findOrCreateVehicle(customer, context.getVehicle());

        // Find service
        Optional<com.dsl.entity.Service> serviceOpt = serviceRepository
                .findByNameIgnoreCase(context.getCurrentService());
        if (serviceOpt.isPresent()) {
            Appointment appointment = new Appointment(customer, vehicleDTO, serviceOpt.get(),
                    LocalDateTime.now().plusDays(1));
            appointmentRepository.save(appointment);
        }
    }

    private Vehicle findOrCreateVehicle(Customer customer, VehicleDTO vehicleDto) {
        if (vehicleDto.getMake() != null && vehicleDto.getModel() != null && vehicleDto.getYear() != null) {
            List<Vehicle> existing = vehicleRepository.findByCustomerIdAndMake(customer.getId(), vehicleDto.getMake());
            if (!existing.isEmpty()) {
                return existing.get(0);
            }

            Vehicle newVehicleDTO = new Vehicle(customer, vehicleDto.getMake(), vehicleDto.getModel(),
                    vehicleDto.getYear());
            return vehicleRepository.save(newVehicleDTO);
        }
        return null;
    }

    private String getVehicleDisplayName(VehicleDTO vehicle) {
        if (vehicle.getYear() != null && vehicle.getMake() != null && vehicle.getModel() != null) {
            return vehicle.getYear() + " " + vehicle.getMake() + " " + vehicle.getModel();
        }
        return "vehicle";
    }

    // Quick reply methods
    private List<QuickReply> getGreetingQuickReplies() {
        return Arrays.asList(
                new QuickReply("I need service for my car"),
                new QuickReply("Book an appointment"),
                new QuickReply("Check service history"));
    }

    private List<QuickReply> getVehicleInfoQuickReplies() {
        return Arrays.asList(
                new QuickReply("2020 Honda Civic"),
                new QuickReply("2019 Toyota Camry"),
                new QuickReply("2021 Ford F-150"));
    }

    private List<QuickReply> getServiceQuickReplies() {
        return Arrays.asList(
                new QuickReply("Oil change"),
                new QuickReply("Tire rotation"),
                new QuickReply("Brake inspection"),
                new QuickReply("General maintenance"));
    }

    private List<QuickReply> getBookingQuickReplies() {
        return Arrays.asList(
                new QuickReply("Yes, schedule appointment"),
                new QuickReply("Tell me more about the service"),
                new QuickReply("What's the cost?"));
    }

    private List<QuickReply> getTimeSlotQuickReplies() {
        return Arrays.asList(
                new QuickReply("Tomorrow morning"),
                new QuickReply("This afternoon"),
                new QuickReply("Next week"));
    }

    private List<QuickReply> getEmergencyQuickReplies() {
        return Arrays.asList(
                new QuickReply("It makes clicking sounds"),
                new QuickReply("No sound at all"),
                new QuickReply("Engine cranks but won't start"),
                new QuickReply("Send roadside assistance"));
    }

    private List<QuickReply> getComplaintQuickReplies() {
        return Arrays.asList(
                new QuickReply("Speak to manager"),
                new QuickReply("File formal complaint"),
                new QuickReply("Request refund"),
                new QuickReply("Schedule callback"));
    }

    private List<QuickReply> getTireAssistanceQuickReplies() {
        List<QuickReply> quickReplies = new ArrayList<>();

        try {
            // Get tire-related services from database
            List<com.dsl.entity.Service> tireServices = serviceRepository.searchByNameOrDescription("tire");

            // Add database services as quick replies
            for (com.dsl.entity.Service service : tireServices) {
                String displayText = String.format("%s ($%.2f - %d min)",
                        service.getName(),
                        service.getPrice(),
                        service.getDurationMinutes());
                quickReplies.add(new QuickReply(displayText, service.getName()));
            }

            // Add emergency tire options if no services found or as additional options
            if (quickReplies.isEmpty()) {
                quickReplies.addAll(Arrays.asList(
                        new QuickReply("Tire Replacement"),
                        new QuickReply("Tire Repair"),
                        new QuickReply("Flat Tire Fix"),
                        new QuickReply("Emergency Tire Service")));
            } else {
                // Add emergency options to existing services
                quickReplies.addAll(Arrays.asList(
                        new QuickReply("Emergency Tire Service"),
                        new QuickReply("Mobile Tire Repair")));
            }

        } catch (Exception e) {
            // Fallback to static options if database query fails
            quickReplies.addAll(Arrays.asList(
                    new QuickReply("Tire Replacement"),
                    new QuickReply("Tire Repair"),
                    new QuickReply("Flat Tire Fix"),
                    new QuickReply("Emergency Tire Service")));
        }

        return quickReplies;
    }

    private List<QuickReply> getOilAssistanceQuickReplies() {
        List<QuickReply> quickReplies = new ArrayList<>();

        try {
            // Get oil-related services from database
            List<com.dsl.entity.Service> oilServices = serviceRepository.searchByNameOrDescription("oil");

            // Add database services as quick replies
            for (com.dsl.entity.Service service : oilServices) {
                String displayText = String.format("%s ($%.2f - %d min)",
                        service.getName(),
                        service.getPrice(),
                        service.getDurationMinutes());
                quickReplies.add(new QuickReply(displayText, service.getName()));
            }

            // Add emergency options if no services found or as additional options
            if (quickReplies.isEmpty()) {
                quickReplies.addAll(Arrays.asList(
                        new QuickReply("Oil Change Service"),
                        new QuickReply("Oil Top-up Service"),
                        new QuickReply("Engine Oil Replacement"),
                        new QuickReply("Emergency Oil Delivery")));
            } else {
                // Add emergency option to existing services
                quickReplies.add(new QuickReply("Emergency Oil Delivery"));
            }

        } catch (Exception e) {
            // Fallback to static options if database query fails
            quickReplies.addAll(Arrays.asList(
                    new QuickReply("Oil Change Service"),
                    new QuickReply("Oil Top-up Service"),
                    new QuickReply("Engine Oil Replacement"),
                    new QuickReply("Emergency Oil Delivery")));
        }

        return quickReplies;
    }

    private List<QuickReply> getTireLocationQuickReplies() {
        return Arrays.asList(
                new QuickReply("I'm at home"),
                new QuickReply("I'm at work"),
                new QuickReply("On the highway"),
                new QuickReply("In a parking lot"),
                new QuickReply("Share my location"));
    }

    private List<QuickReply> getTireConfirmationQuickReplies() {
        return Arrays.asList(
                new QuickReply("Yes, dispatch now"),
                new QuickReply("What's the ETA?"),
                new QuickReply("How much will it cost?"),
                new QuickReply("Change service option"));
    }

    private List<QuickReply> getOilLocationQuickReplies() {
        return Arrays.asList(
                new QuickReply("I'm at home"),
                new QuickReply("I'm at work"),
                new QuickReply("On the road"),
                new QuickReply("In a parking lot"),
                new QuickReply("Share my location"));
    }

    private String handleOilServiceChoice(UserContext context, String choice, ChatSession session) {
        String customerName = context.getCustomerName() != null ? context.getCustomerName()
                : (session.getCustomer() != null ? session.getCustomer().getFirstName() : "");

        switch (choice.toLowerCase()) {
            case "oil light is on":
                context.setConversationState("oil_light_selected");
                return String.format(
                        "I understand, %s. An oil light usually means your engine oil is critically low. " +
                                "I can send immediate oil delivery and refill service to prevent engine damage. " +
                                "Where are you located so I can dispatch help right away?",
                        customerName != null ? customerName : "");

            case "out of oil completely":
                context.setConversationState("oil_empty_selected");
                context.setEmergencyMode(true);
                return String.format(
                        "This is urgent, %s! Running completely out of oil can cause serious engine damage. " +
                                "I'm dispatching emergency oil delivery immediately. Please don't drive the vehicle. " +
                                "What's your current location?",
                        customerName != null ? customerName : "");

            case "low oil level":
                context.setConversationState("oil_low_selected");
                return String.format("Got it, %s. Low oil levels should be addressed soon to prevent engine wear. " +
                        "I can send a technician to check and top up your oil. Where would you like this service?",
                        customerName != null ? customerName : "");

            case "need oil change":
                context.setConversationState("oil_change_selected");
                return String.format("Perfect, %s! I can arrange a full oil change service. " +
                        "We can do this at your location or you can visit our service center. " +
                        "Where would you prefer the service?",
                        customerName != null ? customerName : "");

            case "emergency oil delivery":
                context.setConversationState("oil_emergency_selected");
                context.setEmergencyMode(true);
                return String.format("Understood, %s. I'm treating this as urgent. " +
                        "Emergency oil delivery will be dispatched immediately with high-quality engine oil. " +
                        "Please share your location for fastest response.",
                        customerName != null ? customerName : "");

            default:
                return "I didn't catch that option. Please choose from the available oil service options.";
        }
    }

    private String handleLocationProvided(UserContext context, Map<String, String> entities, ChatSession session) {
        String location = entities.get("location");
        if (location == null) {
            // Try to extract location from common phrases
            location = extractLocationFromUserMessage(context);
        }

        if (location != null) {
            context.setCurrentLocation(location);
            String customerName = context.getCustomerName() != null ? context.getCustomerName()
                    : (session.getCustomer() != null ? session.getCustomer().getFirstName() : "");

            String conversationState = context.getConversationState();

            if ("tire_replacement_selected".equals(conversationState)) {
                context.setConversationState("tire_service_ready");
                return String.format(
                        "Perfect, %s! I've located you at %s. I can dispatch a technician with a matching tire " +
                                "who will arrive in approximately 25 minutes. The service includes tire replacement and disposal of the old tire. "
                                +
                                "Shall I send them now?",
                        customerName, location);
            } else if ("tire_patch_selected".equals(conversationState)) {
                context.setConversationState("tire_service_ready");
                return String.format(
                        "Got it, %s! I have your location at %s. I'll send a technician with patching equipment " +
                                "who will arrive in about 20 minutes. This will get you safely to a garage for a permanent fix. "
                                +
                                "Should I dispatch them now?",
                        customerName, location);
            } else if ("tire_estimate_selected".equals(conversationState)) {
                context.setConversationState("tire_service_ready");
                return String.format("Excellent, %s! I've pinned your location at %s. I'll send a mobile technician " +
                        "to assess your tire damage and provide a repair estimate. They'll arrive in about 15 minutes. "
                        +
                        "Proceed with dispatch?", customerName, location);
            } else if ("tire_immediate_dispatch".equals(conversationState)) {
                context.setConversationState("tire_service_dispatched");
                return String.format("All set, %s! ✅ I've dispatched emergency tire assistance to %s. " +
                        "The nearest technician is en route and will arrive in 20-25 minutes. " +
                        "Please stay safe and keep your hazard lights on if you're roadside. 🚨", customerName,
                        location);
            }
        }

        return "I need your location to dispatch tire assistance. Could you please share where you are?";
    }

    private String handleServiceSelection(UserContext context, String userMessage, ChatSession session) {
        String customerName = context.getCustomerName() != null ? context.getCustomerName()
                : (session.getCustomer() != null ? session.getCustomer().getFirstName() : "");

        // Extract service name from the message (could be from quick reply)
        String selectedService = extractServiceFromMessage(userMessage);

        if (selectedService != null) {
            context.setCurrentService(selectedService);
            context.setConversationState("service_selected");

            // Try to find the service in database for pricing info
            try {
                Optional<com.dsl.entity.Service> serviceOpt = serviceRepository.findByNameIgnoreCase(selectedService);
                if (serviceOpt.isPresent()) {
                    com.dsl.entity.Service service = serviceOpt.get();
                    return String.format("Great choice, %s! I can arrange %s for you. " +
                            "This service typically takes %d minutes and costs $%.2f. " +
                            "Would you like to schedule this service?",
                            customerName != null ? customerName : "",
                            service.getName(),
                            service.getDurationMinutes(),
                            service.getPrice());
                }
            } catch (Exception e) {
                // Continue with generic response if database lookup fails
            }

            return String.format("Perfect, %s! I can arrange %s for you. " +
                    "Would you like to schedule this service now?",
                    customerName != null ? customerName : "", selectedService);
        }

        return "I didn't catch which service you'd like. Please select from the available options.";
    }

    private String extractServiceFromMessage(String message) {
        // Extract service name from message - could be from quick reply format "Service
        // Name ($price - duration)"
        if (message.contains("($")) {
            // Extract service name before the price info
            return message.substring(0, message.indexOf("($")).trim();
        }
        return message.trim();
    }

    private List<QuickReply> getServiceBookingQuickReplies() {
        return Arrays.asList(
                new QuickReply("Yes, schedule now"),
                new QuickReply("Tell me more details"),
                new QuickReply("What's included?"),
                new QuickReply("Choose different service"));
    }

    private String handleNegation(UserContext context, Map<String, String> entities, ChatSession session,
            String userMessage) {
        String conversationState = context.getConversationState();
        String customerName = context.getCustomerName() != null ? context.getCustomerName()
                : (session.getCustomer() != null ? session.getCustomer().getFirstName() : "");

        // Context-aware negation handling
        if ("service_selected".equals(conversationState)) {
            // User said no to scheduling the selected service
            context.setConversationState("scheduling_declined");
            return String.format("No problem, %s! Would you like to schedule the %s for a different time, " +
                    "or would you prefer to choose a different service?",
                    customerName != null ? customerName : "",
                    context.getCurrentService() != null ? context.getCurrentService() : "service");

        } else if ("booking_appointment".equals(conversationState)) {
            // User said no to a specific time slot
            context.setConversationState("time_declined");
            return String.format("That's okay, %s. Let me suggest some other available times for your %s. " +
                    "When would work better for you?",
                    customerName != null ? customerName : "",
                    context.getCurrentService() != null ? context.getCurrentService() : "service");

        } else if ("tire_service_ready".equals(conversationState) || "oil_service_ready".equals(conversationState)) {
            // User said no to immediate dispatch
            context.setConversationState("dispatch_declined");
            return String.format(
                    "Understood, %s. Would you like to schedule the service for a specific time instead? " +
                            "Or do you need more information about the service?",
                    customerName != null ? customerName : "");

        } else {
            // General negation - ask what they need instead
            return String.format("I understand, %s. What would you like to do instead? " +
                    "I can help you with different services or answer any questions you have.",
                    customerName != null ? customerName : "");
        }
    }

    private List<QuickReply> getNegationQuickReplies(UserContext context) {
        String conversationState = context.getConversationState();

        if ("scheduling_declined".equals(conversationState)) {
            return Arrays.asList(
                    new QuickReply("Schedule for different time"),
                    new QuickReply("Choose different service"),
                    new QuickReply("Tell me more about this service"),
                    new QuickReply("Cancel for now"));
        } else if ("time_declined".equals(conversationState)) {
            return Arrays.asList(
                    new QuickReply("Tomorrow morning"),
                    new QuickReply("Tomorrow afternoon"),
                    new QuickReply("Next week"),
                    new QuickReply("I'll call to schedule"));
        } else if ("dispatch_declined".equals(conversationState)) {
            return Arrays.asList(
                    new QuickReply("Schedule for later today"),
                    new QuickReply("Schedule for tomorrow"),
                    new QuickReply("Tell me more details"),
                    new QuickReply("Different service option"));
        } else {
            return Arrays.asList(
                    new QuickReply("Browse services"),
                    new QuickReply("Emergency assistance"),
                    new QuickReply("Talk to human"),
                    new QuickReply("Start over"));
        }
    }

    private String extractLocationFromUserMessage(UserContext context) {
        // This would extract location from phrases like "I'm at home", "I'm at work",
        // etc.
        // For now, return a placeholder - in real implementation, this would use NLP
        return "Current Location";
    }

    private List<QuickReply> getDefaultQuickReplies() {
        return Arrays.asList(
                new QuickReply("I need car service"),
                new QuickReply("Book appointment"),
                new QuickReply("Emergency help"),
                new QuickReply("Talk to human"));
    }

    // Conversion methods
    private Map<String, Object> convertEntitiesToMap(Map<String, String> entities) {
        return new HashMap<>(entities);
    }

    private Map<String, Object> convertVehicleToMap(VehicleDTO vehicleDTO) {
        Map<String, Object> map = new HashMap<>();
        if (vehicleDTO.getMake() != null)
            map.put("make", vehicleDTO.getMake());
        if (vehicleDTO.getModel() != null)
            map.put("model", vehicleDTO.getModel());
        if (vehicleDTO.getYear() != null)
            map.put("year", vehicleDTO.getYear());
        return map;
    }

    private VehicleDTO convertMapToVehicle(Map<String, Object> map) {
        VehicleDTO vehicleDTO = new VehicleDTO();
        if (map.containsKey("make"))
            vehicleDTO.setMake((String) map.get("make"));
        if (map.containsKey("model"))
            vehicleDTO.setModel((String) map.get("model"));
        if (map.containsKey("year"))
            vehicleDTO.setYear((Integer) map.get("year"));
        return vehicleDTO;
    }

    private VehicleDTO convertEntityToDto(Vehicle entity) {
        VehicleDTO dto = new VehicleDTO();
        dto.setMake(entity.getMake());
        dto.setModel(entity.getModel());
        dto.setYear(entity.getYear());
        dto.setColor(entity.getColor());
        dto.setVin(entity.getVin());
        dto.setMileage(entity.getMileage());
        return dto;
    }

    // Public methods for chat history
    public List<ChatMessage> getChatHistory(String sessionId) {
        return chatMessageRepository.findBySessionIdOrderByTimestamp(sessionId);
    }

    public UserContext updateContext(String sessionId, UserContext context) {
        ChatSession session = getOrCreateSession(sessionId);
        updateSessionContext(session, context);
        chatSessionRepository.save(session);
        return context;
    }
}