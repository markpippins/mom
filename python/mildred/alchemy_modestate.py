import os, sys, logging

import alchemy

from core import log
from core.modestate import StatefulMode, ModeStateReader, ModeStateWriter
from core.states import State

LOG = log.get_log(__name__, logging.DEBUG)

class AlchemyModeStateWriter(ModeStateWriter):
    def __init__(self, mode_rec=None):
        super(AlchemyModeStateWriter, self).__init__()


    def expire_state(self, mode):
        alchemy.update_mode_state(mode, expire=True)


    def save_state(self, mode):
        mode.mode_state_id = alchemy.insert_mode_state(mode)


    def update_state(self, mode):
        alchemy.update_mode_state(mode)



class AlchemyModeStateReader(ModeStateReader):
    def __init__(self, mode_rec=None):
        super(AlchemyModeStateReader, self).__init__()



    def initialize_context_params(self, state):

        # raise BaseClassException(ModeStateReader)
        pass

    def initialize_state(self, mode, state):

        self.initialize_state_with_defaults(mode, state)

        alchemy_mode  = alchemy.retrieve_mode(mode.name)
        if alchemy_mode:
            self.mode_rec[mode] = alchemy_mode

        sqlstate = alchemy.retrieve_state(state.name)

        state.is_initial_state = sqlstate.is_initial_state
        state.is_terminal_state = sqlstate.is_terminal_state

    def initialize_state_with_current_snapshot(self, mode):
        alchemy_mode_state = alchemy.retrieve_previous_mode_state_record(mode.name)
        if alchemy_mode_state:
            for mode_state in mode.get_states():
                if mode_state.name == alchemy_mode_state.status:
                    # if mode.get_state() != state:
                    mode.set_state(mode_state)
                    break


    def initialize_state_with_defaults(self, mode, state):
        alchemy_mode  = alchemy.retrieve_mode(mode.name)
        if alchemy_mode:
            self.mode_rec[mode] = alchemy_mode
            for default in alchemy_mode.default_states:
                if state.name == default.status: 
                    mode.state_id = default.id
                    
                    mode.priority = default.priority
                    mode.times_to_complete = default.times_to_complete
                    mode.dec_priority_amount = default.dec_priority_amount
                    mode.inc_priority_amount = default.inc_priority_amount

                    for param in default.default_params:
                        value = param.value
                        if str(value).lower() == 'true':
                            value = True
                        elif str(value).lower() == 'false':
                            value = False
                        
                        state.add_param(param.name, value)
        return mode


    def load_state_defaults(self, mode):
        alchemy_mode = alchemy.retrieve_mode(mode.name)
        if alchemy_mode:
            self.mode_rec[mode] = alchemy_mode
            for default in alchemy_mode.default_states:
                state = State(default.status, data=default)

                self.initialize_state(mode, state)

                state.params = ()
                for param in default.default_params:
                    value = param.value
                    if str(value).lower() == 'true':
                        value = True
                    elif str(value).lower() == 'false':
                        value = False

                    state.add_param(param.name, value)
             
                mode.add_state_default(state)

