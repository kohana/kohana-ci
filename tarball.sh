#!/bin/bash

# Prepare the environment with some common variables
BASEDIR=$(dirname $0)
. $BASEDIR/environment

# Cleanup after previous builds
rm -rf build || true
mkdir build

# Build the tarball
pushd ${SOURCEDIR}
tar czf ${WORKSPACE}/build/kohana-${KOHANA_VERSION}~${BUILD_NUMBER}.tar.gz --exclude-vcs --transform "s,^,kohana-${KOHANA_VERSION}~${BUILD_NUMBER}/," *
popd
