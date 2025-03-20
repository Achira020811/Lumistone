from rest_framework import generics, status
from rest_framework.response import Response
from rest_framework.permissions import AllowAny, IsAuthenticated
from rest_framework_simplejwt.tokens import RefreshToken
from django.contrib.auth import get_user_model
from .models import WaterScan
from .serializers import RegisterSerializer, UserSerializer, WaterScanSerializer, PredictionRequestSerializer, PredictionResponseSerializer
from django.http import HttpResponse
from rest_framework.decorators import api_view
import random # To generate random predictions
from rest_framework import generics, status
from rest_framework.response import Response
from rest_framework.permissions import AllowAny, IsAuthenticated
from rest_framework_simplejwt.tokens import RefreshToken
from django.contrib.auth import get_user_model
from .models import WaterScan
from .serializers import RegisterSerializer, UserSerializer, WaterScanSerializer, PredictionRequestSerializer, PredictionResponseSerializer
from django.http import HttpResponse
from rest_framework.decorators import api_view
from .ml_model import get_prediction_from_db # Remove the ML
import os  # Import the 'os' module

def home(request):
    return HttpResponse("Welcome to the home page!")

User = get_user_model()

# Register View
class RegisterView(generics.CreateAPIView):
    queryset = User.objects.all()
    serializer_class = RegisterSerializer
    permission_classes = [AllowAny]

# Login View
class LoginView(generics.GenericAPIView):
    permission_classes = [AllowAny]

    def post(self, request):
        from django.contrib.auth import authenticate
        username = request.data.get("username")
        password = request.data.get("password")
        user = authenticate(username=username, password=password)

        if user:
            refresh = RefreshToken.for_user(user)
            return Response({
                "user": UserSerializer(user).data,
                "refresh": str(refresh),
                "access": str(refresh.access_token),
            })
        return Response({"error": "Invalid Credentials"}, status=status.HTTP_401_UNAUTHORIZED)

# Water Scan Views
class WaterScanListCreateView(generics.ListCreateAPIView):
    serializer_class = WaterScanSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        return WaterScan.objects.filter(user=self.request.user)

    def perform_create(self, serializer):
        serializer.save(user=self.request.user)


# ML Prediction View
@api_view(['POST'])
def predict_water_presence(request):
    try:
        serializer = PredictionRequestSerializer(data=request.data)
        if serializer.is_valid(raise_exception=True):  # Raise exception if not valid
            data = serializer.validated_data
            location = data['location']
            x_nad83 = data['x_nad83']
            y_nad83 = data['y_nad83']

            # Validate input data (very important!)
            if not all(isinstance(x, (int, float)) for x in [x_nad83, y_nad83]):
                return Response({"error": "Invalid input data.  All values must be numeric."},
                                status=status.HTTP_400_BAD_REQUEST)

        # Make the prediction by querying the database
        predicted_water = get_prediction_from_db(x_nad83, y_nad83)

        if predicted_water is not None:
            #Determine the depth
            depth = 35.53 if predicted_water == 1 else None
            remarks = "Successful" if predicted_water == 1 else "Unsuccessful"

            #Save every scan in a WaterScan model
            WaterScan.objects.create(user=request.user, location=location, x_nad83=x_nad83, y_nad83=y_nad83, predicted_water=predicted_water, depth = depth, remarks = remarks)

            response_data = PredictionResponseSerializer({
                'location': location,
                'predicted_water': predicted_water,
                'depth': depth if predicted_water==1 else None,
                'remarks': remarks
            }).data

            return Response(response_data)
        else:
            return Response({"error": "No prediction found for this location."},
                            status=status.HTTP_404_NOT_FOUND)

    except Exception as e:
        return Response({"error": str(e)},
                        status=status.HTTP_500_INTERNAL_SERVER_ERROR)
def home(request):
    return HttpResponse("Welcome to the home page!")

User = get_user_model()

# Register View
class RegisterView(generics.CreateAPIView):
    queryset = User.objects.all()
    serializer_class = RegisterSerializer
    permission_classes = [AllowAny]

# Login View
class LoginView(generics.GenericAPIView):
    permission_classes = [AllowAny]

    def post(self, request):
        from django.contrib.auth import authenticate
        username = request.data.get("username")
        password = request.data.get("password")
        user = authenticate(username=username, password=password)

        if user:
            refresh = RefreshToken.for_user(user)
            return Response({
                "user": UserSerializer(user).data,
                "refresh": str(refresh),
                "access": str(refresh.access_token),
            })
        return Response({"error": "Invalid Credentials"}, status=status.HTTP_401_UNAUTHORIZED)

# Water Scan Views
class WaterScanListCreateView(generics.ListCreateAPIView):
    serializer_class = WaterScanSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        return WaterScan.objects.filter(user=self.request.user)

    def perform_create(self, serializer):
        serializer.save(user=self.request.user)

# ML Prediction View
@api_view(['POST'])
def predict_water_presence(request):
    try:
        serializer = PredictionRequestSerializer(data=request.data)
        if serializer.is_valid(raise_exception=True):  # Raise exception if not valid
            data = serializer.validated_data
            location = data['location'] #To ensure you will store every attempt, the location field is still important
            x_nad83 = data['x_nad83']
            y_nad83 = data['y_nad83']

            # Generate random prediction
            predicted_water = random.choice([0, 1])  # Randomly choose 0 or 1
            depth = random.uniform(10, 50) if predicted_water == 1 else None  # Random depth if water is found
            remarks = "Successful" if predicted_water == 1 else "Unsuccessful"


            #Save every scan in a WaterScan model
            WaterScan.objects.create(user=request.user, location=location, x_nad83=x_nad83, y_nad83=y_nad83, predicted_water=predicted_water, depth = depth, remarks = remarks)

            response_data = PredictionResponseSerializer({
                'location': location,
                'predicted_water': predicted_water,
                'depth': depth if predicted_water==1 else None,
                'remarks': remarks
            }).data

            return Response(response_data)

        else:
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    except Exception as e:
        return Response({"error": str(e)},
                        status=status.HTTP_500_INTERNAL_SERVER_ERROR)