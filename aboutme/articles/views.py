from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.decorators import login_required
from django.core.exceptions import PermissionDenied

from .models import Article
from .forms import ArticleForm

@login_required
def new_article(request):
    if request.method == 'GET':
        form = ArticleForm()
        return render(request,'articles/new_article_form.html', {'form':form})
    elif request.method == 'POST':
        article = Article(author = request.user)
        form = ArticleForm(instance=article, data=request.POST)
        
        if form.is_valid():
            form.save()
            return redirect('articles_home')
        pass
    

# Create your views here.
def primes(request):
    return render(request,'articles/primes.html')

def articles_home(request):
    return render(request,'articles/articles_home.html')