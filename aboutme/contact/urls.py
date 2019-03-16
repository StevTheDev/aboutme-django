from django.urls import path
from django.contrib.auth.views import LoginView, LogoutView
from .views import new_contact_submission, contact_submit_success

urlpatterns = [
    path('', new_contact_submission, name='new_contact_submission'),
    path('success',contact_submit_success, name='contact_submit_success')
]