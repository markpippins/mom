import os, sys
import logging
import pyorient

import const
import alchemy
from assets import Asset, Directory
import assets
import config
import json
import ops
import search
import sql
from alchemy import SQLAsset, get_session
from core import introspection, log
from core.vector import PathVectorScanner, ACTIVE_FILE, ACTIVE_PATH, PERSIST


from alchemy import SQLAction, SQLReason, SQLReasonParam, SQLAction, SQLReason, SQLReasonParam

LOG = log.get_safe_log(__name__, logging.INFO)
ERR = log.get_safe_log('errors', logging.WARNING)

ANALYZER = 'ANALYZER'
CONDITION = 'CONDITION'
ANALYSIS = 'ANALYSIS'

def analyze(vector):
    if ANALYZER not in vector.data:
        vector.data[ANALYZER] = Analyzer(vector)
    vector.data[ANALYZER].run()


class Analyzer(object):
    """The action ANALYZER examines files and paths and proposes actions based on conditional methods invoked by Reason"""

    def __init__(self, vector):
        self.vector = vector
        self.vector_scanner = PathVectorScanner(ANALYZER, vector, self.handle_vector_path, handle_error_func=self.handle_error)

    def handle_error(self, error, path):
        pass

    def handle_vector_path(self, path):
        self.generate_reasons(path)
        pass

    def analyze_asset(self, _reasons, asset):
        self.vector.set_param(ANALYZER, ACTIVE_FILE, asset.absolute_path)
        for _reason in _reasons:
            dispatch_funcs = _reason['funcs']
            unsatisfied_conditions = len(dispatch_funcs)
            for func in dispatch_funcs:
                if func(asset) == _reason['expected_result']:
                    unsatisfied_conditions -= 1

            if unsatisfied_conditions == 0:
                reason = SQLReason()
                reason._reason_id = _reason['id']

                vector_params = self.vector.get_params(ANALYZER)
                for param in _reason['params']:
                    param_name = param['vector_param_name']
                    param_id = param['id']
                    if param_name in vector_params:
                        reason_param = SQLReasonParam()
                        reason_param._reason_param_id = param_id
                        reason_param.value = vector_params[param_name]
                        reason.params.append(reason_param)

                session = alchemy.get_session(alchemy.ANALYSIS)
                session.add(reason)
                session.commit()


    def oRecord2dict(self, oRecord, *items):
        result = {}
        result['rid'] = oRecord._OrientRecord__rid
        for item in items:
            result[item] = oRecord.oRecordData[item]

        return result

    def get__reasons(self):

        results = ()

        try:
            client = pyorient.OrientDB("localhost", 2424)
            session_id = client.connect( "root", "steel" )
            client.db_open( "merlin", "root", "steel" )

            # reasons = client.query("select from (traverse all() from (select from Reason))")
            reasons = client.query("select from Reason")
            for reason in reasons:
                reason_data = self.oRecord2dict(reason, 'id', 'name', 'expected_result')
                reason_data['funcs'] = ()
                reason_data['params'] = ()

                dispatches = client.query("select from (traverse all() from %s) where @class = 'Dispatch' and category = 'CONDITION'" % reason_data['rid'])
                for dispatch in dispatches:
                    func = self.oRecord2dict(dispatch, 'id', 'package_name', 'module_name', 'class_name', 'func_name')
                    condition = introspection.get_qualified_name(func['package_name'], func['module_name'], func['func_name'])
                    if condition:
                        condition_func = introspection.get_func(condition)
                        reason_data['funcs'] += condition_func,

                params = client.query("select from (traverse all() from %s) where @class = 'ReasonParam'" % reason_data['rid'])
                for param in params:
                    reason_data['params'] += self.oRecord2dict(param, 'id', 'vector_param_name'),

                results += reason_data,

            client.db_close()
            return results
        except Exception, err:
            ERR.error(err.message)
            sys.exit(0)

    def generate_reasons(self, path):
        # actions = self.retrieve_types()
        reasons = self.get__reasons()

        for file_ in SQLAsset.retrieve(const.FILE, path, use_like=True):
            asset = Asset(file_.absolute_path, esid=file_.id)
            # esdoc = search.get_doc(const.FILE, asset.esid)
            # asset.data = asset.to_dictionary()Glob

            # if no op record exists
            self.analyze_asset(reasons, asset)

        # for folder in SQLAsset.retrieve(const.DIRECTORY, path, use_like=True):
        #     directory = Directory(folder.absolute_path, esid=folder.id)
        #     esdoc = search.get_doc(const.DIRECTORY, directory.esid)
        #     directory.data = directory.to_dictionary()

        #     # if no op record exists
        #     self.analyze_asset(reasons, directory)

    def propose_actions(self, path):
        # action
        pass

        # invoke conditionals for all reasons
        # create action set
        # insert actions as proposal
        # training data is my selection between available actions or custom selection,
        # including query operations performed while analyzing choice and analysis reason stamp (selectad tags match source, etc)
        # as well as predicted response


    def run(self):
        pass
        # self.vector.reset(ANALYZER)
        # self.vector.set_param(ANALYZER, ACTIVE_PATH, None)
        # self.vector_scanner.scan();
