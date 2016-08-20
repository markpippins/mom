#! /usr/bin/python

import os
import sys
import pprint
from elasticsearch import Elasticsearch
import mySQL4es
import constants

pp = pprint.PrettyPrinter(indent=4)

def clear_indexes(es, indexname):

    choice = raw_input("Delete '%s' index? " % (indexname))
    if choice.lower() == 'yes':
        if es.indices.exists(indexname):
            print("deleting '%s' index..." % (indexname))
            res = es.indices.delete(index = indexname)
            print(" response: '%s'" % (res))


        # since we are running locally, use one shard and no replicas
        request_body = {
            "settings" : {
                "number_of_shards": 1,
                "number_of_replicas": 0
            }
        }

        print("creating '%s' index..." % (indexname))
        res = es.indices.create(index = indexname, body = request_body)
        print(" response: '%s'" % (res))

def connect(hostname, portnum):
    # if self.debug:
    print('Connecting to %s:%d...' % (hostname, portnum))
    es = Elasticsearch([{'host': hostname, 'port': portnum}])

    if es == None: raise Exception("Unable to establish connnection to Elasticsearch")
    print('Connected to %s on port %i.') % (hostname, portnum)
    return es

def delete_docs_for_path(es, indexname, doctype, path):

    rows = mySQL4es.retrieve_like_values('es_document', ['index_name', 'doc_type', 'absolute_path', 'active_flag', 'id'], [indexname, doctype, path, str(1)])
    for r in rows:
        esid = r[4]
        res = es.delete(index=indexname,doc_type=doctype,id=esid)
        if res['_shards']['successful'] == 1:
            mySQL4es.update_values('es_document', 'active_flag', False, ['id'], [esid])

def find_docs_missing_field(es, index_name, document_type, field):
    query = { "query" : { "bool" : { "must_not" : { "exists" : { "field" : field }}}}}
    res = es.search(index=index_name, doc_type=document_type, body=query,size=1000)
    return res

# def transform_docs():
#     es = connect(constants.ES_HOST, constants.ES_PORT)
#
#     cycle = True
#     while cycle == True:
#         res = find_docs_missing_field(es, 'media2', 'media_folder', 'absolute_path')
#         if res['hits']['total'] > 0:
#             for doc in res['hits']['hits']:
#
#                 data = {}
#                 for field in doc['_source']:
#                     if field == 'absolute_path':
#                         data['absolute_path'] = doc['_source'][field]
#                     else:
#                         data[field] = doc['_source'][field]
#
#                 print repr(data['absolute_path'])
#                 es.index(index="media2", doc_type="media_folder", id=doc['_id'], body=data)
#
#     sys.exit(1)
#
