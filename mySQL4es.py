#!/usr/bin/env python

import os
import sys
import time
import MySQLdb as mdb
from elasticsearch import Elasticsearch
from elasticsearch.exceptions import NotFoundError

import pprint

pp = pprint.PrettyPrinter(indent=4)

HOST = 'localhost'
USER = 'root'
PASS = 'stainless'
SCHEMA = 'media'
DEBUG = False


def quote_if_string(value):
    if isinstance(value, basestring):
        return '"%s"' % value
    return value

def insert_values(table_name, field_names, field_values):

    con = None
    try:
        formatted_values = [quote_if_string(value) for value in field_values]

        query = 'INSERT INTO %s(%s) VALUES(%s)' % (table_name, ','.join(field_names), ','.join(formatted_values))

        if DEBUG:
            print '\n\t' + query.replace(',', ',\n\t\t').replace(' values ', '\n\t   values\n\t\t').replace('(', ' (\n\t\t').replace(')', '\n\t\t)') + '\n'

        con = mdb.connect(HOST, USER, PASS, SCHEMA)
        cur = con.cursor()
        cur.execute(query)
        con.commit()

    except mdb.Error, e:

        message = "Error %d: %s" % (e.args[0], e.args[1])
        # raise Exception(message)
        print message
    finally:
        if con:
            con.close()

# TODO: add handling for boolean values
def retrieve_values(table_name, field_names, field_values):

    con = None

    try:

        query = 'SELECT '
        pos = 0
        for name in field_names:
            query += name
            pos += 1
            if pos < len(field_names):
                query += ', '


        query += ' FROM ' + table_name

        if len(field_values) > 0:
            query += ' WHERE '

            pos = 0
            for name in field_names:
                query += name + ' = ' + '"' + field_values[pos] + '"'
                pos += 1
                if pos < len(field_values):
                    query += ' AND '
                else: break

        if DEBUG:
            print '\n\t' + query.replace('WHERE', '\n\t      WHERE').replace('AND', '\n\t\tAND').replace('FROM', '\n\t       FROM')

        con = mdb.connect(HOST, USER, PASS, SCHEMA)
        cur = con.cursor()
        cur.execute(query)
        rows = cur.fetchall()

        if DEBUG:
            if len(rows) > 0: print('\nreturning rows:\n')
            for row in rows:
                print row

        return rows
    except mdb.Error, e:

        print "Error %d: %s" % (e.args[0], e.args[1])
        sys.exit(1)

    finally:
        if con:
            con.close()

def retrieve_like_values(table_name, field_names, field_values):
    try:

        query = 'SELECT '
        pos = 0
        for name in field_names:
            query += name
            pos += 1
            if pos < len(field_names):
                query += ', '


        query += ' FROM ' + table_name + ' WHERE '

        pos = 0
        for name in field_names:
            query += name + ' LIKE ' + '"%' + field_values[pos] + '%"'
            pos += 1
            if pos < len(field_values):
                query += ' AND '
            else: break

        if DEBUG:
            print '\n\t' + query.replace('WHERE', '\n\t      WHERE').replace('AND', '\n\t\tAND').replace('FROM', '\n\t       FROM')

        con = mdb.connect(HOST, USER, PASS, SCHEMA)
        cur = con.cursor()
        cur.execute(query)
        rows = cur.fetchall()

        if DEBUG:
            if len(rows) > 0: print('\nreturning rows:\n')
            for row in rows:
                print row

        return rows
    except mdb.Error, e:

        print "Error %d: %s" % (e.args[0], e.args[1])
        sys.exit(1)

    finally:
        if con:
            con.close()

def update_values(table_name, update_field_names, update_field_values, where_field_names, where_field_values):

    query = 'UPDATE '
    query += table_name
    query += ' SET '

    pos = 0
    for name in update_field_names:
        query += name + ' = ' + '"' + update_field_values[pos] + '"'
        pos += 1
        if pos < len(update_field_values):
            query += ', '
        else: break

    query += ' WHERE '

    pos = 0
    for name in where_field_names:
        query += name + ' = ' + '"' + where_field_values[pos] + '"'
        pos += 1
        if pos < len(where_field_values):
            query += ' AND '
        else: break

    if DEBUG:
        print '\n\t' + query.replace('WHERE', '\n\t WHERE').replace(', ', ',\n\t       ').replace('SET', '\n\t   SET').replace('AND', '\n\t   AND')

    try:
        con = mdb.connect(HOST, USER, PASS, SCHEMA)
        cur = con.cursor()
        cur.execute(query)
        con.commit()

    except mdb.Error, e:

        print "Error %d: %s" % (e.args[0], e.args[1])
        sys.exit(1)

    finally:
        if con:
            con.close()

