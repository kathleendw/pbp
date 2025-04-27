from django.contrib.auth.mixins import LoginRequiredMixin
from django.contrib.messages.views import SuccessMessageMixin
from django.http import JsonResponse
from django.urls import reverse_lazy
from django.views.generic import TemplateView
from django.views.generic.edit import CreateView
from django.shortcuts import redirect
from django.http import HttpResponse
from django.core import serializers


from . import forms as frm, models as mdl
from .helpers import InsertOrUpdateMixin
from target_profile.models import PhysicalInfo

# Create your views here.
class CreateProfile(LoginRequiredMixin, SuccessMessageMixin, CreateView):
    template_name = 'profile/forms/form.html'
    form_class = frm.FormProfile
    success_url = reverse_lazy('target_profile:profile')
    success_message: str = "Profile %(name)s berhasil dibuat"
    extra_context = {
        "title": "Buat Profile"
    }

    def form_valid(self, form):
        f = form.save(commit=False)
        f.user_id = self.request.user.id
        f.save()
        return super().form_valid(form)

class UserProfile(LoginRequiredMixin, TemplateView):
    template_name = 'profile/my_profile.html'
    extra_context = {
        "title": "Target Health"
    }

    def get_target(self):
        try:
            obj = mdl.PhysicalInfo.objects.get(
                user = self.request.user
            )
        except mdl.PhysicalInfo.MultipleObjectsReturned:
            obj = mdl.PhysicalInfo.objects.filter(
                user = self.request.user
            ).last()
        except mdl.PhysicalInfo.DoesNotExist:
            obj = None
        return obj

    def get_profile(self):
        try:
            obj = mdl.Profile.objects.get(
                user = self.request.user
            )
        except mdl.Profile.DoesNotExist:
            obj = None
        return obj
    
    def get(self, *args, **kwargs):
        profile = self.get_profile()
        target = self.get_target()

        if profile is None:
            return redirect(reverse_lazy('target_profile:create_profile'))

        context = super().get_context_data(
            profile = profile,
            target = target
        )
        return self.render_to_response(context)

    # buat fungsi show todolist in json

    def show_profile_in_json(request): 
        username = request.user.username
        profile_user = mdl.Profile.objects.filter(user = request.user)
        # context = {
        #     'tasks_list': profile_user,
        #     'username': username
        # }
        return HttpResponse(serializers.serialize("json", profile_user), content_type="application/json")

        
    def show_target_in_json(request): 
        username = request.user.username
        target_user = mdl.PhysicalInfo.objects.filter(user = request.user)
        # context = {
        #     'tasks_list': profile_user,
        #     'username': username
        # }
        return HttpResponse(serializers.serialize("json", target_user), content_type="application/json")


class CreateOrUpdateProfile(LoginRequiredMixin, SuccessMessageMixin, InsertOrUpdateMixin):
    model = mdl.Profile
    form_class = frm.FormProfile
    # redirect setelah sukses menyimpan
    success_url = reverse_lazy('target_profile:profile')
    success_message: str = "Berhasil menyimpan"

class CreateOrUpdatePhysicalInfo(LoginRequiredMixin, SuccessMessageMixin, CreateView):
    template_name = 'profile/forms/modal_form.html'
    model = mdl.PhysicalInfo
    form_class = frm.FormPhysicalInfo
    success_url = reverse_lazy('target_profile:profile')
    success_message: str = "Berhasil menyimpan"
    extra_context = {
        "text_form": "Physical Info Form"
    }

    def rumus(self, **kwd):
        # Rumus berdasarkan BMR
        calories = 0
        if kwd['gender'] == mdl.GenderChoices.M:
            calories = (88.4 + 13.4 * kwd['weight']) + (4.8 * kwd['height']) - (5.68 * kwd['age'])
        
        if kwd['gender'] == mdl.GenderChoices.F:
            calories = (447.6 + 9.25 * kwd['weight']) + (3.10 * kwd['height']) - (4.33 * kwd['age'])
        
        # Berdasarkan penelitian
        exercise = 0
        if kwd['age'] in range(7, 18, 1):
            exercise = 60
        if kwd['age'] in range(19, 30, 1):
            exercise = 40
        if kwd['age'] in range(31, 45, 1):
            exercise = 30
        if kwd['age'] in range(46, 60, 1):
            exercise = 15
        
        # Berdasarkan penelitian
        sleep_time = ""
        if kwd['age'] in range(1, 3, 1):
            sleep_time = "12 - 14"
        if kwd['age'] in range(3, 6, 1):
            sleep_time = "10"
        if kwd['age'] in range(6, 12, 1):
            sleep_time = "8 - 9"
        if kwd['age'] in range(12, 18, 1):
            sleep_time = "7 - 8"
        if kwd['age'] in range(18, 40, 1):
            sleep_time = "7"
        if kwd['age'] >= 40:
            sleep_time = "6"
        
        # bb 35Kg = 1500ml, untuk setiap 1Kg setelahnya nambah 40ml
        water = (kwd['weight'] - 25) * 40 + 1500
        resp = {
            "calories": "%.2f" % calories,
            "exercise": exercise,
            "sleep": sleep_time,
            "water": water
        }
        return resp
    
    def form_valid(self, form):
        f = form.save(commit=False)
        data = {
            "gender": form.cleaned_data['gender'],
            "weight": form.cleaned_data['weight'],
            "height": form.cleaned_data['height'],
            "age": form.cleaned_data['age']
        }
        rumus = self.rumus(**data)
        f.calories = rumus['calories']
        f.water = rumus['water']
        f.exercise = rumus['exercise']
        f.sleep = rumus['sleep']
        f.user_id = self.request.user.id
        f.save()
        return JsonResponse(data={"success": True}, safe=False)
    
    def form_invalid(self, form):
        context = {
            'success': False,
            'err_code': 'invalid_form',
            'err_msg': form.errors
        }
        return JsonResponse(context, safe=False)

    def show_json(request):
        item = PhysicalInfo.objects.all()
        return HttpResponse(serializers.serialize("json", item), content_type="application/json")

