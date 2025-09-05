package com.dsl.repository;

import com.dsl.entity.Vehicle;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface VehicleRepository extends JpaRepository<Vehicle, Long> {
    
    // Find vehicles by customer ID
    List<Vehicle> findByCustomerId(Long customerId);
    
    // Find by VIN
    Optional<Vehicle> findByVin(String vin);
    
    // Find by license plate
    Optional<Vehicle> findByLicensePlate(String licensePlate);
    
    // Find by make and model (case insensitive)
    List<Vehicle> findByMakeIgnoreCaseAndModelIgnoreCase(String make, String model);
    
    // Find by make, model, and year
    List<Vehicle> findByMakeIgnoreCaseAndModelIgnoreCaseAndYear(String make, String model, Integer year);
    
    // Find vehicles by customer and make
    @Query("SELECT v FROM Vehicle v WHERE v.customer.id = :customerId AND LOWER(v.make) = LOWER(:make)")
    List<Vehicle> findByCustomerIdAndMake(@Param("customerId") Long customerId, @Param("make") String make);
    
    // Find vehicles with service history
    @Query("SELECT DISTINCT v FROM Vehicle v JOIN FETCH v.serviceHistory")
    List<Vehicle> findAllWithServiceHistory();
    
    // Find vehicles due for service (based on mileage)
    @Query("SELECT v FROM Vehicle v WHERE v.mileage >= :mileage")
    List<Vehicle> findVehiclesDueForService(@Param("mileage") Integer mileage);
    
    // Search vehicles by make or model
    @Query("SELECT v FROM Vehicle v WHERE " +
           "LOWER(v.make) LIKE LOWER(CONCAT('%', :search, '%')) OR " +
           "LOWER(v.model) LIKE LOWER(CONCAT('%', :search, '%'))")
    List<Vehicle> searchByMakeOrModel(@Param("search") String search);
    
    // Find customer's primary vehicle (most recent)
    @Query("SELECT v FROM Vehicle v WHERE v.customer.id = :customerId ORDER BY v.createdAt DESC")
    List<Vehicle> findByCustomerIdOrderByCreatedAtDesc(@Param("customerId") Long customerId);
}