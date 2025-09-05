const API_BASE_URL = "http://localhost:8080/api/chat";

// Utility function to parse vehicle string into VehicleDTO object
const parseVehicleString = (vehicleString) => {
  if (!vehicleString) {
    return null;
  }

  // Handle cases where vehicle is already an object
  if (typeof vehicleString === "object") {
    return vehicleString;
  }

  // If it's not a string, return null
  if (typeof vehicleString !== "string") {
    return null;
  }

  // Parse string like "2021 Ford F-150" or "2020 Honda Civic"
  const parts = vehicleString.trim().split(" ");

  if (parts.length >= 3) {
    const year = parseInt(parts[0]);
    const make = parts[1];
    const model = parts.slice(2).join(" "); // Handle multi-word models like "F-150"

    return {
      year: isNaN(year) ? null : year,
      make: make,
      model: model,
    };
  } else if (parts.length === 2) {
    // Handle cases like "Honda Civic" without year
    return {
      year: null,
      make: parts[0],
      model: parts[1],
    };
  }

  // If we can't parse it, return a basic structure
  return {
    year: null,
    make: vehicleString,
    model: null,
  };
};

export const sendMessage = async ({ sessionId, message, context }) => {
  try {
    // Process the context to convert vehicle string to VehicleDTO object
    const processedContext = {
      ...context,
      vehicle: parseVehicleString(context?.vehicle),
    };

    console.log("Original context:", context);
    console.log("Processed context:", processedContext);

    const response = await fetch(`${API_BASE_URL}/send`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        sessionId,
        message,
        context: processedContext,
        timestamp: new Date().toISOString(),
      }),
    });
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }

    const json = await response.json();
    console.log("Response JSON:", json);
    return json;
  } catch (error) {
    console.error("Error sending message:", error);
    throw error;
  }
};

export const getChatHistory = async (sessionId) => {
  try {
    const response = await fetch(`${API_BASE_URL}/history/${sessionId}`, {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
      },
    });

    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }

    return await response.json();
  } catch (error) {
    console.error("Error fetching chat history:", error);
    throw error;
  }
};

export const updateContext = async (sessionId, context) => {
  try {
    const response = await fetch(`${API_BASE_URL}/context`, {
      method: "PUT",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        sessionId,
        context,
      }),
    });

    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }
    return await response.json();
  } catch (error) {
    console.error("Error updating context:", error);
    throw error;
  }
};
