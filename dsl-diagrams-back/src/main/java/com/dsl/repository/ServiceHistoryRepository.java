package com.dsl.repository;

import com.dsl.entity.ServiceHistory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface ServiceHistoryRepository extends JpaRepository<ServiceHistory, Long> {
    
    // Find service history by vehicle ID
    List<ServiceHistory> findByVehicleIdOrderByServiceDateDesc(Long vehicleId);
    
    // Find service history by customer (through vehicle)
    @Query("SELECT sh FROM ServiceHistory sh WHERE sh.vehicle.customer.id = :customerId ORDER BY sh.serviceDate DESC")
    List<ServiceHistory> findByCustomerIdOrderByServiceDateDesc(@Param("customerId") Long customerId);
    
    // Find service history by service type
    List<ServiceHistory> findByServiceIdOrderByServiceDateDesc(Long serviceId);
    
    // Find recent services for vehicle
    @Query("SELECT sh FROM ServiceHistory sh WHERE sh.vehicle.id = :vehicleId AND sh.serviceDate >= :sinceDate ORDER BY sh.serviceDate DESC")
    List<ServiceHistory> findRecentServicesByVehicle(@Param("vehicleId") Long vehicleId, @Param("sinceDate") LocalDate sinceDate);
    
    // Find last service of specific type for vehicle
    @Query("SELECT sh FROM ServiceHistory sh WHERE sh.vehicle.id = :vehicleId AND sh.service.id = :serviceId ORDER BY sh.serviceDate DESC LIMIT 1")
    ServiceHistory findLastServiceByVehicleAndType(@Param("vehicleId") Long vehicleId, @Param("serviceId") Long serviceId);
    
    // Find services due for vehicle (based on last service date and recommended interval)
    @Query("SELECT sh FROM ServiceHistory sh WHERE sh.vehicle.id = :vehicleId AND sh.serviceDate < :cutoffDate")
    List<ServiceHistory> findServicesDueForVehicle(@Param("vehicleId") Long vehicleId, @Param("cutoffDate") LocalDate cutoffDate);
    
    // Get service statistics by type
    @Query("SELECT s.name, COUNT(sh) FROM ServiceHistory sh JOIN sh.service s GROUP BY s.name ORDER BY COUNT(sh) DESC")
    List<Object[]> getServiceStatistics();
    
    // Find services by date range
    @Query("SELECT sh FROM ServiceHistory sh WHERE sh.serviceDate BETWEEN :startDate AND :endDate ORDER BY sh.serviceDate DESC")
    List<ServiceHistory> findByDateRange(@Param("startDate") LocalDate startDate, @Param("endDate") LocalDate endDate);
    
    // Calculate total spent by customer
    @Query("SELECT COALESCE(SUM(sh.cost), 0) FROM ServiceHistory sh WHERE sh.vehicle.customer.id = :customerId")
    Double getTotalSpentByCustomer(@Param("customerId") Long customerId);
    
    // Find vehicles needing specific service (haven't had it in X months)
    @Query("SELECT DISTINCT sh.vehicle FROM ServiceHistory sh WHERE sh.service.name = :serviceName AND sh.serviceDate < :cutoffDate")
    List<Object> findVehiclesNeedingService(@Param("serviceName") String serviceName, @Param("cutoffDate") LocalDate cutoffDate);
}