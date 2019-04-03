import os

from django.db import models
from django.contrib.auth.models import User

# Create your models here.

class Article(models.Model):

    articles_media_body_path = os.path.join('articles','body')

    author = models.ForeignKey(User, on_delete=models.CASCADE,
                                    related_name='authored_articles')
    title = models.CharField(max_length=100)
    body = models.FileField(upload_to=articles_media_body_path)
    code = models.FileField(upload_to=articles_media_body_path, null=True, blank=True)
    language = models.CharField(max_length=20)
    
    created_at = models.DateTimeField(auto_now_add=True)
    modified_at = models.DateTimeField(auto_now=True)
    public = models.BooleanField(default=False)
