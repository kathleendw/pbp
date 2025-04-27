from django import forms
from todolist.models import Task

class AddTask(forms.ModelForm):
    class Meta:
        model = Task
        fields = ('title', 'description')