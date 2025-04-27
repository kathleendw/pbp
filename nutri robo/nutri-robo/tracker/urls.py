from django.urls import path
from tracker.views import show_tracker
from tracker.views import add_calorie
from tracker.views import show_calorie_json
from tracker.views import delete_calorie
from tracker.views import add_water
from tracker.views import show_water_json
from tracker.views import delete_water
from tracker.views import add_exercise
from tracker.views import show_exercise_json
from tracker.views import delete_exercise
from tracker.views import add_sleep
from tracker.views import show_sleep_json
from tracker.views import delete_sleep
from tracker.views import deleteCalorief
from tracker.views import calorief
from tracker.views import deleteExercisef
from tracker.views import exercisef
from tracker.views import deleteWaterf
from tracker.views import waterf
from tracker.views import deleteSleepf
from tracker.views import sleepf

app_name = 'tracker'  

urlpatterns = [
    path('', show_tracker, name='show_tracker'),
    path('add-calorie/', add_calorie, name='add_calorie'),
    path('calorie-json/', show_calorie_json, name='show_calorie_json'),
    path('delete-calorie/<int:id>', delete_calorie, name='delete_calorie'),
    path('add-water/', add_water, name='add_water'),
    path('water-json/', show_water_json, name='show_water_json'),
    path('delete-water/<int:id>', delete_water, name='delete_water'),
    path('add-exercise/', add_exercise, name='add_exercise'),
    path('exercise-json/', show_exercise_json, name='show_exercise_json'),
    path('delete-exercise/<int:id>', delete_exercise, name='delete_exercise'),
    path('add-sleep/', add_sleep, name='add_sleep'),
    path('sleep-json/', show_sleep_json, name='show_sleep_json'),
    path('delete-sleep/<int:id>', delete_sleep, name='delete_sleep'),
    path('delete-calorief/', deleteCalorief, name='deleteCalorief'),
    path('calorief/', calorief, name='calorief'),
    path('delete-exercisef/', deleteExercisef, name='deleteExercisef'),
    path('exercisef/', exercisef, name='exercisef'),
    path('delete-waterf/', deleteWaterf, name='deleteWaterf'),
    path('waterf/', waterf, name='waterf'),
    path('delete-sleepf/', deleteSleepf, name='deleteSleepf'),
    path('sleepf/', sleepf, name='sleepf'),
]