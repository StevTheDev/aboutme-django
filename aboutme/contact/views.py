from django.shortcuts import render, redirect
from .forms import ContactSubmissionForm

# Create your views here.
def new_contact_submission(request):
    if request.method == 'POST':
        form = ContactSubmissionForm(data = request.POST)
        if form.is_valid():
            form.save()
            return redirect('contact_submit_success')
        pass
    else:
        form = ContactSubmissionForm()
    return render(
        request, 
        "contact/new_contact_submission_form.html",
        {
            'form': form,
        }
    )

def contact_submit_success(request):
    return render(request,'contact/contact_submit_success.html')