from django.http import JsonResponse
from django.shortcuts import render
from django.views.generic import TemplateView
from django.views.generic.edit import BaseFormView

class InsertOrUpdateMixin(BaseFormView, TemplateView):
    template_name = 'profile/forms/modal_form.html'
    model = None

    def get_instance(self):
        try:
            qs = self.model.objects.get(
                user = self.request.user
            )
        except self.model.DoesNotExist:
            qs = None
        return qs
    
    def post(self, *args, **kwargs):
        form = self.get_form_class()(
            self.request.POST,
            instance = self.get_instance()
        )

        if form.is_valid():
            return self.form_valid(form)
        else:
            return self.form_invalid(form)
    
    def get(self, *args, **kwargs):
        form = self.get_form_class()(
            instance = self.get_instance()
        )
        names = self.form_class.__name__ \
            if isinstance(self.form_class, type) \
                else self.form_class.__class__.__name__
        text_form = "".join(' '+x if 'A' <= x <= 'Z' else x for x in names)
        return render(
            self.request,
            self.template_name,
            {
                "form": form,
                "text_form": text_form
            }
        )
    
    def form_valid(self, form):
        f = form.save(commit=False)
        f.user_id = self.request.user.id
        f.save()
        return JsonResponse(data={"success": True}, safe=False)
    
    def form_invalid(self, form):
        context = {
            'success': False,
            'err_code': 'invalid_form',
            'err_msg': form.errors
        }
        return JsonResponse(context, safe=False)