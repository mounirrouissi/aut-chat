import React from "react";

const MessageBubble = ({ message }) => {
  const { text, sender, timestamp, isError } = message;

  const formatTime = (timestamp) => {
    return new Date(timestamp).toLocaleTimeString([], {
      hour: "2-digit",
      minute: "2-digit",
    });
  };

  console.log("MessageBubble rendering:", sender, text);

  return (
    <div className={`message-bubble ${sender} ${isError ? "error" : ""}`}>
      <div className="message-content">
        <p className="message-text">{text}</p>
        <span className="message-time">{formatTime(timestamp)}</span>
      </div>
    </div>
  );
};

export default MessageBubble;
