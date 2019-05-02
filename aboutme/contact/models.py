from django.db import models

class ContactSubmissionQuerySet(models.QuerySet):
    def unread(self):
        return self.filter(
            Q(read = False)
        )

# Create your models here.
class ContactSubmission(models.Model):
    return_address = models.EmailField(
        verbose_name='Email Address'
    )
    submission_time = models.DateTimeField(auto_now_add=True)
    message = models.CharField(max_length=500)
    read = models.BooleanField(default=False)
    objects = ContactSubmissionQuerySet.as_manager() 