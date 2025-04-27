from django.contrib.auth.models import User
from django.contrib.auth import BACKEND_SESSION_KEY, HASH_SESSION_KEY, SESSION_KEY, authenticate, login, logout
from django.http import JsonResponse, response
import json
from django.utils.dateparse import parse_date
from django.views.decorators.csrf import csrf_exempt
from time import sleep

from django.http import HttpResponse
from django.core import serializers

from . import  models as mdl

#from target_profile.models import PhysicalInfo, Profile


@csrf_exempt
def profile_flutter(request, username):
    print(username+"-------")
    # data = json.loads(request.body)
    user = User.objects.get(username=username)
    sleep(0)
    if user is not None:
        print(user.username)

        # profile = mdl.Profile.objects.get(user=user)        
        # #bod = profile.birthday

        # return JsonResponse({
        #     "username": username,
        #     "bod": profile.name or "belum diatur",
        #     "bio": profile. or "belum diatur",
        #     "email": profile.email
        # }, status=200)
        try:
            profile = mdl.Profile.objects.get(
                user = request.user
            )
        except mdl.Profile.MultipleObjectsReturned:
            profile = mdl.Profile.objects.filter(
                user = request.user
            ).last()
        except mdl.PhysicalInfo.DoesNotExist:
            profile = "Belum diatur"
        return HttpResponse(serializers.serialize("json", profile), content_type="application/json")
    else:
        return JsonResponse({}, status = 404)
    
@csrf_exempt
def target_flutter(request, username):
    print(username+"-------")
    # data = json.loads(request.body)
    user = User.objects.get(username=username)
    sleep(0)
    if user is not None:
        print(user.username)

        # profile = mdl.Profile.objects.get(user=user)        
        # #bod = profile.birthday

        # return JsonResponse({
        #     "username": username,
        #     "bod": profile.name or "belum diatur",
        #     "bio": profile. or "belum diatur",
        #     "email": profile.email
        # }, status=200)
        try:
            target = mdl.PhysicalInfo.objects.get(
                user = request.user
            )
        except mdl.PhysicalInfo.MultipleObjectsReturned:
            target = mdl.PhysicalInfo.objects.filter(
                user = request.user
            ).last()
        except mdl.PhysicalInfo.DoesNotExist:
            target = "Belum diatur"
        return HttpResponse(serializers.serialize("json", target), content_type="application/json")
    else:
        return JsonResponse({}, status = 404)



@csrf_exempt
def edit_profile_flutter(request):
    data = json.loads(request.body)
    username = data['username']
    user = User.objects.get(username=username)
    print(data['email'])
    sleep(0)
    # return JsonResponse({}, status=200)
    if user is not None:
        user_profile = mdl.Profile.objects.get(user=user)  # Mendapatkan profile berdasarkan user
        # user_profile.birthday = parse_date(data['bod'][:10])
        # user_profile.bio = data['bio']
        user_profile.name = data['name']
        user_profile.phone = data['phone']
        user_profile.email = data['email']
        user_profile.role = data['role']
        user_profile.save() 
        return JsonResponse({}, status=200)
    else:
        return JsonResponse({}, status=404)