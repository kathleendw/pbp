from django.db import models
from django.contrib.auth.models import User

class CalorieTracker(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    date = models.DateTimeField(auto_now_add = True)
    description = models.TextField()
    calorie = models.IntegerField(default=0,null=True,blank=True)
    time = models.CharField(max_length = 300, default='')
    class Meta:
        ordering = ['-date']

class WaterTracker(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    date = models.DateTimeField(auto_now_add = True)
    description = models.TextField()
    water = models.IntegerField(default=0,null=True,blank=True)
    time = models.CharField(max_length = 300, default='')
    class Meta:
        ordering = ['-date']

class ExerciseTracker(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    date = models.DateTimeField(auto_now_add = True)
    description = models.TextField()
    exercise = models.IntegerField(default=0,null=True,blank=True)
    time = models.CharField(max_length = 300, default='')
    class Meta:
        ordering = ['-date']

class SleepTracker(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    date = models.DateTimeField(auto_now_add = True)
    description = models.TextField()
    sleephours = models.IntegerField()
    sleepminutes = models.IntegerField()
    time = models.CharField(max_length = 300, default='')
    class Meta:
        ordering = ['-date']

