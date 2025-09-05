import React, { useState } from 'react';

const EmailSimulator = ({ onStartConversation, customerInfo, setCustomerInfo }) => {
  const [selectedTemplate, setSelectedTemplate] = useState('');
  const [emailContent, setEmailContent] = useState({
    subject: '',
    body: ''
  });

  const emailTemplates = [
    {
      id: 'service_inquiry',
      title: 'Service Inquiry',
      customerName: 'Jennifer Martinez',
      email: 'jennifer.martinez@email.com',
      vehicle: '2019 BMW X3',
      subject: 'Service Appointment Request',
      body: `Hello,

I hope this email finds you well. I am writing to inquire about scheduling a service appointment for my 2019 BMW X3.

The vehicle has about 45,000 miles on it, and I believe it's time for the recommended maintenance service. Could you please let me know:

1. What services are recommended at this mileage?
2. Available appointment times next week?
3. Estimated cost and duration?

I prefer morning appointments if possible. Please let me know what works best.

Thank you for your time.

Best regards,
Jennifer Martinez
Phone: (555) 234-5678`
    },
    {
      id: 'warranty_question',
      title: 'Warranty Question',
      customerName: 'David Thompson',
      email: 'david.thompson@company.com',
      vehicle: '2022 Tesla Model 3',
      subject: 'Warranty Service Question - Tesla Model 3',
      body: `Dear Service Team,

I recently purchased a 2022 Tesla Model 3 and have a few questions about warranty service coverage.

I've noticed a small rattling noise coming from the dashboard area. The vehicle is still under warranty, and I want to ensure this is addressed properly.

Questions:
- Is this type of issue covered under warranty?
- Do I need to schedule through Tesla or can you handle warranty work?
- What documentation do I need to bring?

The vehicle has only 3,200 miles on it, purchased 2 months ago.

Looking forward to your guidance.

Best,
David Thompson
VIN: 5YJ3E1EA8NF123456`
    },
    {
      id: 'fleet_service',
      title: 'Fleet Service Request',
      customerName: 'Amanda Rodriguez',
      email: 'amanda@logistics-pro.com',
      vehicle: 'Fleet of 5 vehicles',
      subject: 'Fleet Maintenance Schedule - Logistics Pro Inc.',
      body: `Good morning,

I am the fleet manager for Logistics Pro Inc., and we need to schedule maintenance for our delivery vehicles.

Fleet Details:
- 3x 2020 Ford Transit Vans
- 2x 2021 Chevrolet Express Cargo Vans
- All vehicles are due for oil changes and safety inspections

We prefer to schedule all vehicles on the same day to minimize downtime. Our vehicles are in operation Monday-Friday, so weekend service would be ideal.

Could you provide:
1. Availability for weekend service
2. Fleet discount pricing
3. Estimated time per vehicle
4. Loaner vehicle options if needed

We've been customers for 3 years and appreciate your excellent service.

Thank you,
Amanda Rodriguez
Fleet Manager, Logistics Pro Inc.
Direct: (555) 987-6543`
    },
    {
      id: 'complaint_followup',
      title: 'Service Complaint Follow-up',
      customerName: 'Richard Chen',
      email: 'richard.chen@email.com',
      vehicle: '2020 Audi A4',
      subject: 'Follow-up on Recent Service Experience',
      body: `Hello,

I am writing regarding the service I received last Tuesday (Invoice #12345) for my 2020 Audi A4.

While I appreciate the work done on the brake replacement, I have some concerns:

1. The service took longer than initially quoted (6 hours vs. 3 hours)
2. I was not notified about the delay until I called
3. The final cost was $150 higher than the estimate

I understand that sometimes complications arise, but better communication would have been appreciated. I've been a loyal customer for 5 years and hope we can address these concerns.

Could we schedule a brief call to discuss this? I believe in resolving issues directly and maintaining our good relationship.

Thank you for your attention to this matter.

Sincerely,
Richard Chen
Phone: (555) 456-7890
Customer since 2018`
    }
  ];

  const handleTemplateSelect = (template) => {
    setSelectedTemplate(template.id);
    setCustomerInfo({
      name: template.customerName,
      email: template.email,
      phone: '',
      vehicle: template.vehicle
    });
    setEmailContent({
      subject: template.subject,
      body: template.body
    });
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

  const handleStartEmail = () => {
    if (!emailContent.body.trim()) return;

    const template = emailTemplates.find(t => t.id === selectedTemplate);
    const vehicleString = template?.vehicle || customerInfo.vehicle;
    
    // Convert email to chat message
    const chatMessage = `Subject: ${emailContent.subject}\n\n${emailContent.body}`;
    
    onStartConversation('email', chatMessage, {
      name: template?.customerName || customerInfo.name,
      email: template?.email || customerInfo.email,
      vehicle: parseVehicle(vehicleString),
      channel: 'Email',
      subject: emailContent.subject
    });
  };

  return (
    <div className="email-simulator">
      <div className="simulator-section">
        <h3>📧 Email Conversation Simulator</h3>
        <p>Simulate customers emailing your service department</p>
      </div>

      <div className="email-mockup">
        <div className="email-header">
          <div className="email-toolbar">
            <span className="email-logo">📧 AutoService Mail</span>
            <div className="email-actions">
              <button className="email-btn">Reply</button>
              <button className="email-btn">Forward</button>
              <button className="email-btn">Delete</button>
            </div>
          </div>
        </div>

        <div className="email-content">
          <div className="email-meta">
            <div className="email-from">
              <strong>From:</strong> {customerInfo.name || 'Customer'} &lt;{customerInfo.email || 'customer@email.com'}&gt;
            </div>
            <div className="email-to">
              <strong>To:</strong> service@autorepair.com
            </div>
            <div className="email-date">
              <strong>Date:</strong> {new Date().toLocaleString()}
            </div>
          </div>

          <div className="email-subject">
            <input
              type="text"
              placeholder="Email Subject"
              value={emailContent.subject}
              onChange={(e) => setEmailContent({...emailContent, subject: e.target.value})}
              className="subject-input"
            />
          </div>

          <div className="email-body">
            <textarea
              placeholder="Email body content..."
              value={emailContent.body}
              onChange={(e) => setEmailContent({...emailContent, body: e.target.value})}
              className="body-textarea"
              rows={12}
            />
          </div>

          <div className="email-actions-bottom">
            <button 
              onClick={handleStartEmail}
              disabled={!emailContent.body.trim()}
              className="send-email-button"
            >
              Send Email & Start Chat
            </button>
          </div>
        </div>
      </div>

      <div className="email-templates">
        <h4>Email Templates</h4>
        <div className="templates-list">
          {emailTemplates.map((template) => (
            <div 
              key={template.id}
              className={`template-card ${selectedTemplate === template.id ? 'selected' : ''}`}
              onClick={() => handleTemplateSelect(template)}
            >
              <div className="template-title">{template.title}</div>
              <div className="template-from">{template.customerName}</div>
              <div className="template-subject">Subject: {template.subject}</div>
              <div className="template-preview">
                {template.body.substring(0, 100)}...
              </div>
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
            type="email"
            placeholder="Email Address"
            value={customerInfo.email}
            onChange={(e) => setCustomerInfo({...customerInfo, email: e.target.value})}
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

export default EmailSimulator;