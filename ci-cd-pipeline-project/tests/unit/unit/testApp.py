import unittest
from app import app

class TestApp(unittest.TestCase):

    def setUp(self):
        self.app = app.test_client()
        self.app.testing = True

    def test_home_endpoint(self):
        response = self.app.get('/')
        self.assertEqual(response.status_code, 200)
        self.assertIn(b'Welcome to the CI/CD Demo App!', response.data)

    def test_health_endpoint(self):
        response = self.app.get('/health')
        self.assertEqual(response.status_code, 200)
        self.assertIn(b'"status": "UP"', response.data)

    def test_invalid_endpoint(self):
        response = self.app.get('/invalid')
        self.assertEqual(response.status_code, 404)

if __name__ == "__main__":
    unittest.main()
