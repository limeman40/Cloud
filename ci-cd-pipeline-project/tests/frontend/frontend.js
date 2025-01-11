const axios = require('axios');

const API_BASE_URL = 'http://localhost:5000';

async function getWelcomeMessage() {
  const response = await axios.get(`${API_BASE_URL}/`);
  return response.data.message;
}

async function startPipeline(branch) {
  const response = await axios.post(`${API_BASE_URL}/pipeline/start`, { branch });
  return response.data;
}

async function getPipelineStatus(pipelineId) {
  const response = await axios.get(`${API_BASE_URL}/pipeline/status/${pipelineId}`);
  return response.data;
}

module.exports = { getWelcomeMessage, startPipeline, getPipelineStatus };
