"""
Author: Developed by Poula Adel
License: MIT License 
Copyright ©,All rights reserved
"""


from django.shortcuts import render

from requests import Response
from rest_framework.permissions import IsAuthenticated
from rest_framework import permissions,viewsets,filters
from rest_framework.generics import RetrieveUpdateDestroyAPIView,RetrieveAPIView
from api.serializers import *
from api.models import *
from django_filters.rest_framework import DjangoFilterBackend


"""
:List View for User
"""
class UserViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows Users to be viewed or edited.
    """
    queryset = User.objects.all()
    serializer_class = UserProfileSerializer
    permission_classes = [IsAuthenticated]  # Add authentication if needed
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['username', 'email', 'first_name', 'last_name', 'role', 'created_at', 'updated_at']  # Updated fields
        
"""
:User Item Control
"""
class UserViewDetail(RetrieveUpdateDestroyAPIView):
    """
    API endpoint that allows Users to be viewed or edited.
    """
    queryset = User.objects.all()
    serializer_class = UserProfileSerializer
    lookup_field = 'pk'
    permission_classes = [permissions.IsAuthenticated]
    
    def partial_update(self, request, *args, **kwargs):
        instance = self.get_object()
        serializer = self.get_serializer(instance, data=request.data, partial=True)
        serializer.is_valid(raise_exception=True)
        self.perform_update(serializer)
        return Response(serializer.data)

    def perform_update(self, serializer):
        serializer.save()
    
"""
:User authenticated details
"""
class AuthenticatedUserInfoView(RetrieveAPIView):
    permission_classes = [IsAuthenticated]
    serializer_class = UserProfileSerializer

    def get_object(self): 
        return self.request.user
    
    def post(self, request, *args, **kwargs):
        return self.retrieve(request, *args, **kwargs)
    
"""
:List View for Donation
"""
class DonorViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows Donors to be viewed or edited.
    """
    queryset = Donor.objects.all()
    serializer_class = DonorSerializer
    permission_classes = [permissions.IsAuthenticated]
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['name', 'created_at', 'updated_at']  # Updated fields
    
"""
:Donor Item Control
"""
class DonorViewDetail(RetrieveUpdateDestroyAPIView):
    """
    API endpoint that allows Donors to be viewed or edited.
    """
    queryset = Donor.objects.all()
    serializer_class = DonorSerializer
    lookup_field = 'pk'
    permission_classes = [permissions.IsAuthenticated]
    
"""
:List View for Service
"""
class ServiceViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows Services to be viewed or edited.
    """
    queryset = Service.objects.all()
    serializer_class = ServiceSerializer
    permission_classes = [permissions.IsAuthenticated]
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['name', 'description', 'created_at', 'updated_at']  # Updated fields
    
"""
:Service Item Control
"""
class ServiceViewDetail(RetrieveUpdateDestroyAPIView):
    """
    API endpoint that allows Services to be viewed or edited.
    """
    queryset = Service.objects.all()
    serializer_class = ServiceSerializer
    lookup_field = 'pk'
    permission_classes = [permissions.IsAuthenticated]
    
"""
:List View for Donation
"""
class DonationViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows Donations to be viewed or edited.
    """
    queryset = Donation.objects.all()
    serializer_class = DonationSerializer
    permission_classes = [permissions.IsAuthenticated]
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['donor', 'type', 'amount', 'notes', 'created_at', 'updated_at']  # Updated fields
    
"""
:Donation Item Control
"""
class DonationViewDetail(RetrieveUpdateDestroyAPIView):
    """
    API endpoint that allows Donations to be viewed or edited.
    """
    queryset = Donation.objects.all()
    serializer_class = DonationSerializer
    lookup_field = 'pk'
    permission_classes = [permissions.IsAuthenticated]
    
