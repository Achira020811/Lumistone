from django.urls import path
from .views import RegisterView, LoginView, WaterScanListCreateView, predict_water_presence  # Import the new view

urlpatterns = [
    path('register/', RegisterView.as_view(), name='register'),
    path('login/', LoginView.as_view(), name='login'),
    path('scans/', WaterScanListCreateView.as_view(), name='scans'),
    path('predict/', predict_water_presence, name='predict_water_presence'),  # Add the new URL pattern
]