def truncate(table_name):

    query = 'truncate ' + table_name

    try:
        con = mdb.connect(HOST, USER, PASS, SCHEMA)
        cur = con.cursor()
        cur.execute(query)
        con.commit()

    except mdb.Error, e:

        print "Error %d: %s" % (e.args[0], e.args[1])

    finally:
        if con:
            con.close()

#NOTE: The methods that follow are specific to this es application and should live elsewehere

def ensure_exists_in_mysql(esid, path, indexname, documenttype):
    try:
        if DEBUG: print("checking for row for: "+ path)
        rows = retrieve_values('elasticsearch_doc', ['absolute_path', 'index_name'], [path, indexname])
        if len(rows) ==0:
            if DEBUG: print('Updating local MySQL...')
            insert_esid(indexname, documenttype, esid, path)
    except mdb.Error, e:

        print "Error %d: %s" % (e.args[0], e.args[1])


def insert_esid(index, document_type, elasticsearch_id, absolute_path):
    insert_values('elasticsearch_doc', ['index_name', 'doc_type', 'id', 'absolute_path'],
        [index, document_type, elasticsearch_id, absolute_path])

def retrieve_esid(index, document_type, absolute_path):

    rows = retrieve_values('elasticsearch_doc', ['index_name', 'doc_type', 'absolute_path', 'id'], [index, document_type, absolute_path])

    if rows == None:
        return []

    if len(rows) > 1:
        text = "Multiple Ids for '" + absolute_path + "' returned"
        raise Exception(text)

    if len(rows) == 1:
        return rows[0][3]

def retrieve_esids(index, document_type, file_path):

    rows = None
    try:
        query = 'SELECT absolute_path, id FROM elasticsearch_doc WHERE absolute_path LIKE '
        query += '"' + file_path + '%"'

        con = mdb.connect(HOST, USER, PASS, SCHEMA)
        cur = con.cursor()
        cur.execute(query)
        rows = cur.fetchall()

        return rows

    except mdb.Error, e:

        print "Error %d: %s" % (e.args[0], e.args[1])

    finally:
        if con:
            con.close()

# def main():
#     es = Elasticsearch([{'host': '54.82.250.249', 'port': 9200}])
#     rows = None
#
#     try:
#         query = "SELECT id, absolute_path FROM elasticsearch_doc WHERE index_name = 'media' and doc_type='media_file'"
#
#         con = mdb.connect(HOST, USER, PASS, SCHEMA)
#         cur = con.cursor()
#         cur.execute(query)
#         rows = cur.fetchall()
#
#         for row in rows:
#             print ', '.join([row[0], row[1]])
#             print row[1]
#             if os.path.isfile(row[1]):
#                 try:
#                     doc = es.get(index='media', doc_type='media_file', id=row[0])
#                     if doc is not None:
#                         if not 'mtime' in doc['_source']:
#                             res = es.update(index='media', doc_type='media_file', id=row[0], body={"doc": {"ctime": time.ctime(os.path.getctime(row[1])), "mtime": time.ctime(os.path.getmtime(row[1])) }})
#
#                 except Exception, err:
#                     print ': '.join([err.__class__.__name__, err.message])
#                     query = "DELETE FROM elasticsearch_doc WHERE id = '%s'" % (row[0])
#                     con2 = mdb.connect(HOST, USER, PASS, SCHEMA)
#                     cur2 = con2.cursor()
#                     cur2.execute(query)
#                     con2.commit()
#                     con2.close()
#             else:
#                 query = "DELETE FROM elasticsearch_doc WHERE id = '%s'" % (row[0])
#                 con2 = mdb.connect(HOST, USER, PASS, SCHEMA)
#                 cur2 = con2.cursor()
#                 cur2.execute(query)
#                 con2.commit()
#                 con2.close()
#
#     finally:
#         if con:
#             con.close()
#
# # main
# if __name__ == '__main__':
#     main()
