package com.dsl.repository;

import com.dsl.entity.ChatMessage;
import com.dsl.entity.MessageSender;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface ChatMessageRepository extends JpaRepository<ChatMessage, Long> {
    
    // Find messages by session ID (ordered by timestamp)
    @Query("SELECT cm FROM ChatMessage cm WHERE cm.chatSession.sessionId = :sessionId ORDER BY cm.timestamp")
    List<ChatMessage> findBySessionIdOrderByTimestamp(@Param("sessionId") String sessionId);
    
    // Find recent messages by session ID
    @Query("SELECT cm FROM ChatMessage cm WHERE cm.chatSession.sessionId = :sessionId ORDER BY cm.timestamp DESC")
    List<ChatMessage> findBySessionIdOrderByTimestampDesc(@Param("sessionId") String sessionId);
    
    // Find messages by sender
    @Query("SELECT cm FROM ChatMessage cm WHERE cm.chatSession.sessionId = :sessionId AND cm.sender = :sender ORDER BY cm.timestamp")
    List<ChatMessage> findBySessionIdAndSender(@Param("sessionId") String sessionId, @Param("sender")
    MessageSender sender);
    
    // Find messages by intent
    List<ChatMessage> findByIntentOrderByTimestampDesc(String intent);
    
    // Find messages in date range
    @Query("SELECT cm FROM ChatMessage cm WHERE cm.timestamp BETWEEN :startDate AND :endDate ORDER BY cm.timestamp")
    List<ChatMessage> findByDateRange(@Param("startDate") LocalDateTime startDate, @Param("endDate") LocalDateTime endDate);
    
    // Get conversation statistics by intent
    @Query("SELECT cm.intent, COUNT(cm) FROM ChatMessage cm WHERE cm.sender = 'USER' GROUP BY cm.intent ORDER BY COUNT(cm) DESC")
    List<Object[]> getIntentStatistics();
    
    // Find messages with low confidence
    @Query("SELECT cm FROM ChatMessage cm WHERE cm.confidence < :threshold AND cm.sender = 'USER' ORDER BY cm.timestamp DESC")
    List<ChatMessage> findLowConfidenceMessages(@Param("threshold") Double threshold);
    
    // Count messages by session
    @Query("SELECT COUNT(cm) FROM ChatMessage cm WHERE cm.chatSession.sessionId = :sessionId")
    Long countMessagesBySession(@Param("sessionId") String sessionId);
    
    // Find last message in session
    @Query("SELECT cm FROM ChatMessage cm WHERE cm.chatSession.sessionId = :sessionId ORDER BY cm.timestamp DESC LIMIT 1")
    ChatMessage findLastMessageInSession(@Param("sessionId") String sessionId);
    
    // Find messages containing specific text
    @Query("SELECT cm FROM ChatMessage cm WHERE LOWER(cm.message) LIKE LOWER(CONCAT('%', :text, '%')) ORDER BY cm.timestamp DESC")
    List<ChatMessage> findMessagesContaining(@Param("text") String text);
}