const axios = require('axios');
const MockAdapter = require('axios-mock-adapter');
const { getWelcomeMessage, startPipeline, getPipelineStatus } = require('./frontend');

describe('Frontend API Tests', () => {
  let mock;

  beforeEach(() => {
    mock = new MockAdapter(axios);
  });

  afterEach(() => {
    mock.restore();
  });

  it('should fetch the welcome message', async () => {
    mock.onGet('http://localhost:5000/').reply(200, {
      message: 'Welcome to the CI/CD Pipeline API',
    });

    const message = await getWelcomeMessage();
    expect(message).toBe('Welcome to the CI/CD Pipeline API');
  });

  it('should start a new pipeline', async () => {
    const mockResponse = {
      message: 'Pipeline started successfully',
      id: '12345',
    };

    mock.onPost('http://localhost:5000/pipeline/start').reply(201, mockResponse);

    const result = await startPipeline('main');
    expect(result.message).toBe('Pipeline started successfully');
    expect(result.id).toBe('12345');
  });

  it('should fetch pipeline status', async () => {
    const pipelineId = '12345';
    const mockResponse = {
      id: pipelineId,
      branch: 'main',
      status: 'running',
      progress: 50,
    };

    mock.onGet(`http://localhost:5000/pipeline/status/${pipelineId}`).reply(200, mockResponse);

    const result = await getPipelineStatus(pipelineId);
    expect(result.id).toBe(pipelineId);
    expect(result.branch).toBe('main');
    expect(result.status).toBe('running');
    expect(result.progress).toBe(50);
  });
});
