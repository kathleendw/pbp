from django import forms
from .models import *

class SearchFAQForm(forms.ModelForm):
    class Meta:
        model = SearchFAQHistory
        exclude = ['user']
        fields = ['search']
        print("form dibuat")