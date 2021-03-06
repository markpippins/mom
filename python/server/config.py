#! /usr/bin/python

import os
import datetime
import ConfigParser
import const
from core import var, util

start_time = datetime.datetime.now().isoformat()
pid = str(os.getpid())
initialized = False
launched = False
username = None
old_pid = None
es = None

db_admin = None
db_analysis = None
db_media = None
db_service = None
db_suggestion = None
db_scratch = None

config_file = os.path.join(util.get_working_directory(), "config.ini")
# yaml  = os.path.join(util.get_working_directory(), "media.conf")

def read(parser, section):
    result = {}
    options = parser.options(section)
    for option in options:
        try:
            result[option] = parser.get(section, option)
        except:
            print("exception on %s!" % option)
            result[option] = None
            initialized = False

    return result

es_dir_index = const.DIRECTORY
es_file_index = const.FILE

if (os.path.isfile(config_file)):
    parser = ConfigParser.ConfigParser()
    parser.read(config_file)

    # service process
    var.profile = read(parser, 'Process')['profile']

    # elasticsearch
    es_host = read(parser, "Elasticsearch")['host']
    es_port = int(read(parser, "Elasticsearch")['port'])

    # mysql
    mysql_host = read(parser, "MySQL")['host']
    mysql_db = read(parser, "MySQL")['schema']
    mysql_user = read(parser, "MySQL")['user']
    mysql_pass = read(parser, "MySQL")['pass']
    mysql_port = int(read(parser, "MySQL")['port'])

    db_admin = read(parser, "Databases")['admin']
    db_analysis = read(parser, "Databases")['analysis']
    db_media = read(parser, "Databases")['media']
    db_service = read(parser, "Databases")['service']
    db_suggestion = read(parser, "Databases")['suggestion']
    db_scratch = read(parser, "Databases")['scratch']

    # status
    status_check_freq= int(read(parser, "Status")['check_frequency'])

    # action
    deep = read(parser, "Action")['deep_scan'].lower() == 'true'
    scan = read(parser, "Action")['scan'].lower() == 'true' 
    match = read(parser, "Action")['match'].lower() == 'true' 

    # cache
    path_cache_size = int(read(parser, "Cache")['path_cache_size'])
    op_life = int(read(parser, "Cache")['op_life'])

    # redis
    redis_host = read(parser, "Redis")['host']

    initialized = True
    
else:
    print("CONFIG FILE NOT FOUND IN %s" % util.get_working_directory)
