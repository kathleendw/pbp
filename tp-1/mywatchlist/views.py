from django.shortcuts import render
from mywatchlist.models import MyWatchListItem
from django.http import HttpResponse
from django.core import serializers

# TODO: Create your views here.
def show_mywatchlist(request):
    mywatchlist_item = MyWatchListItem.objects.all()
    context = {
        'list_barang': mywatchlist_item,
        'nama': 'Kathleen Daniella Wijaya',
        'student_id': '2106637366'
    }
    return render(request, "mywatchlist.html", context)

def show_xml(request):
    mywatchlist_item = MyWatchListItem.objects.all()
    return HttpResponse(serializers.serialize("xml", mywatchlist_item), content_type="application/xml")

def show_json(request):
    mywatchlist_item = MyWatchListItem.objects.all()
    return HttpResponse(serializers.serialize("json", mywatchlist_item), content_type="application/json")
