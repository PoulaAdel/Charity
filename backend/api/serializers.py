"""
Author: Developed by Poula Adel
License: MIT License 
Copyright ©,All rights reserved
"""


from django.contrib.auth.models import Group
from rest_framework import serializers
from api.models import *
        
        
class GroupSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Group
        fields = ['url', 'name']

"""
:User Serializer
"""
class UserSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = User
        fields = ['url','id', 'username', 'email', 'phone', 'password', 'role', 'groups', 'profile_image', 'created_at', 'updated_at']
        extra_kwargs = {
            'password': {'write_only': True},
        }

    def update(self, instance, validated_data):
        instance.username = validated_data.get('username', instance.username)
        instance.email = validated_data.get('email', instance.email)
        instance.phone = validated_data.get('phone', instance.phone)
        instance.role = validated_data.get('role', instance.role)
        if 'password' in validated_data:
            instance.set_password(validated_data['password'])
        instance.profile_image = validated_data.get('profile_image', instance.profile_image)
        instance.save()
        return instance
        
"""
:Authenticated User Serializer
"""
class AuthenticatedUserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['id', 'username', 'email', 'role']

"""
:Service Serializer
"""
class ServiceSerializer(serializers.ModelSerializer):
    class Meta:
        model = Service
        fields = '__all__'

"""
:Donation Serializer
"""
class DonationSerializer(serializers.ModelSerializer):
    class Meta:
        model = Donation
        fields = '__all__'

"""
:Family Serializer
"""
class FamilySerializer(serializers.ModelSerializer):
    class Meta:
        model = Family
        fields = '__all__'

"""
:Member Serializer
"""
class MemberSerializer(serializers.ModelSerializer):
    class Meta:
        model = Member
        fields = '__all__'

"""
:Statement Serializer
"""
class StatementSerializer(serializers.ModelSerializer):
    class Meta:
        model = Statement
        fields = '__all__'

"""
:Social Serializer
"""
class SocialSerializer(serializers.ModelSerializer):
    class Meta:
        model = Social
        fields = '__all__'

"""
:Spiritual Serializer
"""
class SpiritualSerializer(serializers.ModelSerializer):
    class Meta:
        model = Spiritual
        fields = '__all__'

"""
:Residential Serializer
"""
class ResidentialSerializer(serializers.ModelSerializer):
    class Meta:
        model = Residential
        fields = '__all__'

"""
:Economical Serializer
"""
class EconomicalSerializer(serializers.ModelSerializer):
    class Meta:
        model = Economical
        fields = '__all__'

"""
:Opinion Serializer
"""
class OpinionSerializer(serializers.ModelSerializer):
    class Meta:
        model = Opinion
        fields = '__all__'

"""
:Suggest Serializer
"""
class SuggestionSerializer(serializers.ModelSerializer):
    class Meta:
        model = Suggestion
        fields = '__all__'

"""
:Judgement Serializer
"""
class JudgementSerializer(serializers.ModelSerializer):
    class Meta:
        model = Judgement
        fields = '__all__'

"""
:Supply Serializer
"""
class SupplySerializer(serializers.ModelSerializer):
    class Meta:
        model = Supply
        fields = '__all__'

"""
:Check Serializer
"""
class CheckSerializer(serializers.ModelSerializer):
    class Meta:
        model = Check
        fields = '__all__'
from django.contrib.auth.models import Group
from rest_framework import serializers
from api.models import *


class UserSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = User
        fields = ['url', 'username', 'email', 'groups']
        
        
class GroupSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Group
        fields = ['url', 'name']

"""
:User Serializer
"""
class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = '__all__'

"""
:Donor Serializer
"""
class DonorSerializer(serializers.ModelSerializer):
    class Meta:
        model = Donor
        fields = '__all__'

"""
:Service Serializer
"""
class ServiceSerializer(serializers.ModelSerializer):
    class Meta:
        model = Service
        fields = '__all__'

"""
:Donation Serializer
"""
class DonationSerializer(serializers.ModelSerializer):
    class Meta:
        model = Donation
        fields = '__all__'

"""
:Family Serializer
"""
class FamilySerializer(serializers.ModelSerializer):
    class Meta:
        model = Family
        fields = '__all__'

"""
:Member Serializer
"""
class MemberSerializer(serializers.ModelSerializer):
    class Meta:
        model = Member
        fields = '__all__'

"""
:Statement Serializer
"""
class StatementSerializer(serializers.ModelSerializer):
    class Meta:
        model = Statement
        fields = '__all__'

"""
:Social Serializer
"""
class SocialSerializer(serializers.ModelSerializer):
    class Meta:
        model = Social
        fields = '__all__'

"""
:Spiritual Serializer
"""
class SpiritualSerializer(serializers.ModelSerializer):
    class Meta:
        model = Spiritual
        fields = '__all__'

"""
:Residential Serializer
"""
class ResidentialSerializer(serializers.ModelSerializer):
    class Meta:
        model = Residential
        fields = '__all__'

"""
:Economical Serializer
"""
class EconomicalSerializer(serializers.ModelSerializer):
    class Meta:
        model = Economical
        fields = '__all__'

"""
:Opinion Serializer
"""
class OpinionSerializer(serializers.ModelSerializer):
    class Meta:
        model = Opinion
        fields = '__all__'

"""
:Suggestion Serializer
"""
class SuggestionSerializer(serializers.ModelSerializer):
    class Meta:
        model = Suggestion
        fields = '__all__'

"""
:Judgement Serializer
"""
class JudgementSerializer(serializers.ModelSerializer):
    class Meta:
        model = Judgement
        fields = '__all__'

"""
:Supply Serializer
"""
class SupplySerializer(serializers.ModelSerializer):
    class Meta:
        model = Supply
        fields = '__all__'

"""
:Check Serializer
"""
class CheckSerializer(serializers.ModelSerializer):
    class Meta:
        model = Check
        fields = '__all__'
