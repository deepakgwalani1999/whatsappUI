from django.db import models
class UserOTP(models.Model):
    phone_number=models.CharField(max_length=15,unique=True)
    otp=models.CharField(max_length=6,null=True,blank=True)
    
    def __str__(self):
        return self.phone_number
    
class User(models.Model):
    user_otp=models.OneToOneField(UserOTP, related_name='user_profile', on_delete=models.CASCADE)
    first_name=models.CharField(max_length=100,null=False,blank=False,default=" ")
    last_name=models.CharField(max_length=100,null=False,blank=False,default=" ")
    user_image=models.FileField(upload_to='./profile_pic/',blank=True,null=True)
    createdAt=models.DateTimeField(auto_now_add=True)
    
    
    def __str__(self):
        return f"{self.first_name} {self.last_name}"
    
    
    
    
    