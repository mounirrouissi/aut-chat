package com.dsl.controller;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class VehicleDTO {
    private String make;
    private String model;
    private Integer year;
    private String color;
    private String vin;
    private Integer mileage;
    
    public String getDisplayName() {
        StringBuilder sb = new StringBuilder();
        if (year != null) sb.append(year).append(" ");
        if (make != null) sb.append(make).append(" ");
        if (model != null) sb.append(model);
        return sb.toString().trim();
    }
}