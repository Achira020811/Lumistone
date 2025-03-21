from django.urls import path
from .views import RegisterView, LoginView, WaterScanListCreateView, predict_water_presence, GoldScanListCreateView, predict_gold_presence,get_constant_depth  # Import the new view

urlpatterns = [
    path('register/', RegisterView.as_view(), name='register'),
    path('login/', LoginView.as_view(), name='login'),
    path('scans/', WaterScanListCreateView.as_view(), name='scans'),
    path('predict/', predict_water_presence, name='predict_water_presence'),  # Add the new URL pattern
    path('gold_scans/', GoldScanListCreateView.as_view(), name='gold_scans'),
    path('gold_predict/', predict_gold_presence, name='predict_gold_presence'),
    path('constant_depth/', get_constant_depth, name='constant_depth'),
]