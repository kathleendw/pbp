# TODO: Implement Routings Here
from django.urls import path
from katalog.views import show_katalog
from katalog.views import show_json

app_name = 'katalog'

urlpatterns = [
    path('', show_katalog, name='show_katalog'),
    path('json/', show_json, name='show_json'),
]