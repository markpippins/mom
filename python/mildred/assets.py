#! /usr/bin/python

import os
import time
import json

import const
from core import util

class Asset(object):
    def __init__(self, absolute_path, document_type, esid=None):
        # self.active = True
        self.absolute_path = absolute_path
        self.available = os.access(absolute_path, os.R_OK)
        # self.data = None
        self.deleted = False
        self.doc = None
        self.document_type = document_type
        self.errors = []
        self.esid = esid
        self.has_changed = False
        self.location = None
        # self.has_errors = False
        # self.latest_error = u''
        # self.latest_operation = u''
        # self.latest_operation_start_time = None

        # TODO: use in scanner, reader and to_dictionary()

    def short_name(self):
        if self.absolute_path is None:
            return None
        return self.absolute_path.split(os.path.sep)[-1]

    def to_dictionary(self):

        data = {}
        for name in self.__dict__: 
            data[name] = self.__dict__[name]

        if self.available:
            data['ctime'] = time.ctime(os.path.getctime(self.absolute_path))
            data['mtime'] = time.ctime(os.path.getmtime(self.absolute_path))
            data['file_size'] = os.path.getsize(self.absolute_path)
       
        return data

    def to_str(self):
        return json.dumps(self.to_dictionary())


class Document(Asset):
    def __init__(self, absolute_path, esid=None):
        super(Document, self).__init__(absolute_path, document_type=const.FILE, esid=esid)
        self.available = self.available and os.path.isfile(absolute_path)       
        self.ext = None
        self.file_name = None
        self.file_size = 0
        # self.directory_name = None
        self.attributes = []

    def duplicates(self):
        return []

    def has_duplicates(self):
                # return True
        return False

    def is_duplicate(self):
        return False

    def originals(self):
        return []


class Directory(Asset):
    def __init__(self, absolute_path, esid=None):
        super(Directory, self).__init__(absolute_path, document_type=const.DIRECTORY, esid=esid)
        self.available = self.available and os.path.isdir(absolute_path)

    # TODO: call Asset.to_dictionary and append values
    def to_dictionary(self):

        data = super(Directory, self).to_dictionary()
        if self.available:
            data['ctime'] = time.ctime(os.path.getctime(self.absolute_path))
            try:
                data['contents'] = [util.uu_str(f) for f in os.listdir(self.absolute_path)]
                data['contents'].sort()
            except Exception, err:
                # self.has_errors = True
                self.errors.append(err.message)

        return data

    def all_files_have_matches(self):
        return False

    def has_matches(self):
        return False

    # def is_proper_compilation(self):
    #     return False

    def match_count(self):
        return 0

    # def has_multiple_artists(self):
    #     return False