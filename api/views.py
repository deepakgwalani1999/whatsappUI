from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
import random
import datetime
from .models import *
otp_store={}
@api_view(['POST'])
def send_OTP(request):
    phone_number=request.data.get("phone_number")
    if not phone_number:
        return Response({"status":False,"message":"Phone number not provided"},status=status.HTTP_400_BAD_REQUEST)
    expiry_time=datetime.datetime.now()+datetime.timedelta(minutes=5)
    otp=random.randint(100000,999999)
    otp_store[phone_number]={"otp":otp,"expire_at":expiry_time}
    print("OTP_STORE>>>>>",otp_store)
    return Response({"status":True,"message":"OTP sent","otp":otp_store[phone_number]["otp"]})
    
        
@api_view(['POST'])
def verify_OTP(request):
    phone_number=request.data.get("phone_number")
    user_otp=request.data.get("otp")
    print("===================")
    print("user_otp",user_otp)
    print("===================")
    if not phone_number or not user_otp:
        return Response({"status":"Plz provide user otp or phone number"},status=status.HTTP_400_BAD_REQUEST)
    
    if phone_number not in otp_store:
        return Response({"status":False,"message":"No otp sent for this number"},status=status.HTTP_400_BAD_REQUEST)
    
    record=otp_store[phone_number]
    
    if datetime.datetime.now() > record["expire_at"]:
        
        del otp_store[phone_number]
        return Response({"status":False,"message":"otp expires"},status=status.HTTP_400_BAD_REQUEST)
    if int(user_otp)==record["otp"]:
        user_otp_obj,_=UserOTP.objects.update_or_create(phone_number=phone_number)
        del otp_store[phone_number]
        return Response({"status":True,"message":"Otp verified successfully"},status=status.HTTP_200_OK)
    else:
        return Response({"status":False,"message":"Invalid Otp"},status=status.HTTP_400_BAD_REQUEST)
    
    
@api_view(["POST"])
def create_user(request):
    first_name=request.data.get("first_name")
    last_name=request.data.get("last_name")
    user_image=request.FILES.get("user_image")
    phone_number=request.data.get("phone_number")
    if not first_name or not last_name or not phone_number:
            return Response({"status":False,"message":"Plz Provide the required Fields"},status=status.HTTP_400_BAD_REQUEST)
    try:
        user_otp=UserOTP.objects.get(phone_number=phone_number)
        if User.objects.filter(user_otp__phone_number=phone_number).exists():
            return Response({"status":False,"message":"User Already Exists with this phone number"})
        
        user=User.objects.create(
            user_otp=user_otp,
            first_name=first_name,
            last_name=last_name,
            user_image=user_image
        )
        user.save()
       
        
        data={
            "phoneNumberID":user.user_otp.id,
            "phone_number":user.user_otp.phone_number,
            "first_name":user.first_name,
            "last_name":user.last_name,
            "user_image":str(user.user_image.url) if user.user_image else None,
            "createdAt":user.createdAt.strftime("%Y-%m-%d %H:%M:%S")
            
        }
        
        return Response({"status":True,"message":"User Verified Successfully","user":data},status=status.HTTP_200_OK)
    
    except Exception as e:
        return Response({"status":False,"message":"Something Went Wrong","error":str(e)},status=status.HTTP_400_BAD_REQUEST)
#Update api   
@api_view(["POST"])
def update_user(request):
    user_id=request.data.get("user_id")
    

    if not user_id:
        return Response({"status":False,"message":"Plz provide required field"},status=status.HTTP_400_BAD_REQUEST)
    try:
        user=User.objects.get(id=user_id)
        
        if "first_name" in request.data:
            user.first_name=request.data.get("first_name")
        if "last_name" in request.data:
            user.last_name=request.data.get("last_name")
        if "user_image" in request.data:
            user.user_image=request.FILES.get("user_image")
        
        user.save()
        return Response({"status":True,"message":"Updated Successfully"},status=status.HTTP_200_OK)
        
        
    except User.DoesNotExist:
        return Response({"status":False,"message":"User Does not"})    
            
    except Exception as e:
        return Response({"status":True,"messaage":"Something went wrong"},status=status.HTTP_400_BAD_REQUEST)
    
@api_view(["POST"])
def delete_user(request):
    user_id=request.data.get("user_id")
    if not user_id:
        return Response({"status":False, "message":"Plz provide required ID"},status=status.HTTP_400_BAD_REQUEST)
    
    try:
        
        user=User.objects.get(id=user_id)
        user.delete()
        return Response({"status":True,"message":"Deleted Successfully"},status=status.HTTP_200_OK)
    
    
    
    except User.DoesNotExist:
        return Response({"status":False,"message":"User Does not exist"},status=status.HTTP_400_BAD_REQUEST)
    except Exception as e:
        return Response({"status":False,"message":"Something went wrong","error":str(e)})
    

           
    
      
    
    
    
        
    
    