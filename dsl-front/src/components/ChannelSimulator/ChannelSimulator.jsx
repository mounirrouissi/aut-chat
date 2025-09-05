import React, { useState } from 'react';
import SMSSimulator from './SMSSimulator';
import EmailSimulator from './EmailSimulator';
import './ChannelSimulator.css';

const ChannelSimulator = ({ onStartChat }) => {
  const [activeChannel, setActiveChannel] = useState('sms');
  const [customerInfo, setCustomerInfo] = useState({
    name: '',
    phone: '',
    email: '',
    vehicle: ''
  });

  const handleChannelSwitch = (channel) => {
    setActiveChannel(channel);
  };

  const handleStartConversation = (channel, initialMessage, customerData) => {
    // Merge customer info
    const fullCustomerInfo = { ...customerInfo, ...customerData };
    
    // Start chat with context
    onStartChat({
      channel,
      initialMessage,
      customerInfo: fullCustomerInfo,
      sessionId: `${channel}_${Date.now()}_${Math.random().toString(36).substr(2, 9)}`
    });
  };

  return (
    <div className="channel-simulator">
      <div className="simulator-header">
        <h2>Customer Communication Simulator</h2>
        <p>Simulate how customers initiate conversations through different channels</p>
      </div>

      <div className="channel-tabs">
        <button 
          className={`tab-button ${activeChannel === 'sms' ? 'active' : ''}`}
          onClick={() => handleChannelSwitch('sms')}
        >
          📱 SMS
        </button>
        <button 
          className={`tab-button ${activeChannel === 'email' ? 'active' : ''}`}
          onClick={() => handleChannelSwitch('email')}
        >
          📧 Email
        </button>
      </div>

      <div className="channel-content">
        {activeChannel === 'sms' && (
          <SMSSimulator 
            onStartConversation={handleStartConversation}
            customerInfo={customerInfo}
            setCustomerInfo={setCustomerInfo}
          />
        )}
        
        {activeChannel === 'email' && (
          <EmailSimulator 
            onStartConversation={handleStartConversation}
            customerInfo={customerInfo}
            setCustomerInfo={setCustomerInfo}
          />
        )}
      </div>
    </div>
  );
};

export default ChannelSimulator;  


