from django.urls import path
from .views import primes
urlpatterns = [
    path('primes',primes,name='primes')
]
