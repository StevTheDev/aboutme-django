from django.forms import ModelForm, Textarea

from .models import ContactSubmission

class ContactSubmissionForm(ModelForm):
    class Meta:
        model = ContactSubmission
        widgets = {
            'message': Textarea
        }

        exclude = (
            'submission_time',
            'read',
        )
    
    def clean(self):
        # Extra Validation Here
        return self.cleaned_data