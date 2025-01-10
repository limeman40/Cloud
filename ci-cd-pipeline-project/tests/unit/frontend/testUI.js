// testui.js

const axios = require('axios');

describe('UI Tests for CI/CD App', () => {
  const baseUrl = 'http://localhost:5000';

  test('Home page should return a welcome message', async () => {
    const response = await axios.get(`${baseUrl}/`);
    expect(response.status).toBe(200);
    expect(response.data).toHaveProperty('message', 'Welcome to the CI/CD Demo App!');
  });

  test('Health endpoint should return status UP', async () => {
    const response = await axios.get(`${baseUrl}/health`);
    expect(response.status).toBe(200);
    expect(response.data).toHaveProperty('status', 'UP');
  });

  test('Invalid endpoint should return 404', async () => {
    try {
      await axios.get(`${baseUrl}/invalid`);
    } catch (error) {
      expect(error.response.status).toBe(404);
    }
  });
});
