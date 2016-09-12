#! /usr/bin/python

'''
   Usage: scan.py [(--path <path>...) | (--pattern <pattern>...) ] [(--scan | --noscan)][(--match | --nomatch)] [--debug-mysql] [--noflush] [--clearmem] [--checkforbugs]

   --path, -p                   The path to scan

'''

import os, json, pprint, sys

import cache, config, start, ops, calc, mySQL, util, esutil

from asset import AssetException, Asset, MediaFile, MediaFile
from folders import MediaFolderManager
from read import Param, Reader
from walk import MediaLibraryWalker

pp = pprint.PrettyPrinter(indent=4)

class Scanner(MediaLibraryWalker):
    def __init__(self):
        super(Scanner, self).__init__()

        self.active_param = None
        self.document_type = config.MEDIA_FILE
        
        self.do_cache_locations = True
        self.do_deep_scan = config.deep
        
        self.location_cache = {}

        self.foldermanager = MediaFolderManager()
        self.reader = Reader()
        
################################# MediaWalker Overrides #################################

    def after_handle_root(self, root):
        if config.scan:
            folder = self.foldermanager.folder
            if folder is not None and folder.absolute_path == root:
                if folder is not None and not ops.operation_completed(folder, 'mp3 reader', 'scan'):
                    ops.record_op_complete(folder, 'mp3 reader', 'scan')

    def before_handle_root(self, root):
        if config.scan:
            ops.do_status_check()

            # if config.mfm_debug: print 'examining: %s' % (root)
            
            self.foldermanager.folder = None
            traceback.print_exc(file=sys.stdout)
            
            if ops.operation_in_cache(root, 'scan', 'mp3 reader'):
            # and not self.do_deep_scan: # and not root in config.locations_ext:
                if config.mfm_debug: print 'scan operation record found for: %s' % (root)
                return

            try:
                if util.path_contains_media(root, self.active_param.extensions):
                    self.foldermanager.set_active( root)

            except AssetException, err:
                self.foldermanager.folder = None
                print ': '.join([err.__class__.__name__, err.message])
                if config.mfm_debug: traceback.print_exc(file=sys.stdout)
                ops.handle_asset_exception(err, root)

            except Exception, err:
                print ': '.join([err.__class__.__name__, err.message])
                if config.mfm_debug: traceback.print_exc(file=sys.stdout)

    def handle_root(self, root):
        if config.scan:
            folder = self.foldermanager.folder
            if folder is not None and ops.operation_completed(folder, 'mp3 reader', 'scan'):
                print '%s has been scanned.' % (root)
            elif folder is not None:
                if config.mfm_debug: print 'scanning folder: %s' % (root)
                ops.record_op_begin(folder, 'mp3 reader', 'scan')
                for filename in os.listdir(root):
                    self.process_file(os.path.join(root, filename), foldermanager, self.reader)
        # else: self.foldermanager.set_active(root)

    def handle_root_error(self, err):
        print ': '.join([err.__class__.__name__, err.message])

    def process_file(self, filename, foldermanager, reader):
        for extension in self.active_param.extensions:
                if reader.approves(filename):
                        media = self.get_media_object(filename)
                        # TODO: remove es and MySQL records for nonexistent files
                        if media is None or media.ignore(): continue
                        # scan tag info if this file hasn't been assigned an esid
                        if media.esid is None: 
                            reader.scan_file(media, foldermanager)

    # TODO: move this to asset
    def get_media_object(self, absolute_path):

        if config.mfm_debug: print "creating instance for %s." % (absolute_path)
        if not os.path.isfile(absolute_path) and os.access(absolute_path, os.R_OK):
            if config.mfm_debug: print "Either file is missing or is not readable"
            return null

        media = MediaFile()
        path, filename = os.path.split(absolute_path)
        extension = os.path.splitext(absolute_path)[1]
        filename = filename.replace(extension, '')
        extension = extension.replace('.', '')
        location = self.get_location(absolute_path)

        foldername = parent = os.path.abspath(os.path.join(absolute_path, os.pardir))

        media.absolute_path = absolute_path
        media.file_name = filename
        media.location = location
        media.ext = extension
        media.folder_name = foldername
        media.file_size = os.path.getsize(absolute_path)

        media.esid = self.get_cached_esid(absolute_path)

        return media

    def get_cached_esid(self, path):
        result = config.redis.hgetall(path)
        if result is not None:
            return result['esid']

    def get_location(self, path):
        parent = os.path.abspath(os.path.join(path, os.pardir))
        if parent in self.location_cache:
            # if config.mfm_debug: print "location for path %s found." % (path)
            return self.location_cache[parent]

        self.location_cache = {}

        if config.mfm_debug: print "determining location for %s." % (parent.split('/')[-1])
    
        for location in config.locations:
            if location in path:
                self.location_cache[parent] = os.path.join(config.START_FOLDER, folder)
                return self.location_cache[parent]

        for location in config.locations_ext:
            if location in path:
                self.location_cache[parent] = os.path.join(folder)
                return self.location_cache[parent]

        return None

    # run method in serve.py will call walk() on this class
    # def run(self, param):
    #     if config.scan:
    #         for location in param.locations:
    #             if os.path.isdir(location) and os.access(location, os.R_OK):
    #                 cache.cache_docs(config.MEDIA_FILE, path)
    #                 ops.c
    #                 self.cache_ops(location, 'scan', 'mp3 reader')

    #                 self.walk(location)

    #                 self.location_cache = {}
    #             elif config.mfm_debug:  print "%s isn't currently available." % (location)

    #         print '\n-----scan complete-----\n'

    #     if config.match:
    #         calc.calculate_matches(param)


def main(args):


# main
if __name__ == '__main__':
    args = docopt(__doc__)
    main(args)
