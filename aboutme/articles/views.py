from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.decorators import login_required
from django.core.exceptions import PermissionDenied
from django.conf import settings
import os
from .models import Article
from .forms import ArticleForm

@login_required
def new_article(request):
    if request.method == 'POST':
        form = ArticleForm(request.POST, request.FILES)
        if form.is_valid():
            form.instance.author = request.user
            form.save()
            return redirect(articles_home)
    else:
        form = ArticleForm()
        return render(request,'articles/new_article_form.html', {'form':form})

def view_article(request, id):
    article = get_object_or_404(Article, pk = id)
    article_code = open(article.code.path).read()

    body_template_path = article.body.path
    body_template_path = body_template_path.split('\\')
    body_template_path = body_template_path[-3:]
    body_template_path = '/'.join(body_template_path)

    return render(request,'articles/articles_view_article.html', {
        'article':article,
        'body_template_path':body_template_path,
        'article_code':article_code,
    })

def articles_home(request):
    articles_list = Article.objects.filter(public=True)
    return render(request,'articles/articles_home.html',
        {'articles_list':articles_list},
    )