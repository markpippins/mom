#! /usr/bin/python

'''
   Usage: serve.py [(--config <filename>)] [(--path <path>...) | (--pattern <pattern>...) ] [(--scan | --noscan)][(--match | --nomatch)] [--debug-mysql] [--noflush] [--clearmem] [--checkforbugs] 

   --path, -p                   The path to scan

'''

import os, sys,logging, traceback, thread

from docopt import docopt

import cache, calc, config, start, ops, sql, scan

from scan import Param

class ServerProcess(object):
    def run(self, param):
        if config.scan:
            scan.scan(param)

        if config.match:
            calc.calculate_matches(param)

# NOTE: this should be pluggable
def create_param(paths):
    print 'Setting up param...'
    param = Param()

    param.extensions = ['mp3'] # util.get_active_media_formats() - should be in config
    if paths == None:
        for location in config.locations: 
            if location.endswith("albums") or location.endswith("compilations"):
                for genre in config.genre_folders:
                    param.locations.append(os.path.join(location, genre))
            else:
                param.locations.append(location)            

        for location in config.locations_ext:
            param.locations.append(location)            
        # param.locations.append(config.NOSCAN)
        # param.locations.append(config.EXPUNGED)     
    else: 
        for directory in paths:
            param.locations.append(directory)
    
    param.locations.sort()

    # In mode 2, after running this mode to completion, query all locations that are not in op_records data
    # param.locations.append(location for location in config.locations)            

    return param

def execute(path=None):
    
    print 'Configuring...'
    param = create_param(path)
    server = ServerProcess()
    print 'starting...'
    server.run(param)

def main(args):
    try:
        configfile = None if not args['--config'] else args['<filename>'] 
        if configfile: config.filename = configfile
        start.execute(start.make_options(args))

        path = None if not args['--path'] else args['<path>']
        pattern = None if not args['--pattern'] else args['<pattern>']
    
        if args['--pattern']:
            for p in pattern:
                q = """SELECT absolute_path FROM es_document WHERE absolute_path LIKE "%s%s%s" AND doc_type = "%s" ORDER BY absolute_path""" % \
                    ('%', p, '%', config.MEDIA_FOLDER)
                for row in sql.run_query(q):
                    path.append(row[0])
        
        if config.launched:
            ops.record_exec()
            execute(path)
        else: 
            message = 'unable to initialize with current configuration in %s.' % config.filename
            sys.exit(message)
    except Exception, err:
        print err.message
        sys.exit()
        
# main
if __name__ == '__main__':
    args = docopt(__doc__)
    main(args)
