from django.contrib.auth.models import AbstractUser
from django.db import models

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

# Water Level Detection Model
class WaterScan(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    timestamp = models.DateTimeField(auto_now_add=True)
    location = models.CharField(max_length=255)
    depth_scanned = models.FloatField()
    water_level = models.FloatField()
    remarks = models.TextField(blank=True, null=True)

    def __str__(self):
        return f"Scan at {self.location} - {self.water_level}m"
