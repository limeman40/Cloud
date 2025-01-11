import pytest
from flask import Flask
from flask.testing import FlaskClient
from app import app  # Ensure 'app.py' has the Flask app instance exported as `app`

@pytest.fixture
def client() -> FlaskClient:
    """
    Fixture to set up the Flask test client.
    """
    app.testing = True
    with app.test_client() as client:
        yield client

def test_home(client):
    """
    Test the root endpoint ("/") to verify it returns the welcome message.
    """
    response = client.get('/')
    assert response.status_code == 200
    assert b"Welcome to the CI/CD Pipeline API" in response.data

def test_health_check(client):
    """
    Test the health check endpoint ("/health") to verify the app status.
    """
    response = client.get('/health')
    assert response.status_code == 200
    assert b"ok" in response.data

def test_start_pipeline_success(client):
    """
    Test starting a pipeline successfully with the correct payload.
    """
    response = client.post('/pipeline/start', json={"branch": "main"})
    assert response.status_code == 201
    assert b"Pipeline started successfully" in response.data

def test_start_pipeline_missing_branch(client):
    """
    Test starting a pipeline without providing the 'branch' in the payload.
    """
    response = client.post('/pipeline/start', json={})
    assert response.status_code == 400
    assert b"Branch name is required" in response.data

def test_pipeline_status_success(client):
    """
    Test fetching the status of a valid pipeline.
    """
    # Start a new pipeline
    response = client.post('/pipeline/start', json={"branch": "main"})
    pipeline_id = response.get_json()["id"]

    # Check its status
    response = client.get(f'/pipeline/status/{pipeline_id}')
    assert response.status_code == 200
    assert b"running" in response.data

def test_pipeline_status_not_found(client):
    """
    Test fetching the status of a non-existent pipeline.
    """
    response = client.get('/pipeline/status/99999')
    assert response.status_code == 404
    assert b"Pipeline not found" in response.data

def test_stop_pipeline_success(client):
    """
    Test stopping a valid pipeline.
    """
    # Start a new pipeline
    response = client.post('/pipeline/start', json={"branch": "main"})
    pipeline_id = response.get_json()["id"]

    # Stop the pipeline
    response = client.post(f'/pipeline/stop/{pipeline_id}')
    assert response.status_code == 200
    assert b"Pipeline stopped successfully" in response.data

def test_stop_pipeline_not_found(client):
    """
    Test stopping a non-existent pipeline.
    """
    response = client.post('/pipeline/stop/99999')
    assert response.status_code == 404
    assert b"Pipeline not found" in response.data

def test_delete_pipeline_success(client):
    """
    Test deleting a valid pipeline.
    """
    # Start a new pipeline
    response = client.post('/pipeline/start', json={"branch": "main"})
    pipeline_id = response.get_json()["id"]

    # Delete the pipeline
    response = client.delete(f'/pipeline/delete/{pipeline_id}')
    assert response.status_code == 200
    assert b"Pipeline deleted successfully" in response.data

def test_delete_pipeline_not_found(client):
    """
    Test deleting a non-existent pipeline.
    """
    response = client.delete('/pipeline/delete/99999')
    assert response.status_code == 404
    assert b"Pipeline not found" in response.data

def test_list_pipelines(client):
    """
    Test listing all pipelines.
    """
    # Start multiple pipelines
    client.post('/pipeline/start', json={"branch": "main"})
    client.post('/pipeline/start', json={"branch": "develop"})

    # List all pipelines
    response = client.get('/pipelines')
    assert response.status_code == 200
    assert b"pipelines" in response.data
