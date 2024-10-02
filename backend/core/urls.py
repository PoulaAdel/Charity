"""
Author: Developed by Poula Adel
License: MIT License
Copyright ©,All rights reserved
"""

from django.urls import include, path
from django.contrib import admin
from rest_framework import routers
from api import views

router = routers.DefaultRouter()

router.register(r'users', views.UserViewSet)
router.register(r'services', views.ServiceViewSet)
router.register(r'donations', views.DonationViewSet)
router.register(r'families', views.FamilyViewSet)
router.register(r'persons', views.PersonViewSet)
router.register(r'statements', views.StatementViewSet)
router.register(r'socials', views.SocialViewSet)
router.register(r'spirituals', views.SpiritualViewSet)
router.register(r'residentials', views.ResidentialViewSet)
router.register(r'economicals', views.EconomicalViewSet)
router.register(r'opinions', views.OpinionViewSet)
router.register(r'suggestions', views.SuggestionViewSet)
router.register(r'judgements', views.JudgementViewSet)
router.register(r'supplies', views.SupplyViewSet)
router.register(r'checks', views.CheckViewSet)

# Wire up our API using automatic URL routing.
# Additionally, we include login URLs for the browsable API.
urlpatterns = [
    path('', include(router.urls)),
    path('admin/', admin.site.urls),
    path('api-auth/', include('rest_framework.urls', namespace='rest_framework'))
]