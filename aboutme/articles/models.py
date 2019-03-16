from django.db import models
from markdownx.models import MarkdownxField
from django.contrib.auth.models import User
# Create your models here.

class Article(models.Model):
    author = models.ForeignKey(User, on_delete=models.CASCADE,
                                    related_name='authored_articles')
    title = models.CharField(max_length=100)
    article_text = MarkdownxField()
    created_at = models.DateTimeField(auto_now_add=True)
    modified_at = models.DateTimeField(auto_now=True)
