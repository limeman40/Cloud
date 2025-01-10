import requests

def test_home_endpoint():
    response = requests.get("http://localhost:5000/")
    assert response.status_code == 200
    assert response.json().get("message") == "Welcome to the CI/CD Demo App!"

def test_health_endpoint():
    response = requests.get("http://localhost:5000/health")
    assert response.status_code == 200
    assert response.json().get("status") == "UP"

def test_invalid_endpoint():
    response = requests.get("http://localhost:5000/invalid")
    assert response.status_code == 404