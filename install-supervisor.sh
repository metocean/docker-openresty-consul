#!/bin/sh
set -e

curl https://bootstrap.pypa.io/get-pip.py | python
pip install supervisor
