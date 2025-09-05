import React, { useState } from 'react';

const SMSSimulator = ({ onStartConversation, customerInfo, setCustomerInfo }) => {
  const [selectedScenario, setSelectedScenario] = useState('');
  const [customMessage, setCustomMessage] = useState('');

  const smsScenarios = [
    {
      id: 'oil_change',
      title: 'Oil Change Request',
      customerName: 'John Smith',
      phone: '+1-555-0123',
      vehicle: '2020 Honda Civic',
      message: 'Hi, I need an oil change for my 2020 Honda Civic. When can I schedule?'
    },
    {
      id: 'brake_issue',
      title: 'Brake Problem',
      customerName: 'Sarah Johnson',
      phone: '+1-555-0456',
      vehicle: '2019 Toyota Camry',
      message: 'My brakes are making a squeaking noise. Can someone check them?'
    },
    {
      id: 'routine_maintenance',
      title: 'Routine Maintenance',
      customerName: 'Mike Davis',
      phone: '+1-555-0789',
      vehicle: '2021 Ford F-150',
      message: 'My truck is due for 30k mile service. What do you recommend?'
    },
    {
      id: 'emergency',
      title: 'Emergency Service',
      customerName: 'Lisa Wilson',
      phone: '+1-555-0321',
      vehicle: '2018 Nissan Altima',
      message: 'My car won\'t start! I\'m stranded at the mall. Can you help?'
    },
    {
      id: 'appointment_followup',
      title: 'Appointment Follow-up',
      customerName: 'Robert Brown',
      phone: '+1-555-0654',
      vehicle: '2022 Subaru Outback',
      message: 'I had an appointment scheduled for tomorrow. Can you confirm the time?'
    }
  ];

  const handleScenarioSelect = (scenario) => {
    setSelectedScenario(scenario.id);
    setCustomerInfo({
      name: scenario.customerName,
      phone: scenario.phone,
      email: '',
      vehicle: scenario.vehicle
    });
    setCustomMessage(scenario.message);
  };

  // Utility function to parse vehicle string into object
  const parseVehicle = (vehicleString) => {
    if (!vehicleString) return null;
    
    const parts = vehicleString.trim().split(' ');
    if (parts.length >= 3) {
      const year = parseInt(parts[0]);
      const make = parts[1];
      const model = parts.slice(2).join(' ');
      
      return {
        year: isNaN(year) ? null : year,
        make: make,
        model: model
      };
    }
    return { year: null, make: vehicleString, model: null };
  };

  const handleStartSMS = () => {
    if (!customMessage.trim()) return;

    const scenario = smsScenarios.find(s => s.id === selectedScenario);
    const vehicleString = scenario?.vehicle || customerInfo.vehicle;
    
    onStartConversation('sms', customMessage, {
      name: scenario?.customerName || customerInfo.name,
      phone: scenario?.phone || customerInfo.phone,
      vehicle: parseVehicle(vehicleString),
      channel: 'SMS'
    });
  };

  return (
    <div className="sms-simulator">
      <div className="simulator-section">
        <h3>📱 SMS Conversation Simulator</h3>
        <p>Simulate customers texting your auto service number</p>
      </div>

      <div className="phone-mockup">
        <div className="phone-header">
          <div className="phone-info">
            <span className="carrier">Carrier</span>
            <span className="time">2:30 PM</span>
            <span className="battery">🔋 85%</span>
          </div>
        </div>
        
        <div className="sms-conversation">
          <div className="contact-header">
            <div className="contact-name">Auto Service Center</div>
            <div className="contact-number">(555) 123-AUTO</div>
          </div>
          
          <div className="message-area">
            {customMessage && (
              <div className="message outgoing">
                <div className="message-bubble">
                  {customMessage}
                </div>
                <div className="message-time">2:30 PM</div>
              </div>
            )}
            
            {!customMessage && (
              <div className="placeholder-message">
                Select a scenario or type a custom message...
              </div>
            )}
          </div>
          
          <div className="sms-input">
            <input
              type="text"
              value={customMessage}
              onChange={(e) => setCustomMessage(e.target.value)}
              placeholder="Type your message..."
              className="message-input"
            />
            <button 
              onClick={handleStartSMS}
              disabled={!customMessage.trim()}
              className="send-sms-button"
            >
              Send
            </button>
          </div>
        </div>
      </div>

      <div className="scenarios-section">
        <h4>Quick Scenarios</h4>
        <div className="scenarios-grid">
          {smsScenarios.map((scenario) => (
            <div 
              key={scenario.id}
              className={`scenario-card ${selectedScenario === scenario.id ? 'selected' : ''}`}
              onClick={() => handleScenarioSelect(scenario)}
            >
              <div className="scenario-title">{scenario.title}</div>
              <div className="scenario-customer">{scenario.customerName}</div>
              <div className="scenario-vehicle">{scenario.vehicle}</div>
              <div className="scenario-preview">"{scenario.message.substring(0, 50)}..."</div>
            </div>
          ))}
        </div>
      </div>

      <div className="custom-customer">
        <h4>Custom Customer Info</h4>
        <div className="customer-form">
          <input
            type="text"
            placeholder="Customer Name"
            value={customerInfo.name}
            onChange={(e) => setCustomerInfo({...customerInfo, name: e.target.value})}
          />
          <input
            type="tel"
            placeholder="Phone Number"
            value={customerInfo.phone}
            onChange={(e) => setCustomerInfo({...customerInfo, phone: e.target.value})}
          />
          <input
            type="text"
            placeholder="Vehicle (e.g., 2020 Honda Civic)"
            value={customerInfo.vehicle}
            onChange={(e) => setCustomerInfo({...customerInfo, vehicle: e.target.value})}
          />
        </div>
      </div>
    </div>
  );
};

export default SMSSimulator;