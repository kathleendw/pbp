from django import forms
from django.core.validators import RegexValidator

from . import models as md

def phone_number():
    return RegexValidator(
        r'^(?:08|\+?628)\s?(?:\d\s?){6,12}',
        "Nomor HP diawali: '08', atau '628'. Minimal 6 sampai 12 angka"
    )

def only_letters():
    return RegexValidator(
        r'^[a-zA-Z,.\s]+$',
        'Hanya huruf, spasi, titik, dan koma'
    )

class FormProfile(forms.ModelForm):
    class Meta:
        model = md.Profile
        exclude = ['user']
    
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.fields['name'].validators = [only_letters()]
        self.fields['phone'].validators = [phone_number()]

class FormPhysicalInfo(forms.ModelForm):
    class Meta:
        model = md.PhysicalInfo
        fields = [
            'weight','height',
            'age','gender'
        ]