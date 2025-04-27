from django.urls import path

from . import views

urlpatterns = [
    path('blog/<slug:slug>/', views.detail, name="post_detail"),
    path('blog/json', views.show_post_json, name="show_post_json"),
]

