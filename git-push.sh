#!/bin/bash

# Prepare the environment with some common variables
BASEDIR=$(dirname $0)
. $BASEDIR/environment

# Push back to where we came from
pushd ${SOURCEDIR}
git push ${GIT_BRANCH%%/*} HEAD:${GIT_BRANCH#origin/} || exit 1
popd
