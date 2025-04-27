from django.contrib.auth.models import User
from django.db import models
from django.utils.translation import gettext_lazy as _

# Create your models here.

class GenderChoices(models.TextChoices):
    M = 'm', _("Male")
    F = 'f', _("Female")

class RoleChoices(models.TextChoices):
    USR = "1", _("User")
    INS = "2", _("Instructor")

class Profile(models.Model):
    user = models.OneToOneField(
        User,
        on_delete=models.CASCADE
    )
    name = models.CharField(
        max_length=50
    )
    phone = models.CharField(
        max_length=15
    )
    email = models.EmailField()
    role = models.CharField(
        choices=RoleChoices.choices,
        max_length=1
    )

class PhysicalInfo(models.Model):
    user = models.ForeignKey(
        User,
        on_delete=models.CASCADE
    )
    weight = models.FloatField(
        ("My Weight")
    )
    height = models.FloatField(
        ("My Height")
    )
    age = models.PositiveIntegerField(
        ("My Age")
    )
    gender = models.CharField(
        choices=GenderChoices.choices,
        max_length=7,
        verbose_name="My Gender"
    )
    calories = models.FloatField()
    water = models.IntegerField()
    exercise = models.IntegerField()
    sleep = models.CharField(
        ("Sleep Time"),
        max_length=20
    )
    date = models.DateTimeField(
        auto_now_add = True
    )
