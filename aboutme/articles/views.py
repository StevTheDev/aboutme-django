from django.shortcuts import render, redirect

# Create your views here.
def primes(request):
    return render(request,'articles/primes.html')