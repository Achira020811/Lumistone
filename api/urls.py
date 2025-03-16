from django.urls import path
from .views import RegisterView, LoginView, WaterScanListCreateView

urlpatterns = [
    path('register/', RegisterView.as_view(), name='register'),
    path('login/', LoginView.as_view(), name='login'),
    path('scans/', WaterScanListCreateView.as_view(), name='scans'),
]
