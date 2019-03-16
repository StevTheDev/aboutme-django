from django.contrib import admin
from .models import ContactSubmission


class ContactSubmissionAdmin(admin.ModelAdmin):
    list_display = ('submission_time','return_address','read','message')

    list_editable = ('read',)

admin.site.register(ContactSubmission, ContactSubmissionAdmin)
