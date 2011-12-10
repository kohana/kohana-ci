#!/bin/bash

# Enable command tracing
set -o xtrace

# Cleanup after previous builds
rm -rf $WORKSPACE/*.tar.gz $WORKSPACE/*.zip

# Figure out what version of Kohana we are building
pushd source
KOHANA_VERSION=`php -r "define('SYSPATH',''); include 'system/classes/kohana/core.php'; echo Kohana_Core::VERSION;"`
popd

# Is this a master or develop branch build?
case "$GIT_BRANCH" in
    *master ) export KOHANA_BRANCH_TYPE="master" ;;
    *develop ) export KOHANA_BRANCH_TYPE="develop" ;;
esac

# Determine the final version string
if [ "$KOHANA_BRANCH_TYPE" == "master" ]
then
    export VERSION="${KOHANA_VERSION}"
else
    DATE=`date +%Y%m%d`~`date +%H%M`
    export VERSION="${KOHANA_VERSION}+git${DATE}"
fi

# Build the tarball
pushd source
tar czf ${WORKSPACE}/kohana-${VERSION}.tar.gz --exclude-vcs --transform "s,^,kohana-${VERSION}/," *
popd
