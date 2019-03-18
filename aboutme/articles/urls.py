from django.urls import path
from .views import primes, articles_home,new_article, view_article
urlpatterns = [
    path('', articles_home, name='articles_home'),
    path('<id>/', view_article, name='view_article'),
    path('new', new_article, name='new_article'),
    path('primes', primes, name='primes'),
]
