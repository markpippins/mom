import logging
import os

import util
import var

FORMAT = '%(asctime)s %(levelname)s %(filename)s %(funcName)s : %(message)s ' #, datefmt='%m/%d/%Y %I:%M:%S %p')

LOGS = {}

class Safety(object):
    def __init__(self, name, logging_level):
        self.name = name
        self.log = get_log(name, logging_level)

    def debug(self, *args):
        try:
            self.log.debug(*args)
        except Exception, err:
            print(err.message)

    def error(self, *args):
        try:
            self.log.error(*args, exc_info=True)
        except Exception, err:
            print(err.message)

    def info(self, *args):
        try:
            self.log.info(*args)     
        except Exception, err:
            print(err.message)

    def warning(self, *args):
        try:
            self.log.warning(*args)
        except Exception, err:
            print(err.message)

def get_safe_log(log_name, logging_level): 
    if log_name in LOGS:
        return LOGS[log_name]

    LOGS[log_name] = Safety(log_name, logging_level)
    return LOGS[log_name]

def get_log(log_name, logging_level):
    if var.logging_started is False:
        start_logging()

    return setup_log(log_name, log_name, logging_level)

def setup_log(file_name, log_name, logging_level):
    log = "%s%slog%s%s.log" % (util.get_working_directory(), os.path.sep, os.path.sep, file_name)
    tracer = logging.getLogger(log_name)
    tracer.setLevel(logging_level)
    tracer.addHandler(logging.FileHandler(log))

    # logging.basicConfig(filename=log, filemode="w", level=logging_level, format=FORMAT, datefmt='%m/%d/%Y %I:%M:%S %p')

    return tracer

def start_logging():
    if var.logging_started:
        return

    var.logging_started = True

    # console handler
    clog = 'console'
    CONSOLE = "%s%slog%s%s.log" % (util.get_working_directory(), os.path.sep, os.path.sep, clog)

    logging.basicConfig(filename=CONSOLE, filemode="w", level=logging.INFO, format=FORMAT, datefmt='%m/%d/%Y %I:%M:%S %p')

    console = logging.StreamHandler()
    console.setLevel(logging.INFO)

    log = logging.getLogger(clog)
    log.addHandler(console)
    # log.debug("console logging started.")
    
    setup_log('elasticsearch', 'elasticsearch.trace', logging.DEBUG)
    setup_log('sqlalchemy.engine', 'sqlalchemy.trace', logging.DEBUG)
## 'sqlalchemy.engine'