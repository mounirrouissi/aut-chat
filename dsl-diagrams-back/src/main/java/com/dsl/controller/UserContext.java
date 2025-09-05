package com.dsl.controller;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserContext {
    private Long customerId;
    private String customerName;
    private VehicleDTO vehicle;
    private String currentService;
    private String conversationState;
    private LocalDateTime lastInteraction;
    private Map<String, Object> sessionData = new HashMap<>();
    private int messageCount = 0;
    private String preferredLanguage = "en";
    private boolean isReturningCustomer = false;
    private String currentLocation;
    private String emergencyType;
    private boolean isEmergencyMode = false;
}