from django.http import HttpResponse, HttpResponseNotFound
from django.core import serializers
from django.shortcuts import redirect, render
from django.contrib.auth.decorators import login_required
from partFAQ.models import FAQContent

from .forms import *

@login_required(login_url='/login/')
def mainPageFAQ(request):
    return render(request, 'mainPageFAQ.html')

def getFAQContent(request):
    if request.method == 'GET':
        data = FAQContent.objects.all()
        return HttpResponse(serializers.serialize("json", data ), content_type="application/json")

@login_required(login_url='/login/')
def showFAQbyId(request, id):
    faq = FAQContent.objects.get(pk=id)
    contents = {
        'faq': faq
    }
    return render(request, 'showFAQbyId.html', contents)

def searchFAQ(request):
    if request.method == 'POST':
        searched = request.POST.get('search')
        data = FAQContent.objects.filter(question__contains=searched)

        if (request.user.search_history.filter(search=searched).exists()):
            # bikin history search
            request.user.search_history.filter(search=searched).delete()

        form = SearchFAQForm(request.POST)
        if form.is_valid():
            print("form sudah valid")
            task = form.save(commit=False)
            task.user = request.user
            task.save()
            
        return HttpResponse(serializers.serialize("json", data ), content_type="application/json")

    else:

        return HttpResponseNotFound()

@login_required(login_url='/landingPage/login/')
def showFAQSearchHistory(request):
    data_history = request.user.search_history.all()

    return render(request, 'showFAQSearchHistory.html', {'data':data_history})

def deleteFAQSearchHistory(request):
    data = request.user.search_history.all()
    data.delete()
    return redirect('partFAQ:showFAQSearchHistory')

