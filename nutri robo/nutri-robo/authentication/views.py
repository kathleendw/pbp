from django.shortcuts import render
from django.contrib.auth import authenticate, login as auth_login
from django.contrib.auth import logout
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth.forms import UserCreationForm
from landingPage.models import FeedbackItem
from landingPage.forms import FeedbackForm
from django.http import HttpResponse, HttpResponseRedirect, JsonResponse
from django.shortcuts import redirect, render
from django.urls import reverse
from django.core import serializers
from django.contrib.auth.models import User
from time import sleep

@csrf_exempt
def login(request):
    username = request.POST['username']
    password = request.POST['password']
    user = authenticate(username=username, password=password)
    if user is not None:
        if user.is_active:
            auth_login(request, user)
            # Redirect to a success page.
            return JsonResponse({
            "status": True,
            "message": "Successfully Logged In!"
            # Insert any extra data if you want to pass data to Flutter
            }, status = 200)
        else:
            return JsonResponse({
            "status": False,
            "message": "Failed to Login, Account Disabled."
            }, status = 401)

    else:
        return JsonResponse({
        "status": False,
        "message": "Failed to Login, check your email/password."
        }, status = 401)

@csrf_exempt
def register(request):
    form = UserCreationForm(request.POST)
    if form.is_valid():
        form.save()
        return JsonResponse(
        {
            "status": True,
            "message": "Registration success!",
        }, status = 200)
    else:
        return JsonResponse(
        {
            "status": False,
            "message": "Registration failed!",
            "details": form.errors
        }, status = 400)

@csrf_exempt
def logout_user(request):
    logout(request)
    response = HttpResponseRedirect(reverse("landingPage:show_landingPage"))
    response.delete_cookie('last_login')
    return JsonResponse({
        "status": True,
        "message": "Logged out!"
    }, status = 200)

@csrf_exempt
def add_feedback(request): ####    
    form = FeedbackForm(request.POST)
    if form.is_valid():
        feedback = form.save(commit=False)
        feedback.user = request.user
        feedback.save()
        return JsonResponse(
        {
            "status": True,
            "message": "Feedback successfully added!",
        }, status = 200)
    else:
        return JsonResponse(
            {
                "status": False,
                "message": "Failed to add feedback!",
                "details": form.errors
            }, status = 400)

@csrf_exempt
def delete_feedback(request, pk):
    data = FeedbackItem.objects.get(id=pk)
    data.delete()
    return JsonResponse(
        {
            "status": True,
            "message": "Feedback successfully deleted!",
        }, status = 200)

@csrf_exempt
def show_userFeedback(request, username):
    user = User.objects.get(username = username)
    sleep(0)
    if user is not None:
        data_feedback = FeedbackItem.objects.filter(user = user)
        return HttpResponse(serializers.serialize("json", data_feedback), content_type="application/json")
    else:
        return JsonResponse({}, status=404)
    

