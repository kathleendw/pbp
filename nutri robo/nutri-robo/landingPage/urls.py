from django.urls import path
from landingPage.views import show_landingPage, register, login_user, logout_user, add_feedback, delete_feedback, show_allFeedback_json, show_userFeedback_json, show_user_json

from core.views import about, frontpage # dari aplikasi core (afiq)

app_name = 'landingPage'

urlpatterns = [
    path('', show_landingPage, name='show_landingPage'),
    path('register/', register, name='register'),
    path('login/', login_user, name='login_user'),
    path('logout/', logout_user, name='logout_user'),
    path('add-feedback/', add_feedback, name='add_feedback'),
    path('delete-task/<int:pk>', delete_feedback, name='delete_feedback'),
    path('json-all/', show_allFeedback_json, name='show_allFeedback_json'),
    path('json-user/', show_userFeedback_json, name='show_userFeedback_json'),
    path('blog/', frontpage, name='frontpage'), # dari aplikasi core --> halaman list artikel (afiq)
    path('blog/about', about, name='about'), # dari aplikasi core --> halaman about (afiq)
    path('users/', show_user_json, name='show_user_json'),
]