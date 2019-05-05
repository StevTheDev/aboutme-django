from django.urls import path
from .views import articles_home,new_article, view_article
from django.contrib.auth.views import LoginView, LogoutView
urlpatterns = [
    path('', articles_home, name='articles_home'),
    path('<id>/', view_article, name='view_article'),
    path('new', new_article, name='new_article'),
    
    path('login',
        LoginView.as_view(template_name="articles/login_form.html"),
        name='articles_login'),

    path('logout',LogoutView.as_view(),name='articles_logout'),

]