"""
:List View for Family
"""
class FamilyViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows Familys to be viewed or edited.
    """
    queryset = Family.objects.all()
    serializer_class = FamilySerializer
    permission_classes = [permissions.IsAuthenticated]
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['name', 'count', 'created_at', 'updated_at']  # Updated fields
    
"""
:Family Item Control
"""
class FamilyViewDetail(RetrieveUpdateDestroyAPIView):
    """
    API endpoint that allows Familys to be viewed or edited.
    """
    queryset = Family.objects.all()
    serializer_class = FamilySerializer
    lookup_field = 'pk'
    permission_classes = [permissions.IsAuthenticated]
    
"""
:List View for Member
"""
class MemberViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows Members to be viewed or edited.
    """
    queryset = Member.objects.all()
    serializer_class = MemberSerializer
    permission_classes = [permissions.IsAuthenticated]
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['family', 'name', 'relation', 'contact', 'age', 'education', 'health', 'income', 'created_at', 'updated_at']  # Updated fields
    
"""
:Member Item Control
"""
class MemberViewDetail(RetrieveUpdateDestroyAPIView):
    """
    API endpoint that allows Members to be viewed or edited.
    """
    queryset = Member.objects.all()
    serializer_class = MemberSerializer
    lookup_field = 'pk'
    permission_classes = [permissions.IsAuthenticated]
    
"""
:List View for Statement
"""
class StatementViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows Statements to be viewed or edited.
    """
    queryset = Statement.objects.all()
    serializer_class = StatementSerializer
    permission_classes = [permissions.IsAuthenticated]
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['family', 'created_at', 'updated_at']  # Updated fields
    
"""
:Statement Item Control
"""
class StatementViewDetail(RetrieveUpdateDestroyAPIView):
    """
    API endpoint that allows Statements to be viewed or edited.
    """
    queryset = Statement.objects.all()
    serializer_class = StatementSerializer
    lookup_field = 'pk'
    permission_classes = [permissions.IsAuthenticated]
    
"""
:List View for Social
"""
class SocialViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows Socials to be viewed or edited.
    """
    queryset = Social.objects.all()
    serializer_class = SocialSerializer
    permission_classes = [permissions.IsAuthenticated]
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['statement', 'content', 'created_at', 'updated_at']  # Updated fields
        
"""
:Social Item Control
"""
class SocialViewDetail(RetrieveUpdateDestroyAPIView):
    """
    API endpoint that allows Socials to be viewed or edited.
    """
    queryset = Social.objects.all()
    serializer_class = SocialSerializer
    lookup_field = 'pk'
    permission_classes = [permissions.IsAuthenticated]
    
"""
:List View for Spiritual
"""
class SpiritualViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows Spirituals to be viewed or edited.
    """
    queryset = Spiritual.objects.all()
    serializer_class = SpiritualSerializer
    permission_classes = [permissions.IsAuthenticated]
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['statement', 'content', 'created_at', 'updated_at']  # Updated fields
    
"""
:Spiritual Item Control
"""
class SpiritualViewDetail(RetrieveUpdateDestroyAPIView):
    """
    API endpoint that allows Spirituals to be viewed or edited.
    """
    queryset = Spiritual.objects.all()
    serializer_class = SpiritualSerializer
    lookup_field = 'pk'
    permission_classes = [permissions.IsAuthenticated]
    
"""
:List View for Residential
"""
class ResidentialViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows Residentials to be viewed or edited.
    """
    queryset = Residential.objects.all()
    serializer_class = ResidentialSerializer
    permission_classes = [permissions.IsAuthenticated]
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['statement', 'content', 'created_at', 'updated_at']    
    
"""
:Residential Item Control
"""
class ResidentialViewDetail(RetrieveUpdateDestroyAPIView):
    """
    API endpoint that allows Residentials to be viewed or edited.
    """
    queryset = Residential.objects.all()
    serializer_class = ResidentialSerializer
    lookup_field = 'pk'
    permission_classes = [permissions.IsAuthenticated]
    
