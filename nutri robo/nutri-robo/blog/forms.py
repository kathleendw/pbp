from django import forms
from .models import Comment
from django.forms import TextInput, EmailInput

class CommentForm(forms.ModelForm):
    class Meta:
        model = Comment # model yg digunakan buat form-nya
        fields = ('name', 'email', 'comment') # field yang ingin diminta 
        