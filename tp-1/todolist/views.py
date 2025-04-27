from django.shortcuts import render
from todolist.models import Task
from django.shortcuts import redirect
from django.contrib.auth.forms import UserCreationForm
from django.contrib import messages
from django.contrib.auth import authenticate, login
from django.contrib.auth import logout
from django.contrib.auth.decorators import login_required
import datetime
from django.http import HttpResponseRedirect
from django.urls import reverse
from todolist.forms import AddTask
from django.http import HttpResponse
from django.core import serializers
from django.views.decorators.csrf import csrf_exempt

# TODO: Create your views here.

@login_required(login_url='/todolist/login/')
def show_todolist(request):
    todolist_item = Task.objects.filter(user=request.user)
    context = {
        'list_barang': todolist_item,
        'username': request.user,
    }
    return render(request, "todolist.html", context)

@login_required(login_url='/todolist/login/')
@csrf_exempt
def add_task(request):
    if request.method == "POST":
        title = request.POST.get("title")
        description = request.POST.get("description")
        Task.objects.create(user=request.user, title=title, description=description, date=datetime.datetime.now())
        return HttpResponse()
    else:
        print("here")
        return redirect("todolist:show_todolist")

def show_json(request):
    todolist_item = Task.objects.filter(user=request.user)
    return HttpResponse(serializers.serialize("json", todolist_item), content_type="application/json")

def register(request):
    form = UserCreationForm()

    if request.method == "POST":
        form = UserCreationForm(request.POST)
        if form.is_valid():
            form.save()
            messages.success(request, 'Akun telah berhasil dibuat!')
            return redirect('todolist:login')
    
    context = {'form':form}
    return render(request, 'register.html', context)

def login_user(request):
    if request.method == 'POST':
        username = request.POST.get('username')
        password = request.POST.get('password')
        user = authenticate(request, username=username, password=password)
        if user is not None:
            login(request, user) # melakukan login terlebih dahulu
            response = HttpResponseRedirect(reverse("todolist:show_todolist")) # membuat response
            return response
        else:
            messages.info(request, 'Username atau Password salah!')
    context = {}
    return render(request, 'login.html', context)

def logout_user(request):
    logout(request)
    response = HttpResponseRedirect(reverse('todolist:login'))
    return response

def create_task(request):
    form = AddTask()

    if request.method == 'POST':
        form = AddTask(request.POST)
        if form.is_valid():
            title = form.cleaned_data['title']
            description = form.cleaned_data['description']
            addTask = Task(user=request.user, title=title, description=description, date=datetime.datetime.now())
            addTask.save()
            return redirect('todolist:show_todolist')

    context = {'form':form}
    return render(request, 'form.html', context)

    