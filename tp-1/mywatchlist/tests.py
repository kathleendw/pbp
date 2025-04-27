from django.test import TestCase
from django.test import Client

class MyWatchListTest(TestCase):
    def test_html(self):
        c = Client()
        response = c.get('/mywatchlist/html/')
        self.assertEqual(response.status_code, 200)
    def test_json(self):
        c = Client()
        response = c.get('/mywatchlist/json/')
        self.assertEqual(response.status_code, 200)
    def test_xml(self):
        c = Client()
        response = c.get('/mywatchlist/xml/')
        self.assertEqual(response.status_code, 200)