package com.dsl.repository;

import com.dsl.entity.Service;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

@Repository
public interface ServiceRepository extends JpaRepository<Service, Long> {
    
    // Find active services
    List<Service> findByIsActiveTrue();
    
    // Find by category
    List<Service> findByCategoryIgnoreCaseAndIsActiveTrue(String category);
    
    // Find by name (case insensitive)
    Optional<Service> findByNameIgnoreCase(String name);
    
    // Search services by name or description
    @Query("SELECT s FROM Service s WHERE s.isActive = true AND (" +
           "LOWER(s.name) LIKE LOWER(CONCAT('%', :search, '%')) OR " +
           "LOWER(s.description) LIKE LOWER(CONCAT('%', :search, '%')))")
    List<Service> searchByNameOrDescription(@Param("search") String search);
    
    // Find services by price range
    @Query("SELECT s FROM Service s WHERE s.isActive = true AND s.price BETWEEN :minPrice AND :maxPrice")
    List<Service> findByPriceRange(@Param("minPrice") BigDecimal minPrice, @Param("maxPrice") BigDecimal maxPrice);
    
    // Find services by duration range
    @Query("SELECT s FROM Service s WHERE s.isActive = true AND s.durationMinutes BETWEEN :minDuration AND :maxDuration")
    List<Service> findByDurationRange(@Param("minDuration") Integer minDuration, @Param("maxDuration") Integer maxDuration);
    
    // Find quick services (under 60 minutes)
    @Query("SELECT s FROM Service s WHERE s.isActive = true AND s.durationMinutes <= 60 ORDER BY s.durationMinutes")
    List<Service> findQuickServices();
    
    // Find popular services (most booked)
    @Query("SELECT s, COUNT(a) as bookingCount FROM Service s " +
           "LEFT JOIN s.appointments a " +
           "WHERE s.isActive = true " +
           "GROUP BY s " +
           "ORDER BY bookingCount DESC")
    List<Object[]> findPopularServices();
    
    // Get all categories
    @Query("SELECT DISTINCT s.category FROM Service s WHERE s.isActive = true ORDER BY s.category")
    List<String> findAllCategories();
}