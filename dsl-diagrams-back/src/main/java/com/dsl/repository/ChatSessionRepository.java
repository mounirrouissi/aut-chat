package com.dsl.repository;


import com.dsl.entity.ChatSession;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

public interface ChatSessionRepository extends JpaRepository<ChatSession, Long> {
    
    // Find by session ID
    Optional<ChatSession> findBySessionId(String sessionId);
    
    // Find active sessions by customer
    List<ChatSession> findByCustomerIdAndIsActiveTrueOrderByLastActivityDesc(Long customerId);
    
    // Find all active sessions
    List<ChatSession> findByIsActiveTrueOrderByLastActivityDesc();
    
    // Find sessions by customer
    List<ChatSession> findByCustomerIdOrderByCreatedAtDesc(Long customerId);
    
    // Find inactive sessions (for cleanup)
    @Query("SELECT cs FROM ChatSession cs WHERE cs.lastActivity < :cutoffTime AND cs.isActive = true")
    List<ChatSession> findInactiveSessions(@Param("cutoffTime") LocalDateTime cutoffTime);
    
    // Deactivate old sessions
    @Modifying
    @Query("UPDATE ChatSession cs SET cs.isActive = false WHERE cs.lastActivity < :cutoffTime AND cs.isActive = true")
    int deactivateOldSessions(@Param("cutoffTime") LocalDateTime cutoffTime);
    
    // Update last activity
    @Modifying
    @Query("UPDATE ChatSession cs SET cs.lastActivity = :now WHERE cs.sessionId = :sessionId")
    int updateLastActivity(@Param("sessionId") String sessionId, @Param("now") LocalDateTime now);
    
    // Find sessions with messages
    @Query("SELECT DISTINCT cs FROM ChatSession cs JOIN FETCH cs.messages WHERE cs.isActive = true")
    List<ChatSession> findActiveSessionsWithMessages();
    
    // Count active sessions by customer
    @Query("SELECT COUNT(cs) FROM ChatSession cs WHERE cs.customer.id = :customerId AND cs.isActive = true")
    Long countActiveSessionsByCustomer(@Param("customerId") Long customerId);
}