from django.urls import path
from . import views
from target_profile.views import CreateOrUpdatePhysicalInfo, UserProfile
from  target_profile.flutter_views import profile_flutter, edit_profile_flutter, target_flutter

app_name = 'target_profile'

urlpatterns = [
    path('accounts/profile/', views.UserProfile.as_view(), name='profile'),
    path('create-profile/', views.CreateProfile.as_view(), name='create_profile'),
    path('profile-create-or-update/', views.CreateOrUpdateProfile.as_view(), name='profile_coru'),
    path('target-update/', views.CreateOrUpdatePhysicalInfo.as_view(), name='target_coru'),
    path('accounts/profile/json/', CreateOrUpdatePhysicalInfo.show_json, name='show_json'),
    path('accounts/detail/profile/json/', UserProfile.show_profile_in_json, name='show_profile_in_json'),
    path('accounts/detail/target/json/', UserProfile.show_target_in_json, name='show_target_in_json'),

    path('flutter/profile/<str:username>', profile_flutter, name="flutter-profile"),
    path('flutter/target/<str:username>', target_flutter, name="flutter-target"),
    path('flutter/edit-profile', edit_profile_flutter, name="flutter-edit-profile"),
]