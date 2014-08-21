# -*- coding: UTF-8 -*-
from kivy.lang import Builder
from kivy.uix.boxlayout import BoxLayout

class GUI():
    _root = None
    
    def __init__(self):
        Builder.load_file('res/layout.kv')
        self._root = Activity_Main()#BoxLayout()
    
    def getRoot(self):
        return self._root

'''
Define all activities class here
'''

class Activity_Main(BoxLayout):
    pass

from kivy.uix.behaviors import ButtonBehavior
from kivy.uix.stencilview import StencilView

class ButtonBoxLayout(ButtonBehavior, BoxLayout):
    pass