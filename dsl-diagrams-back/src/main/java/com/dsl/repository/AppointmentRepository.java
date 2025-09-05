package com.dsl.repository;

import com.dsl.entity.Appointment;
import com.dsl.entity.AppointmentStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;


@Repository
public interface AppointmentRepository extends JpaRepository<Appointment, Long> {
    
    // Find appointments by customer ID
    List<Appointment> findByCustomerIdOrderByAppointmentDateDesc(Long customerId);
    
    // Find appointments by vehicle ID
    List<Appointment> findByVehicleIdOrderByAppointmentDateDesc(Long vehicleId);
    
    // Find appointments by status
    List<Appointment> findByStatusOrderByAppointmentDate(AppointmentStatus status);
    
    // Find appointments by date range
    @Query("SELECT a FROM Appointment a WHERE a.appointmentDate BETWEEN :startDate AND :endDate ORDER BY a.appointmentDate")
    List<Appointment> findByDateRange(@Param("startDate") LocalDateTime startDate, @Param("endDate") LocalDateTime endDate);
    
    // Find upcoming appointments for customer
    @Query("SELECT a FROM Appointment a WHERE a.customer.id = :customerId AND a.appointmentDate > :now AND a.status IN ('SCHEDULED', 'CONFIRMED') ORDER BY a.appointmentDate")
    List<Appointment> findUpcomingAppointmentsByCustomer(@Param("customerId") Long customerId, @Param("now") LocalDateTime now);
    
    // Find today's appointments
    @Query("SELECT a FROM Appointment a WHERE DATE(a.appointmentDate) = DATE(:today) ORDER BY a.appointmentDate")
    List<Appointment> findTodaysAppointments(@Param("today") LocalDateTime today);
    
    // Check availability for time slot
    @Query("SELECT COUNT(a) FROM Appointment a WHERE a.appointmentDate BETWEEN :startTime AND :endTime AND a.status IN ('SCHEDULED', 'CONFIRMED', 'IN_PROGRESS')")
    Long countAppointmentsInTimeSlot(@Param("startTime") LocalDateTime startTime, @Param("endTime") LocalDateTime endTime);
    
    // Find appointments by service type
    @Query("SELECT a FROM Appointment a WHERE a.service.id = :serviceId ORDER BY a.appointmentDate DESC")
    List<Appointment> findByServiceId(@Param("serviceId") Long serviceId);
    
    // Find overdue appointments (past due and not completed)
    @Query("SELECT a FROM Appointment a WHERE a.appointmentDate < :now AND a.status NOT IN ('COMPLETED', 'CANCELLED') ORDER BY a.appointmentDate")
    List<Appointment> findOverdueAppointments(@Param("now") LocalDateTime now);
    
    // Get appointment statistics by status
    @Query("SELECT a.status, COUNT(a) FROM Appointment a GROUP BY a.status")
    List<Object[]> getAppointmentStatsByStatus();
}