"""Cache2 is a wrapper around a subset of Redis, it provides support for complex keys as indexes for redis lists and key groups for other Redis types"""

import os
import logging

import config
import core.cache2
import core.util
import core.log
import core.var

LOG = core.get_safe_log(__name__, logging.DEBUG)

LIST = 'list'
HASH = 'hashset'
DELIM = ':'
WILDCARD = '*'
PID = str(os.getpid())

# TODO: in order for complex keys to truly work as indexes, the ordered set of values owned by them need to be used where these keys are currently being used
# these compound (key_group + identifier) keys occupy sorted lists, and are used as indexes for other sets of data
# identifier is an arbitrary list which will be separated by DELIM

def str_clean4key(input):
    return core.util.str_clean4comp(input, DELIM, WILDCARD, '-', '_', '.')


def key_name(key_group, *identifier):
    """get a compound key name for a given identifier and a specified record type"""
    keyname = DELIM.join([PID, key_group, identifier]) if isinstance(identifier, basestring) or isinstance(identifier, unicode) \
        else DELIM.join([PID, key_group, DELIM.join(identifier)])

    result = str_clean4key(keyname)
    # LOG.debug('key_name(key_group=%s, identifier=%s) returns %s', key_group, identifier, result)
    return result


def create_key(key_group, *identifier, **values):
    """create a new compound key"""
    key = key_name(key_group, *identifier)
    if len(values) == 0:
        val = None
        result = redis.rpush(key, val)
    # (else)
    for name in values:
        val = values[name]
        result = redis.rpush(key, val)
    # LOG.debug('create_key(key_group=%s, identifier=%s) returns %s' % (key, identifier, result))
    return key


# def delete_key(key, delete_list=False, delete_hash=False):
def delete_key(key):
    result = redis.delete(key)
        
    # LOG.debug('redis.delete(key=%s) returns: %s' % (key, str(result)))


def delete_key_group(key_group):
    # LOG.debug('delete_key_group(key_group=%s)' % key_group)
    search = key_group + WILDCARD
    for key in redis.keys(search):
        delete_key(key)


def delete_keys(key_group, *identifier):
    for key in get_keys(key_group, *identifier):
        delete_key(key)


def get_key(key_group, *identifier):
    result = get_keys(key_group, *identifier)
    # LOG.debug('get_keys(key_group=%s, identifier=%s) returns %s' % (key_group, identifier, result))
    if len(result) is 1:
        return result[0]
    # (else)
    return create_key(key_group, *identifier)


def get_key_value(key_group, *identifier):
    key = get_key(key_group, *identifier)
    value = redis.lrange(key, 0, 1)
    if len(value) == 1:
        return value[0]
    return None


def get_keys(key_group, *identifier):
    search = key_group + WILDCARD if identifier is () else key_name(key_group, *identifier) + WILDCARD
    result = redis.keys(str_clean4key(search))
    # result = config.redis.scan(str_clean4key(search), 0, -1)
    # LOG.debug('get_keys(key_group=%s, identifier=%s) returns %s' % (key_group, identifier, result))
    return result


def key_exists(key_group, *identifier):
     key = key_name(key_group, *identifier)
     return redis.exists(key)


def key_exists2(key):
    return redis.exists(key)


# ordered list functions for compound keys and key groups

def rpeek(key_group, *identifier):
    key = key_name(key_group, identifier)
    return redis.range(key, -1, -1)


def rpeek2(key):
    return redis.range(key, -1, -1)


def rpush(key_group, *identifier, **value):
    key = key_name(key_group, identifier)
    for val in value:
        redis.rpush(key, value[val])


def rpush2(key, **value):
    for val in value:
        redis.rpush(key, value[val])


def lpeek(key_group, *identifier):
    key = key_name(key_group, identifier)
    return redis.range(key, 0, 0)


def lpeek2(key):
    return redis.range(key, 0, 0)


def lpush(key_group, *identifier, **value):
    key = key_name(key_group, identifier)
    for val in value:
        redis.lpush(key, value[val])


def lpush2(key, **value):
    for val in value:
        redis.lpush(key, value[val])


# hashsets

