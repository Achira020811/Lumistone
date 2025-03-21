from django.contrib.auth.models import AbstractUser
from django.db import models
import pandas as pd

# Custom User Model
class User(AbstractUser):
    email = models.EmailField(unique=True)
    phone_number = models.CharField(max_length=15, blank=True, null=True)

    # Adding related_name to avoid clash with the default User model
    groups = models.ManyToManyField(
        'auth.Group',
        related_name='custom_user_set',  # Define a custom related name
        blank=True,
    )
    user_permissions = models.ManyToManyField(
        'auth.Permission',
        related_name='custom_user_permissions',  # Define a custom related name
        blank=True,
    )

    def __str__(self):
        return self.username

# Water Level Detection Model (You might want to store scan history)
class WaterScan(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    timestamp = models.DateTimeField(auto_now_add=True)
    location = models.CharField(max_length=255)  # User-entered location name
    x_nad83 = models.FloatField()              # Coordinate
    y_nad83 = models.FloatField()              # Coordinate
    predicted_water = models.IntegerField()    # 0 or 1
    depth = models.FloatField(blank=True, null=True)  # Depth, if water is found
    #Remarks can be either successful or unsuccessful detections
    remarks = models.TextField(blank=True, null=True)  # Successful of unsuccessful detection



    def __str__(self):
        return f"Scan at {self.location} - Water: {self.predicted_water}"

