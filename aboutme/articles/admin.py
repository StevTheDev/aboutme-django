from django.contrib import admin

# Register your models here.
from .models import Article

class ArticleAdmin(admin.ModelAdmin):
    list_display = ('author','title','created_at','modified_at')

    list_editable = ('title',)

admin.site.register(Article, ArticleAdmin)