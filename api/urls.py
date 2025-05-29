from django.urls import path
from .views import *
urlpatterns=[
    path('send-otp/',send_OTP),
    path('verify-otp/',verify_OTP),
    path("create-user/",create_user),
    path("update-user/",update_user),
    path("delete-user/",delete_user) 
]