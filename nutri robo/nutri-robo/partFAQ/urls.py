from django.urls import path
from partFAQ.views import *

app_name = 'partFAQ'

urlpatterns = [
    path('', mainPageFAQ, name='mainPageFAQ'),
    path('get_faq_content/', getFAQContent, name='getFAQContent'),
    path('<int:id>/', showFAQbyId, name='showFAQbyId'),
    path('search/', searchFAQ, name='searchFAQ'),
    path('faq-search-history/', showFAQSearchHistory, name='showFAQSearchHistory'),
    path('faq-search-history/delete/', deleteFAQSearchHistory, name='deleteFAQSearchHistory')
]