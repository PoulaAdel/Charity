"""
Author: Developed by Poula Adel
License: MIT License 
Copyright ©,All rights reserved
"""


from django.shortcuts import render

# Create your views here.
from django.contrib.auth.models import Group
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.authtoken.models import Token
from django.contrib.auth import authenticate
from rest_framework import permissions,viewsets
from rest_framework.generics import RetrieveUpdateDestroyAPIView
from api.serializers import *
from api.models import *


"""
:List View for User
"""
class UserViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows Users to be viewed or edited.
    """
    queryset = User.objects.all()
    serializer_class = UserSerializer
    permission_classes = [permissions.IsAuthenticated]
    
"""
:User Item Control
"""
class UserViewDetail(RetrieveUpdateDestroyAPIView):
    """
    API endpoint that allows Users to be viewed or edited.
    """
    queryset = User.objects.all()
    serializer_class = UserSerializer
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
    from django.contrib.auth.models import Group
from rest_framework import permissions,viewsets
from rest_framework.generics import RetrieveUpdateDestroyAPIView
from api.serializers import *
from api.models import *


"""
:List View for User
"""
class UserViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows Users to be viewed or edited.
    """
    queryset = User.objects.all()
    serializer_class = UserSerializer
    permission_classes = [permissions.IsAuthenticated]
    
"""
:User Item Control
"""
class UserViewDetail(RetrieveUpdateDestroyAPIView):
    """
    API endpoint that allows Users to be viewed or edited.
    """
    queryset = User.objects.all()
    serializer_class = UserSerializer
    lookup_field = 'pk'
    permission_classes = [permissions.IsAuthenticated]
    
"""
:List View for Donor
"""
class DonorViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows Donors to be viewed or edited.
    """
    queryset = Donor.objects.all()
    serializer_class = DonorSerializer
    permission_classes = [permissions.IsAuthenticated]
    
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
    API endpoint that allows Suggestions to be viewed or edited.
    """
    queryset = Suggestion.objects.all()
    serializer_class = SuggestionSerializer
    permission_classes = [permissions.IsAuthenticated]
    
"""
:Suggestion Item Control
"""
class SuggestionViewDetail(RetrieveUpdateDestroyAPIView):
    """
    API endpoint that allows Suggestions to be viewed or edited.
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
    