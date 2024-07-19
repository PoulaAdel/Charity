# setup_test_data.py
from django.core.management.base import BaseCommand, CommandError
from .helpers.auto_generator import AutoGenerator
from .helpers.man_pages import ManPages
from api.models import *
from model_bakery import baker

class Command(BaseCommand):
    mp = ManPages()
    help = mp.get_dummy_data_helper()

    def add_arguments(self, parser):
        parser.add_argument('appname', type=str)

    def handle(self, *args, **options):
        '''Generate dummy data for app using baker'''
        # I.E.
        # products = baker.make(Product,_quantity=100,_bulk_create=True)
        # assert len(products)==10
        
        # should be conditional if only have app name
        appname = options['appname']

        gen = AutoGenerator(appname)
        my_models = gen.get_app_models()
        for m in my_models:
            # should ask for required quantity
            m_items = baker.make(appname+"."+m,_quantity=10,_bulk_create=True)
            # For testing purpose
            assert len(m_items)==10
        