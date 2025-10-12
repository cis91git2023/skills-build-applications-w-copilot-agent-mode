// API configuration utility
// This module provides the correct API base URL based on the environment

const getApiUrl = () => {
  const codespace = process.env.REACT_APP_CODESPACE_NAME;
  
  // If we're in a Codespace (and not just localhost), use the Codespace URL
  if (codespace && codespace !== 'localhost') {
    return `https://${codespace}-8000.app.github.dev/api`;
  }
  
  // Otherwise, use localhost
  return 'http://localhost:8000/api';
};

export const API_BASE_URL = getApiUrl();

export const getEndpointUrl = (endpoint) => {
  return `${API_BASE_URL}/${endpoint}/`;
};

export default {
  API_BASE_URL,
  getEndpointUrl
};
