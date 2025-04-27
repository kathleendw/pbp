from django.contrib.auth.decorators import login_required
from django.contrib.auth.forms import UserCreationForm
from django.contrib.auth import authenticate, login, logout
from django.contrib import messages
from django.core import serializers
from django.http import HttpResponse, HttpResponseRedirect, JsonResponse
from django.shortcuts import redirect, render
from django.urls import reverse
from .forms import FeedbackForm
from landingPage.models import FeedbackItem
import datetime
from django.contrib.auth.models import User

# Create your views here.

def show_landingPage(request):
    if request.user.is_authenticated:
        form = FeedbackForm(request.POST)
        context = {
            'form': form,
            'last_login': request.COOKIES['last_login'],
        }
        return render(request, 'landingPage.html', context)
    else:
        return render(request, 'landingPage.html')

def register(request):
    form = UserCreationForm()
    if request.method == "POST":
        form = UserCreationForm(request.POST)
        if form.is_valid():
            form.save()
            messages.success(request, 'Account has been created successfully!')
            return redirect('landingPage:login_user')
    context = {'form':form}
    return render(request, 'register.html', context) 


def login_user(request):
    if request.method == 'POST':
        username = request.POST.get('username')
        password = request.POST.get('password')
        user = authenticate(request, username=username, password=password)
        if user is not None:
            login(request, user)
            response = HttpResponseRedirect(reverse("landingPage:show_landingPage")) # membuat response
            response.set_cookie('last_login', str(datetime.datetime.now()))
            return response
        else:
            messages.info(request, 'Invalid username or password')
    context = {}
    return render(request, 'login.html', context)

def logout_user(request):
    logout(request)
    response = HttpResponseRedirect(reverse("landingPage:show_landingPage"))
    response.delete_cookie('last_login')
    return response

def add_feedback(request): ####    
    form = FeedbackForm(request.POST)

    if request.method == 'POST':
        if form.is_valid():
            feedback = form.save(commit=False)
            feedback.user = request.user
            feedback.save()
            response = HttpResponseRedirect(reverse("landingPage:show_landingPage"))
            return response
    response = HttpResponseRedirect(reverse("landingPage:show_landingPage"))
    return response

def delete_feedback(request, pk):
    data = FeedbackItem.objects.get(id=pk)
    data.delete()
    response = HttpResponseRedirect(reverse("landingPage:show_landingPage"))
    return response

def show_userFeedback_json(request):
    data_feedback = FeedbackItem.objects.filter(user = request.user)
    return HttpResponse(serializers.serialize("json", data_feedback), content_type="application/json")

def show_allFeedback_json(request):
    data_feedback = FeedbackItem.objects.all()
    return HttpResponse(serializers.serialize("json", data_feedback), content_type="application/json")

def show_user_json(request):
    data_user = User.objects.all()
    return HttpResponse(serializers.serialize("json", data_user), content_type="application/json")