def delete_hash(key_group, identifier):
    key = DELIM.join([HASH, key_group, identifier])
    hkeys = redis.hkeys(key)
    for hkey in hkeys:
        redis.hdel(key, hkey)


def delete_hash2(key):
    identifier = DELIM.join([HASH, key])
    hkeys = redis.hkeys(identifier)
    for hkey in hkeys:
        redis.hdel(identifier, hkey)


def get_hash(key_group, identifier):
    key = DELIM.join([HASH, key_group, identifier])
    result = redis.hgetall(key)
    # LOG.debug('get_hash(key_group=%s, identifier=%s) returns %s' % (key_group, identifier, result))
    return result


def get_hash2(key):
    identifier = DELIM.join([HASH, key])
    result = redis.hgetall(identifier)
    # LOG.debug('get_hash2ss(key=%s) returns %s' % (key, result))
    return result


def get_hashes(key_group, *identifier):
    result = ()
    if identifier is ():
        for key in get_keys(DELIM.join([HASH, key_group])):
            hash = redis.hgetall(key)
            if hash is not None:
                result += (hash,)
    #(else)
    for keyname in identifier:
        key = DELIM.join([HASH, key_group, keyname])
        hash = redis.hgetall(key)
        if hash is not None:
            result += (hash,)

    # LOG.debug('get_hashes(key_group=%s, identifier=%s) returns %s' % (key_group, identifier, result))
    return result


def set_hash(key_group, identifier, values):
    key = DELIM.join([HASH, key_group, identifier])
    result = redis.hmset(key, values)
    # LOG.debug('set_hash(key_group=%s, identifier=%s, values=%s) returns: %s' % (key_group, identifier, values, str(result)))


def set_hash2(key, values):
    identifier = DELIM.join([HASH, key])
    result = redis.hmset(identifier, values)
    # LOG.debug('set_hash2(key=%s, values=%s) returns: %s' % (key, values, str(result)))


# lists

def add_item(key_group, identifier, item):
    key = DELIM.join([LIST, key_group, identifier])
    result = redis.sadd(key, item)
    # LOG.debug('add_item(key_group=%s, identifier=%s, item=%s) returns: %s' % (key_group, identifier, item, str(result)))


def add_item2(key, item):
    key = DELIM.join([LIST, key])
    result = redis.sadd(key, item)
    # LOG.debug('add_item(key=%s,item=%s) returns: %s' % (key, item, str(result)))


def add_items(key_group, identifier, items):
    for item in items:
        add_item(key_group, identifier, item)
        # key = DELIM.join([LIST, key_group, identifier])
        # result = config.redis.sadd(key, item)
        # # LOG.debug('add_item(key_group=%s, identifier=%s, item=%s) returns: %s' % (key_group, identifier, item, str(result)))


def add_items2(key, items):
    for item in items:
        key = DELIM.join([LIST, key])
        result = redis.sadd(key, item)
        # LOG.debug('add_item(key_group=%s, identifier=%s, item=%s) returns: %s' % (key_group, identifier, item, str(result)))


def clear_items(key_group, identifier):
    key = DELIM.join([LIST, key_group, identifier])
    values = redis.smembers(key)
    for value in values:
        result = redis.srem(key, value)
        # LOG.debug('redis.srem(key_group=%s, identifier=%s) returns: %s' % (key, value, str(result)))


def clear_items2(key):
    key = DELIM.join([LIST, key])
    values = redis.smembers(key)
    for value in values:
        result = redis.srem(key, value)
        # LOG.debug('redis.srem(key_group=%s, identifier=%s) returns: %s' % (key, value, str(result)))


def get_items(key_group, identifier):
    key = DELIM.join([LIST, key_group, identifier])
    result = redis.smembers(key)
    # LOG.debug('get_items(key_group=%s, identifier=%s) returns: %s' % (key_group, identifier, str(result)))
    return result


def get_items2(key):
    key = DELIM.join([LIST, key])
    result = redis.smembers(key)
    # LOG.debug('get_items(key=%s) returns: %s' % (key, str(result)))
    return result


# utility

def flush_all():
    # flush_cache()
    LOG.info('flushing redis database')
    redis.flushall()