from django.shortcuts import render, redirect

def welcome(request):
    
    return render(request,'aboutme/aboutme_home.html')