"""
:List View for Economical
"""
class EconomicalViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows Economicals to be viewed or edited.
    """
    queryset = Economical.objects.all()
    serializer_class = EconomicalSerializer
    permission_classes = [permissions.IsAuthenticated]
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['statement', 'content', 'created_at', 'updated_at']
    
"""
:Economical Item Control
"""
class EconomicalViewDetail(RetrieveUpdateDestroyAPIView):
    """
    API endpoint that allows Economicals to be viewed or edited.
    """
    queryset = Economical.objects.all()
    serializer_class = EconomicalSerializer
    lookup_field = 'pk'
    permission_classes = [permissions.IsAuthenticated]
    
"""
:List View for Opinion
"""
class OpinionViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows Opinions to be viewed or edited.
    """
    queryset = Opinion.objects.all()
    serializer_class = OpinionSerializer
    permission_classes = [permissions.IsAuthenticated]
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['statement', 'content', 'created_at', 'updated_at']  # Updated fields
    
"""
:Opinion Item Control
"""
class OpinionViewDetail(RetrieveUpdateDestroyAPIView):
    """
    API endpoint that allows Opinions to be viewed or edited.
    """
    queryset = Opinion.objects.all()
    serializer_class = OpinionSerializer
    lookup_field = 'pk'
    permission_classes = [permissions.IsAuthenticated]
    
"""
:List View for Suggestion
"""
class SuggestionViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows Suggests to be viewed or edited.
    """
    queryset = Suggestion.objects.all()
    serializer_class = SuggestionSerializer
    permission_classes = [permissions.IsAuthenticated]
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['statement', 'content', 'created_at', 'updated_at']  # Updated fields
    
"""
:Suggestion Item Control
"""
class SuggestionViewDetail(RetrieveUpdateDestroyAPIView):
    """
    API endpoint that allows Suggests to be viewed or edited.
    """
    queryset = Suggestion.objects.all()
    serializer_class = SuggestionSerializer
    lookup_field = 'pk'
    permission_classes = [permissions.IsAuthenticated]
    
"""
:List View for Judgement
"""
class JudgementViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows Judgements to be viewed or edited.
    """
    queryset = Judgement.objects.all()
    serializer_class = JudgementSerializer
    permission_classes = [permissions.IsAuthenticated]
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['statement', 'content', 'sponsor', 'created_at', 'updated_at']  # Updated fields
    
"""
:Judgement Item Control
"""
class JudgementViewDetail(RetrieveUpdateDestroyAPIView):
    """
    API endpoint that allows Judgements to be viewed or edited.
    """
    queryset = Judgement.objects.all()
    serializer_class = JudgementSerializer
    lookup_field = 'pk'
    permission_classes = [permissions.IsAuthenticated]
    
"""
:List View for Supply
"""
class SupplyViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows Supplys to be viewed or edited.
    """
    queryset = Supply.objects.all()
    serializer_class = SupplySerializer
    permission_classes = [permissions.IsAuthenticated]
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['family', 'service', 'amount', 'note', 'created_at', 'updated_at']  # Updated fields
    
"""
:Supply Item Control
"""
class SupplyViewDetail(RetrieveUpdateDestroyAPIView):
    """
    API endpoint that allows Supplys to be viewed or edited.
    """
    queryset = Supply.objects.all()
    serializer_class = SupplySerializer
    lookup_field = 'pk'
    permission_classes = [permissions.IsAuthenticated]
    
"""
:List View for Check
"""
class CheckViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows Checks to be viewed or edited.
    """
    queryset = Check.objects.all()
    serializer_class = CheckSerializer
    permission_classes = [permissions.IsAuthenticated]
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['supply', 'receiver', 'sponsor', 'created_at', 'updated_at']  # Updated fields
    
"""
:Check Item Control
"""
class CheckViewDetail(RetrieveUpdateDestroyAPIView):
    """
    API endpoint that allows Checks to be viewed or edited.
    """
    queryset = Check.objects.all()
    serializer_class = CheckSerializer
    lookup_field = 'pk'
    permission_classes = [permissions.IsAuthenticated]
