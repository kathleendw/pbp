from django import forms
from landingPage.models import FeedbackItem

class FeedbackForm(forms.ModelForm):
    class Meta:
        model = FeedbackItem
        fields = {'rating', 'feedback'}