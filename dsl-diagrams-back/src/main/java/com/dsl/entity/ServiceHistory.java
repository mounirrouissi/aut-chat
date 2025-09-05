package com.dsl.entity;

import jakarta.persistence.*;
import org.hibernate.annotations.CreationTimestamp;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "service_history")
public class ServiceHistory {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "vehicle_id", nullable = false)
    private Vehicle vehicle;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "service_id", nullable = false)
    private Service service;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "appointment_id")
    private Appointment appointment;
    
    @Column(name = "service_date", nullable = false)
    private LocalDate serviceDate;
    
    @Column(name = "mileage_at_service")
    private Integer mileageAtService;
    
    @Column(name = "notes", columnDefinition = "TEXT")
    private String notes;
    
    @Column(name = "cost", precision = 10, scale = 2)
    private BigDecimal cost;
    
    @CreationTimestamp
    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt;
    
    // Constructors
    public ServiceHistory() {}
    
    public ServiceHistory(Vehicle vehicle, Service service, LocalDate serviceDate) {
        this.vehicle = vehicle;
        this.service = service;
        this.serviceDate = serviceDate;
    }
    
    public ServiceHistory(Vehicle vehicle, Service service, Appointment appointment, LocalDate serviceDate, Integer mileageAtService, BigDecimal cost) {
        this.vehicle = vehicle;
        this.service = service;
        this.appointment = appointment;
        this.serviceDate = serviceDate;
        this.mileageAtService = mileageAtService;
        this.cost = cost;
    }
    
    // Getters and Setters
    public Long getId() {
        return id;
    }
    
    public void setId(Long id) {
        this.id = id;
    }
    
    public Vehicle getVehicle() {
        return vehicle;
    }
    
    public void setVehicle(Vehicle vehicle) {
        this.vehicle = vehicle;
    }
    
    public Service getService() {
        return service;
    }
    
    public void setService(Service service) {
        this.service = service;
    }
    
    public Appointment getAppointment() {
        return appointment;
    }
    
    public void setAppointment(Appointment appointment) {
        this.appointment = appointment;
    }
    
    public LocalDate getServiceDate() {
        return serviceDate;
    }
    
    public void setServiceDate(LocalDate serviceDate) {
        this.serviceDate = serviceDate;
    }
    
    public Integer getMileageAtService() {
        return mileageAtService;
    }
    
    public void setMileageAtService(Integer mileageAtService) {
        this.mileageAtService = mileageAtService;
    }
    
    public String getNotes() {
        return notes;
    }
    
    public void setNotes(String notes) {
        this.notes = notes;
    }
    
    public BigDecimal getCost() {
        return cost;
    }
    
    public void setCost(BigDecimal cost) {
        this.cost = cost;
    }
    
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
    
    @Override
    public String toString() {
        return "ServiceHistory{" +
                "id=" + id +
                ", serviceDate=" + serviceDate +
                ", mileageAtService=" + mileageAtService +
                ", cost=" + cost +
                ", service=" + (service != null ? service.getName() : null) +
                '}';
    }
}