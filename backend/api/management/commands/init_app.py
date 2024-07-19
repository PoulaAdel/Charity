from django.core.management.base import BaseCommand, CommandError
from .helpers.auto_generator import AutoGenerator
from .helpers.man_pages import ManPages

class Command(BaseCommand):
    mp = ManPages()
    help = mp.get_init_app_helper()

    def add_arguments(self, parser):
        parser.add_argument('appname', type=str)

    def handle(self, *args, **options):
        # should be conditional if only have app name
        appname = options['appname']

        gen = AutoGenerator(appname)
        gen.build_serializers()
        gen.build_views()
        gen.build_register_routes()