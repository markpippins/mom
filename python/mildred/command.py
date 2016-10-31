'''
   Usage: command.py [--stop] [--reconfig] ([--inc_path_cache_size])

'''
import os

import docopt
import redis

from core import var


def _connect_to_redis():
    return redis.Redis('localhost')


def _set_field_value(pid, field, value):

    import ops
    from core import cache2

    cache2.redis = _connect_to_redis()
    key =  cache2.get_key(pid, ops.OPS, ops.EXEC)

    values = cache2.get_hash2(key)
    values[field] = value
    cache2.set_hash2(key, values)


def request_stop(pid):
    print 'submitting stop request for %s...' % (pid)
    _set_field_value(pid, 'stop_requested', True)


def request_reconfig(pid):
    print 'submitting reconfig request for %s...' % (pid)
    _set_field_value(pid, 'reconfig_requested', True)


def get_pid():
    if os.path.exists('pid'):
        f = open('pid', 'rt')
        pid = f.readline()
        f.close()

        return pid


def main(args):

    pid = get_pid()
    if pid is not None:
        var.workdir = os.path.abspath(os.path.join('pid', os.pardir))
        if args['--reconfig']: request_reconfig(pid)
        if args['--stop']: request_stop(pid)
        # if args['--inc_path_cache_size']: inc_cache_size(pid, 'path')

# main
if __name__ == '__main__':
    args = docopt.docopt(__doc__)
    main(args)