from django.contrib import admin
from tracker.models import CalorieTracker, SleepTracker, ExerciseTracker, WaterTracker

# Register your models here.
admin.site.register(CalorieTracker)
admin.site.register(SleepTracker)
admin.site.register(ExerciseTracker)
admin.site.register(WaterTracker)
