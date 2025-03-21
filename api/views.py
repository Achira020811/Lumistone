from rest_framework import generics, status
from rest_framework.response import Response
from rest_framework.permissions import AllowAny, IsAuthenticated
from rest_framework_simplejwt.tokens import RefreshToken
from django.contrib.auth import get_user_model
from django.http import HttpResponse
from rest_framework.decorators import api_view
from .models import WaterScan
from .serializers import (
    RegisterSerializer,
    UserSerializer,
    WaterScanSerializer,
    PredictionRequestSerializer,
    PredictionResponseSerializer
)
from .ml_model import get_prediction_from_db  # Database-driven prediction

# Home View
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
        serializer.is_valid(raise_exception=True)

        data = serializer.validated_data
        location = data['location']
        x_nad83 = data['x_nad83']
        y_nad83 = data['y_nad83']

        # Validate input data
        if not all(isinstance(x, (int, float)) for x in [x_nad83, y_nad83]):
            return Response({"error": "Invalid input data. All values must be numeric."},
                            status=status.HTTP_400_BAD_REQUEST)

        # Get prediction from the database
        predicted_water = get_prediction_from_db(x_nad83, y_nad83)

        if predicted_water is not None:
            depth = 35.53 if predicted_water == 1 else None
            remarks = "Successful" if predicted_water == 1 else "Unsuccessful"

            # Save every scan in the WaterScan model
            WaterScan.objects.create(
                user=request.user,
                location=location,
                x_nad83=x_nad83,
                y_nad83=y_nad83,
                predicted_water=predicted_water,
                depth=depth,
                remarks=remarks
            )

            response_data = PredictionResponseSerializer({
                'location': location,
                'predicted_water': predicted_water,
                'depth': depth,
                'remarks': remarks
            }).data

            return Response(response_data)

        return Response({"error": "No prediction found for this location."},
                        status=status.HTTP_404_NOT_FOUND)

    except Exception as e:
        return Response({"error": str(e)},
                        status=status.HTTP_500_INTERNAL_SERVER_ERROR)
