#! /bin/bash

pushd $m2/python
~/dev/_virtual_env/mom/bin/python2.7 $m2/python/mildred/launch.py  --nomatch
popd
