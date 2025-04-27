from django.db import models

class MyWatchListItem(models.Model):
    watched = models.TextField()
    title = models.TextField()
    rating = models.FloatField()
    release_date = models.TextField()
    review = models.TextField()