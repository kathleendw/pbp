from django.db import models
from tinymce.models import HTMLField

# Create your models here.

class Post(models.Model):
    title = models.CharField(max_length=255) # menyimpan judul artikel
    slug = models.SlugField() # menyimpan alamat URL artikel
    intro = HTMLField() # menyimpan post excerpt
    body = HTMLField() # menyimpan detail post
    created_at = models.DateTimeField(auto_now_add=True) # menyimpan kapan artikel dipost secara otomatis 

    class Meta:
        ordering = ('-created_at',)
    
    def __str__(self):
        return self.title

class Comment(models.Model):
    post = models.ForeignKey(Post, related_name='comments', on_delete=models.CASCADE) # reference ke post yg dicomment
    name = models.CharField(max_length=255) # nama yang comment
    email = models.EmailField() # email yang comment
    comment = models.TextField() # isi comment
    created_at = models.DateTimeField(auto_now_add=True) # tanggal comment

    class Meta:
        ordering = ('created_at',)

    def __str__(self):
        return f'Comment by {self.name} on {self.post}'