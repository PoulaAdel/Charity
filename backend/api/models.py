"""
Author: Developed by Poula Adel
License: MIT License
Copyright ©,All rights reserved
"""

from django.db import models
from django.contrib.auth.models import AbstractUser
from django.utils.translation import gettext_lazy as _

"""
User management model
# custom user model
"""


# ==ACCOUNT
class User(AbstractUser):
    NEW_USER = 0
    VOLUNTEER = 1
    SPONSOR = 2

    USER_ROLE_CHOICES = (
        (NEW_USER, _("New User")),
        (VOLUNTEER, _("Volunteer")),
        (SPONSOR, _("Sponsor")),
    )
    role = models.PositiveSmallIntegerField(
        _("Role"), choices=USER_ROLE_CHOICES, default=NEW_USER
    )
    profile_image = models.ImageField(upload_to='profile_images/', blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    @property
    def get_level(self):
        return self.role

    @property
    def is_administrator(self):
        return self.role == self.SPONSOR

    def __str__(self):
        return self.username

class Donor(models.Model):
    name = models.CharField(_("Name"), max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.name

"""
Orgnization Assets 
# assets management model
"""


# ==Services Offered
class Service(models.Model):
    name = models.CharField(_("Name"), max_length=255)
    description = models.TextField(_("Description"))
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.name


# ==Donations
class Donation(models.Model):
    FINANCIAL = 0
    MATERIAL = 1
    DONATION_TYPE_CHOICES = ((FINANCIAL, _("Financial")), (MATERIAL, _("Material")))

    donor = models.ForeignKey(
        Donor, on_delete=models.CASCADE
    )  # Use User model for donor
    type = models.PositiveSmallIntegerField(
        _("Type"), choices=DONATION_TYPE_CHOICES, default=FINANCIAL
    )
    notes = models.TextField(_("Notes"), max_length=200, blank=True, null=True)
    amount = models.DecimalField(_("Amount"), max_digits=10, decimal_places=2)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return str(self.donor.name)


# ==Families
class Family(models.Model):
    name = models.CharField(_("Name"), max_length=255)
    count = models.PositiveIntegerField(_("Count"), default= 1)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.name


# ==Family Members
class Member(models.Model):
    FATHER = 0
    MOTHER = 1
    SON = 2
    DAUGHTER = 3

    FAMILY_MEMBER = (
        (FATHER, _("Father")),
        (MOTHER, _("Mother")),
        (SON, _("Son")),
        (DAUGHTER, _("Daughter")),
    )
    
    family = models.ForeignKey(Family, on_delete=models.CASCADE)
    name = models.CharField(_("Name"), max_length=255)
    relation = models.PositiveSmallIntegerField(
        _("Role"), choices=FAMILY_MEMBER, default=FATHER
    )
    contact = models.CharField(_("Contact"), max_length=12)
    nid = models.FileField(_("National ID"), upload_to="ids/")  # PDF
    face_img = models.ImageField(_("Face Image"), upload_to="faces/")  # Image
    age = models.PositiveIntegerField(_("Age"), default = 0)
    education = models.TextField(_("Education"), blank=True, null=True)
    health = models.TextField(_("Health"), blank=True, null=True)
    income = models.DecimalField(_("Income"), max_digits=10, decimal_places=2, default=0.00)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.name


"""
Family Statement 
# statements done by volunteer 
# for family management models
"""


# Base Statement Class
class Statement(models.Model):
    family = models.ForeignKey(Family, on_delete=models.CASCADE)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"{self.family} - {self.created_at}"


# Statement Leaves
class Social(models.Model):
    statement = models.ForeignKey(Statement, on_delete=models.CASCADE)
    content = models.TextField(_("Content"))
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)


class Spiritual(models.Model):
    statement = models.ForeignKey(Statement, on_delete=models.CASCADE)
    content = models.TextField(_("Content"))
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)


class Residential(models.Model):
    statement = models.ForeignKey(Statement, on_delete=models.CASCADE)
    content = models.TextField(_("Content"))
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)


class Economical(models.Model):
    statement = models.ForeignKey(Statement, on_delete=models.CASCADE)
    content = models.TextField(_("Content"))
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)


# Opinion
class Opinion(models.Model):
    statement = models.ForeignKey(Statement, on_delete=models.CASCADE)
    content = models.TextField(_("Content"))
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"Opinion on {self.statement}"


# Suggestion
class Suggestion(models.Model):
    statement = models.ForeignKey(Statement, on_delete=models.CASCADE)
    content = models.TextField(_("Content"))
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"Suggestion on {self.statement}"


# Judgement
class Judgement(models.Model):
    statement = models.ForeignKey(Statement, on_delete=models.CASCADE)
    content = models.TextField(_("Content"))
    sponsor = models.ForeignKey(User, on_delete=models.DO_NOTHING)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"Judgement on {self.statement}"


"""
Action Plan 
# what will be given to 
# each family management model
"""


# Supplies
class Supply(models.Model):
    family = models.ForeignKey(Family, on_delete=models.CASCADE)
    service = models.ForeignKey(Service, on_delete=models.SET_NULL, null=True)
    amount = models.DecimalField(_("Amount"), max_digits=10, decimal_places=2)
    note = models.TextField(_("Notes"))
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"Supply for {self.family}"


# Check
class Check(models.Model):
    supply = models.ForeignKey(Supply, on_delete=models.DO_NOTHING)
    receiver = models.ForeignKey(Member, on_delete=models.DO_NOTHING)
    sponsor = models.ForeignKey(User, on_delete=models.DO_NOTHING)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.pk
