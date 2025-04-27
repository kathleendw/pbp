from django.db import models
from django.contrib.auth.models import User

# Create your models here.
class FAQContent(models.Model):
    question = models.CharField(max_length=200)
    answer = models.TextField()
    def __str__(self):
        return self.question

class SearchFAQHistory(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name="search_history", null=True)
    search = models.CharField(max_length=200)
    def __str__(self):
        return self.search
