import os, sys, thread

import kivy
kivy.require('1.9.1') # replace with your current kivy version !

import redis

from kivy.app import App
from kivy.uix.boxlayout import BoxLayout
from kivy.uix.label import Label

class CacheMonitor(App):
    def __init__(self, **kwargs):
        super(CacheMonitor, self).__init__(**kwargs)

        self.operation_lbl = None
        self.operator_lbl = None
        self.op_target_lbl = None

        # self.configure_sub()

    def build(self):
        root = BoxLayout()
        root.orientation = 'vertical'

        self.operator_lbl = Label(text='Operator')
        self.operation_lbl = Label(text='Operation')
        self.op_target_lbl = Label(text='target')

        root.add_widget(self.operator_lbl)
        root.add_widget(self.operation_lbl)
        root.add_widget(self.op_target_lbl)

        thread.start_new_thread( self.configure_sub, ( 'OPS', ) )

        return root

    def configure_sub(self, topic):
        try:
            r = redis.Redis('localhost')
            pubsub = r.pubsub()
            pubsub.subscribe(topic)

            # print 'Listening to {channel}'.format(**locals())

            while True:
                for item in pubsub.listen():
                    print item['data']
                    self.operation_lbl.text = str(item['data'])
                    
        except Exception, err:
            print err.message

if __name__ == '__main__':
    CacheMonitor().run()