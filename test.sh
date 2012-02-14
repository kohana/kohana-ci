#!/bin/bash

# Prepare the environment with some common variables
BASEDIR=$(dirname $0)
. $BASEDIR/environment

# Cleanup after previous builds
rm -rf build || true
mkdir build

# PHPUnit Params
PARAMS="--log-junit=../build/junit.xml"

# Figure out what bootstrap fike to use
if [ "${KOHANA_SERIES}" == "3.1" ]; then
	PARAMS="${PARAMS} --bootstrap=modules/unittest/bootstrap.php"
else
	PARAMS="${PARAMS} --bootstrap=modules/unittest/bootstrap_all_modules.php"
fi

# Do we only want to run a certain group of tests?
if [ -n "${PHPUNIT_GROUP}" ]; then
	PARAMS="${PARAMS} --group ${PHPUNIT_GROUP}"
fi

# Do we want code coverage?
if [ -n "${PHPUNIT_COVERAGE}" ]; then
        PARAMS="${PARAMS} --coverage-clover=../build/clover.xml --coverage-html=../build/coverage"
fi

# Run the tests..
pushd $SOURCEDIR
phpunit $PARAMS modules/unittest/tests.php
EXIT=$?
popd

exit $EXIT
