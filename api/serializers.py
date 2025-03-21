from rest_framework import serializers
from django.contrib.auth import get_user_model
from .models import WaterScan, GoldScan

User = get_user_model()

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['id', 'username', 'email', 'phone_number']

class RegisterSerializer(serializers.ModelSerializer):
    password = serializers.CharField(write_only=True, min_length=6)

    class Meta:
        model = User
        fields = ['username', 'email', 'phone_number', 'password']

    def create(self, validated_data):
        user = User.objects.create_user(**validated_data)
        return user

class WaterScanSerializer(serializers.ModelSerializer):
    user = UserSerializer(read_only=True)

    class Meta:
        model = WaterScan
        fields = '__all__'  # Changed from fields = ['location', 'x_nad83', 'y_nad83']

# Serializers for ML Prediction Request
class PredictionRequestSerializer(serializers.Serializer):
    location = serializers.CharField(required=True) #User provided location, not coordinate
    x_nad83 = serializers.FloatField(required=True)
    y_nad83 = serializers.FloatField(required=True)


class PredictionResponseSerializer(serializers.Serializer):
    location = serializers.CharField()
    predicted_water = serializers.IntegerField()
    depth = serializers.FloatField(allow_null=True) #Depth in meter
    remarks = serializers.CharField() #Sucessful and unsucessful detection

class GoldScanSerializer(serializers.ModelSerializer):
    user = UserSerializer(read_only=True)

    class Meta:
        model = GoldScan
        fields = '__all__'

# Serializers for Gold ML Prediction Request
class GoldPredictionRequestSerializer(serializers.Serializer):
    location = serializers.CharField(required=True)
    x_nad83 = serializers.FloatField(required=True)
    y_nad83 = serializers.FloatField(required=True)

class GoldPredictionResponseSerializer(serializers.Serializer):
    location = serializers.CharField()
    predicted_gold = serializers.IntegerField()
    confidence = serializers.FloatField(allow_null=True)
    remarks = serializers.CharField()