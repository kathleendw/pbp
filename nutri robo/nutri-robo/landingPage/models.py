from django.db import models
from django.contrib.auth.models import User

# Create your models here.
class FeedbackItem(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, null = True, blank = True)
    date = models.DateField(auto_now_add=True)
    rating = models.IntegerField()
    feedback = models.TextField()
