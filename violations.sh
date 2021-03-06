#!/bin/bash

# Prepare the environment with some common variables
BASEDIR=$(dirname $0)
. $BASEDIR/environment

# Cleanup after previous builds
rm -rf build || true
mkdir build

# What paths do we want to check?
PHPCS_PATHS=${PHPCS_PATHS:-**/classes **/**/classes}

# Lets go..
pushd $SOURCEDIR
phpcs --standard=Kohana -s --extensions=php --report=checkstyle $PHPCS_PATHS > ../build/phpcs.xml
PHPCSEXIT=$?
popd
