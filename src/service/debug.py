# -*- coding: UTF-8 -*-

'''
Debug
==========

O objetivo desta classe é criar uma interface única para mostrar informacões de debug.
Caso seja necessário restringir o nível de informacões no log, você pode modificar o valor
da variável *loglevel* para qualquer uma das constantes LOG_ALL, LOG_NOTE, LOG_WARN ou 
LOG_ERROR.

Níveis de mensagem
------
* **info** Mensagem com informacões normalmente irrelevantes para a execucão do programa
* **note** Mensagem de debug
* **warn** Mensagem de aviso (eg. funcão está deprecated)
* **error** Mensagem de erro
'''

class Singleton(type):
    _instances = {}

    def __call__(cls, *args, **kwargs):
        if cls not in cls._instances:
            cls._instances[cls] = super(Singleton, cls).__call__(*args, **kwargs)
        return cls._instances[cls]
    
class Debug():    
    #Singleton
    __metaclass__ = Singleton
    
    '''
    Níveis de log
    '''
    LOG_ALL   = 0
    LOG_NOTE  = 1
    LOG_WARN  = 2
    LOG_ERROR = 3
    
    '''
    Cores utilizadas em cada uma das mensagens
    '''
    COLOR_INFO  = '\033[90m'
    COLOR_NOTE  = '\033[92m'
    COLOR_WARN  = '\033[93m'
    COLOR_ERROR = '\033[91m'
    COLOR_ENDL  = '\033[0m'
    
    #Configuration
    loglevel = LOG_ALL
    
    
    '''
    Message types
    '''
    def info(self, message, header):
        if self.loglevel <= self.LOG_ALL: print self.COLOR_INFO + header + ": " + message + self.COLOR_ENDL
    
    def note(self, message, header):
        if self.loglevel <= self.LOG_NOTE: print self.COLOR_NOTE + header + ": " + message + self.COLOR_ENDL
    
    def warn(self, message, header):
        if self.loglevel <= self.LOG_WARN: print self.COLOR_WARN + header + ": " + message + self.COLOR_ENDL
        
    def error(self, message, header):
        if self.loglevel <= self.LOG_ERROR : print self.COLOR_ERROR + header + ": " + message + self.COLOR_ENDL