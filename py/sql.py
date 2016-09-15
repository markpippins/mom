#!/usr/bin/env python

import os, sys, datetime, traceback, config, logging
import MySQLdb as mdb

def quote_if_string(value):
    if isinstance(value, basestring):
        return '"%s"' % value
    if isinstance(value, unicode):
        return u'"' + value + u'"'

    value = value.replace("'", "\'")
    return value

def insert_values(table_name, field_names, field_values):

        formatted_values = [quote_if_string(value) for value in field_values]
        query = 'INSERT INTO %s(%s) VALUES(%s)' % (table_name, ','.join(field_names), ','.join(formatted_values))
        execute_query(query)

# TODO: add handling for boolean values
def retrieve_values(table_name, field_names, field_values, order_by=[]):

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

    # if order_by is not []: query += " ORDER BY " + str(order_by).replace('[', '').replace(']', '')
    return run_query(query)


def retrieve_like_values(table_name, field_names, field_values):

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

    return run_query(query)
    
def run_query(query):

    con = None
    rows = []

    try:
        logging.getLogger(config.sql_log).info(query)
        con = mdb.connect(config.mysql_host, config.mysql_user, config.mysql_pass, config.mysql_db)
        cur = con.cursor()
        cur.execute(query)
        rows = cur.fetchall()

        if rows is not None: logging.getLogger(config.error_log).info('returning %i rows.' % len(rows))

    except mdb.Error, e:

        message = "Error %d: %s" % (e.args[0], e.args[1])
        logging.getLogger(config.error_log).error(message)
        logging.getLogger(config.error_log).warn(query)
        raise Exception(message)

    finally:
        if con: con.close()

    return rows

def execute_query(query):

    con = None
    rows = []

    try:
        logging.getLogger(config.error_log).info(query)
        con = mdb.connect(config.mysql_host, config.mysql_user, config.mysql_pass, config.mysql_db)
        cur = con.cursor()
        cur.execute(query)
        con.commit()

    except mdb.Error, e:
        message = "Error %d: %s" % (e.args[0], e.args[1])
        config.error_log.error(message)
        config.error_log.warn(query)
        raise Exception(message)

    finally:
        if con: con.close()

    return rows

def update_values(table_name, update_field_names, update_field_values, where_field_names, where_field_values):

    query = ' '.join(['UPDATE', table_name, 'SET '])

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

    execute_query(query)
