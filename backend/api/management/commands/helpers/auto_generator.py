"""
Author: Developed by Poula Adel
License: MIT License 2022
Copyright ©,All rights reserved
"""

from pathlib import Path
import csv

        
class AutoGenerator():
    APP_NAME = ""
    APP_MODELS = []
    PATH_MAP = {}
    
    def __init__(self,appname):
        self.APP_NAME = appname
        self.set_path_map()
        self.set_app_models()
        
    def set_path_map(self):
        self.PATH_MAP = {
            "DATA": Path.joinpath(Path.cwd(),self.APP_NAME,'management','commands','data','models.csv'),
            "TEMP" : Path.joinpath(Path.cwd(),self.APP_NAME,'management','commands','temp','temp.txt'),
            "SNIPPETS" : {
                "SIGNATURE": Path.joinpath(Path.cwd(),self.APP_NAME,'management','commands','snippets','signature.txt'),
                "VIEW_IMPORT": Path.joinpath(Path.cwd(),self.APP_NAME,'management','commands','snippets','views_import.txt'),
                "SERIALIZERS_IMPORT": Path.joinpath(Path.cwd(),self.APP_NAME,'management','commands','snippets','serializers_import.txt'),
                "INIT_SERIALIZERS": Path.joinpath(Path.cwd(),self.APP_NAME,'management','commands','snippets','initial_user_group_serializers.txt'),
                },
            "TEMPLATES" : {
                "SERIALIZERS":Path.joinpath(Path.cwd(),self.APP_NAME,'management','commands','templates','model_serializer_list.txt'),
                "VIEWS":Path.joinpath(Path.cwd(),self.APP_NAME,'management','commands','templates','model_view_list.txt'),
                } ,
            "WORKING_DIRECTORIES":{
                "SERIALIZERS":Path.joinpath(Path.cwd(),self.APP_NAME,'serializers.py'),
                "VIEWS":Path.joinpath(Path.cwd(),self.APP_NAME,'views.py'),
            },
        }
        
    def set_app_models(self):
        '''Read models => to list'''
        with open(self.PATH_MAP['DATA'],'r') as stream:
            csv_reader = stream.read().splitlines()
            for row in csv_reader:
                self.APP_MODELS.append(str(row).capitalize())
                
    def get_app_models(self):
        return self.APP_MODELS


    def ViewsImportBuilder(self):
        #working template
        tmp_path = self.PATH_MAP['SNIPPETS']['VIEW_IMPORT']
        #read template and modify
        f = ""
        with open(tmp_path,'r') as stream:
            f = stream.read()
        #return single serializer function code
        return str(f).replace('<AppName>',self.APP_NAME)
        
    def SingleViewBuilder(self,modelname):
        #working template
        tmp_path = self.PATH_MAP['TEMPLATES']['VIEWS']
        #read template and modify
        f = ""
        with open(tmp_path,'r') as stream:
            f = stream.read()
        #return single serializer function code
        return str(f).replace('<CLASSNAME>',modelname)

    def SerializersImportBuilder(self):
        #working template
        tmp_path = self.PATH_MAP['SNIPPETS']['SERIALIZERS_IMPORT']
        #read template and modify
        f = ""
        with open(tmp_path,'r') as stream:
            f = stream.read()
        #return single serializer function code
        return str(f).replace('<AppName>',self.APP_NAME)

    def SerializersInitBuilder(self):
        #working template
        tmp_path = self.PATH_MAP['SNIPPETS']['INIT_SERIALIZERS']
        #read template
        f = ""
        with open(tmp_path,'r') as stream:
            f = stream.read()
        #return single serializer function code
        return f

    def SingleSerializerBuilder(self,modelname):
        #working template
        tmp_path = self.PATH_MAP['TEMPLATES']['SERIALIZERS']
        #read template and modify
        f = ""
        with open(tmp_path,'r') as stream:
            f = stream.read()
        #return single serializer function code
        return str(f).replace('<CLASSNAME>',modelname)
                
    def build_serializers(self):
        '''Bring pieces together for serializers
        #imports
        #init serializers
        #model serializers
        '''
        imports = self.SerializersImportBuilder()
        init_serializers = self.SerializersInitBuilder()
        
        # Write Serializers 
        serializers_file_path = self.PATH_MAP['WORKING_DIRECTORIES']['SERIALIZERS']
        # a+ file exists or create
        with open(serializers_file_path,'a+') as stream:
            stream.write(imports)
            stream.write(init_serializers)
            for c in self.APP_MODELS:
                stream.write(self.SingleSerializerBuilder(c))
        
        
    def build_views(self):
        '''Bring pieces together for views
        #imports
        #model views
        '''
        imports = self.ViewsImportBuilder()
        
        # Write Views 
        views_file_path = self.PATH_MAP['WORKING_DIRECTORIES']['VIEWS']
        # a+ file exists or create
        with open(views_file_path,'a+') as stream:
            stream.write(imports)
            for c in self.APP_MODELS:
                stream.write(self.SingleViewBuilder(c))
                
    def build_register_routes(self):
        # Write Views 
        routes_temp_file_path = self.PATH_MAP['TEMP']
        # a+ file exists or create
        with open(routes_temp_file_path,'a+') as stream:
            for c in self.APP_MODELS:
                stream.write(
                    "router.register(r'{0}s', views.{1}ViewSet)\n".format(str(c).lower(),str(c).capitalize())
                )