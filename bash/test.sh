#!/bin/bash

pushd $MILDRED_HOME/python/test

clear

for filename in ./*.py; do
    echo $filename
    /home/mpippins/.virtualenvs/media/bin/python2.7 "$filename"
done

popd
