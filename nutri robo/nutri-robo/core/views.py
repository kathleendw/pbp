from django.shortcuts import render

from blog.models import Post

# Create your views here.

# Halaman depan
def frontpage(request):
    posts = Post.objects.all() # mendapatkan semua object Post dari database
    return render(request, 'core/frontpage.html', {'posts': posts})

# Halaman about
def about(request):
    return render(request, 'core/about.html')
