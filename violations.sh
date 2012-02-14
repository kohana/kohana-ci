#!/bin/bash

# Prepare the environment with some common variables
BASEDIR=$(dirname $0)
. $BASEDIR/environment

# Cleanup after previous builds
rm -rf build || true
mkdir build

# Lets go..
pushd $SOURCEDIR
phpcs --standard=Kohana -s --extensions=php --report=checkstyle **/classes **/**/classes > ../build/phpcs.xml
PHPCSEXIT=$?
popd
