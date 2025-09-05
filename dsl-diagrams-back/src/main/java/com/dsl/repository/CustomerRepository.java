package com.dsl.repository;


import com.dsl.entity.Customer;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface CustomerRepository extends JpaRepository<Customer, Long> {
    
    // Find by email
    Optional<Customer> findByEmail(String email);
    
    // Find by phone
    Optional<Customer> findByPhone(String phone);
    
    // Find by first name (case insensitive)
    List<Customer> findByFirstNameIgnoreCase(String firstName);
    
    // Find by first and last name (case insensitive)
    Optional<Customer> findByFirstNameIgnoreCaseAndLastNameIgnoreCase(String firstName, String lastName);
    
    // Search customers by name (partial match)
    @Query("SELECT c FROM Customer c WHERE " +
           "LOWER(c.firstName) LIKE LOWER(CONCAT('%', :name, '%')) OR " +
           "LOWER(c.lastName) LIKE LOWER(CONCAT('%', :name, '%')) OR " +
           "LOWER(CONCAT(c.firstName, ' ', c.lastName)) LIKE LOWER(CONCAT('%', :name, '%'))")
    List<Customer> searchByName(@Param("name") String name);
    
    // Find customers with vehicles
    @Query("SELECT DISTINCT c FROM Customer c JOIN FETCH c.vehicles")
    List<Customer> findAllWithVehicles();
    
    // Find customers by vehicle make
    @Query("SELECT DISTINCT c FROM Customer c JOIN c.vehicles v WHERE LOWER(v.make) = LOWER(:make)")
    List<Customer> findByVehicleMake(@Param("make") String make);
    
    // Check if customer exists by email or phone
    @Query("SELECT COUNT(c) > 0 FROM Customer c WHERE c.email = :email OR c.phone = :phone")
    boolean existsByEmailOrPhone(@Param("email") String email, @Param("phone") String phone);
}