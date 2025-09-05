import React from 'react';

const QuickReplies = ({ replies, onReplyClick }) => {
  if (!replies || replies.length === 0) return null;

  return (
    <div className="quick-replies" style={{marginTop: '8px', marginLeft: '8px'}}>
      <div className="quick-replies-label" style={{fontSize: '12px', color: '#6b7280', marginBottom: '8px'}}>
        Quick replies:
      </div>
      <div className="quick-replies-buttons" style={{display: 'flex', flexWrap: 'wrap', gap: '8px'}}>
        {replies.map((reply, index) => (
          <button
            key={index}
            className="quick-reply-button"
            style={{
              background: 'white',
              border: '1px solid #d1d5db',
              borderRadius: '16px',
              padding: '8px 12px',
              fontSize: '14px',
              color: '#374151',
              cursor: 'pointer'
            }}
            onClick={() => onReplyClick(reply.text || reply)}
          >
            {reply.label || reply}
          </button>
        ))}
      </div>
    </div>
  );
};

export default QuickReplies;