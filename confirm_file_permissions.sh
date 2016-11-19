#!/bin/sh

# MIT License
# 
# Copyright (c) 2016 Radio Revolt, the Student Radio of Trondheim
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# Script to check that the current user does not have
# write permission to the application (to reduce the
# consequences of a compromise).
APPLICATION_DIRS=". templates plugins venv venv/bin"
# Iterate through the directories listed above
for d in $APPLICATION_DIRS
do
    # Check whether the directory is writable
    if test -w "$d"
    then
        (>&2 echo "Error: directory $d is writable by `whoami`.")
        exit 1
    fi

    # Iterate through every file in this directory
    for f in $d/*
    do
        # Check whether the file is writable (except ./log, which can be writable)
        if test -w "$f" && test "$f" != "./log"
        then
            (>&2 echo "Error: file $f is writable by `whoami`.")
            exit 3
        fi
    done
done

exit 0
