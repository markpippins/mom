
#! /usr/bin/python


import os, sys, logging, datetime, json

from elasticsearch import Elasticsearch

import config, const
from const import FILE
from core import log, var, util
from errors import ElasticDataIntegrityException

LOG = log.get_safe_log(__name__, logging.DEBUG)
ERR = log.get_safe_log('errors', logging.WARNING)

def get_backup_folder(doc_id, target_folder=var.snapshotdir):
    return os.path.join(target_folder, util.expand_str_to_path(doc_id))
    
def backup_doc(doc, target_folder=var.snapshotdir):

    doc_id = doc['_id']
    backupfolder = get_backup_folder(doc_id, target_folder)
    if not os.path.isdir(backupfolder):
        os.makedirs(backupfolder)

    doc_name = '.'.join([str(datetime.datetime.utcnow().strftime('%Y-%m-%d %H:%M:%S.%f')[:-3]).replace(' ', '_'), 'json'])

    backup = os.path.join(backupfolder, doc_name)
    with open(backup, 'w') as file:
        try:
            data = json.dumps(doc, ensure_ascii=True, indent=4, sort_keys=True)
            file.write(data)
            file.flush()
            file.close()
        except Exception, err:
            raise err

    return os.path.isfile(backup)

def backup_exists(doc,target_folder=var.snapshotdir):
    doc_id = doc['_id']
    backupfolder = get_backup_folder(doc_id, target_folder)
    if os.path.isdir(backupfolder):
        return True

def clear_index(index):
    if config.es.indices.exists(index):
        LOG.debug("deleting '%s' index..." % index)
        res = config.es.indices.delete(index = index)
        LOG.debug(" response: '%s'" % (res))


def connect(hostname=config.es_host, port_num=config.es_port):
    LOG.debug('Connecting to Elasticsearch at %s on port %i...'% (hostname, port_num))
    es = Elasticsearch([{'host': hostname, 'port': port_num}])
    LOG.debug('returning %s'% (es))
    return es

def create_index(index):
    try:
        LOG.debug("creating '%s' index..." % index)
        # since we are running locally, use one shard and no replicas
        if index == const.FILE:
             request_body = {
           "settings" : {
               "number_of_shards": 1,
               "number_of_replicas": 0
           },
           "mappings": {
               FILE: {
                   "date_detection": False,
                   "properties":{
                       "attributes":{
                           "type" : "nested",
                           "properties":{
                               "TXXX":{
                                   "type" : "nested"
                               }
                           }
                       }
                   }
               }
           }
        }

        else:
            request_body = {
                "settings" : {
                    "number_of_shards": 1,
                    "number_of_replicas": 0
                }
            }
        
        res = config.es.indices.create(index, request_body)
        LOG.debug("response: '%s'" % res)
    
    except Exception, err:
        LOG.error(err.message)
        print(err.message)
        sys.exit(1)

def delete_doc(doc):
    doc_id = doc['_id']
    asset_type = doc['_type']
    if backup_doc(doc, target_folder=var.outqueuedir):
        try:
            config.es.delete(asset_type, asset_type, doc_id)
        except Exception, err:
            LOG.error(err.message)


def delete_docs(asset_type, attribute, value):
    docs = find_docs(asset_type, attribute, value)
    for doc in docs:
        # save a backup of the doc to local file system
        delete_doc(doc)


# find assets with matching top-level attribute, (doc['_source']['attribute'])
def find_docs(asset_type, attribute, value):
    result = ()
    res = config.es.search(asset_type, doc_type=asset_type, body={ "query": { "match" : { "%s" % attribute: value }}})
    for doc in res['hits']['hits']:
        try:
            if doc['_source'][attribute] == value:
                result += (doc,)
        except UnicodeWarning, warning:
            LOG.warn(warning.message)
    
    return result


def find_docs_missing_attribute(asset_type, attribute, max_results=1000):
    query = { "query" : { "bool" : { "must_not" : { "exists" : { "field" : attribute }}}}}
    return config.es.search(asset_type, asset_type, query, size=max_results)


def get_doc(asset_type, esid):
    try:
        return config.es.get(index=asset_type, doc_type=asset_type, id=esid)
    except Exception, err:
        LOG.error(err.message)
        raise Exception('DOC NOT FOUND FOR ID: %s' % esid)


def get_doc_id(asset_type, attribute, value):
    docs = find_docs(asset_type, attribute, value)
    if len(docs) is 1:
        return docs[0]['_id']
    # else
    raise Exception("Attribute %s does not identify a unique asset" % attribute)


def unique_doc_exists(asset_type, attribute, value, except_on_multiples=False):
    docs = find_docs(asset_type, attribute, value)
    doc_count = len(docs)

    if doc_count > 1 and except_on_multiples:
        # if asset_type == const.FILE:
            # print "multiple assets found for % %s (%s)" % (asset_type, attribute, value)
            # sys.exit(1)

        raise ElasticDataIntegrityException(asset_type, attribute, value)

    return doc_count is 1


def unique_doc_id(asset_type, attribute, value):
    docs = find_docs(asset_type, attribute, value)
    if len(docs) is 1:
        return docs[0]['_id']
    # else

def main():
    config.es = connect('localhost', 9200)
    clear_index('media')
    create_index('media')

# main
if __name__ == '__main__':
    main()