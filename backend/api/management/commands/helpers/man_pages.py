"""
Author: Developed by Poula Adel
License: MIT License 2022
Copyright ©,All rights reserved
"""

from pathlib import Path

class ManPages():
    PATH_MAP = {}
    
    def __init__(self):
        self.set_path_map()
        
    def set_path_map(self):
        self.PATH_MAP = {
            "DUMMY_DATA": Path(__file__).parent/'../manpages/dummydata.txt',
            "INIT_APP" : Path(__file__).parent/'../manpages/init_app.txt',
        }
        
    def get_dummy_data_helper(self):
        '''
        return --help text for command
        Python3 manage.py dummydata
        '''
        #working template
        tmp_path = self.PATH_MAP['DUMMY_DATA']
        #read template
        f = ""
        with open(tmp_path,'r') as stream:
            f = stream.read()
        #return text
        print(f)
        
    def get_init_app_helper(self):
        '''
        return --help text for command
        Python3 manage.py init_app
        '''
        #working template
        tmp_path = self.PATH_MAP['INIT_APP']
        #read template
        f = ""
        with open(tmp_path,'r') as stream:
            f =  stream.read()
        #return text
        print(f)