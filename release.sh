#!/bin/bash

# Prepare the environment with some common variables
BASEDIR=$(dirname $0)
. $BASEDIR/environment

# Cleanup after previous builds
rm -rf build || true
mkdir build

# For debugging..
env

# Lets go..
pushd $SOURCEDIR/system

# Release the current version.
if [ -f "classes/kohana/core.php" ];
then
	sed -e "s/VERSION_FINAL[ ]*=[ ]*.*/VERSION_FINAL = TRUE/g" -i classes/kohana/core.php
else
	sed -e "s/VERSION_FINAL[ ]*=[ ]*.*/VERSION_FINAL = TRUE/g" -i classes/Kohana/Core.php
fi

git commit -a -m "Releasing Kohana v${KOHANA_VERSION}." || exit 1
git tag -s v${KOHANA_VERSION} || exit 1
git push origin HEAD:refs/head/${KOHANA_SERIES}/develop || exit 1
git push origin HEAD:refs/head/${KOHANA_SERIES}/master || exit 1
git push origin v${KOHANA_VERSION} || exit 1

# Start the next iteration
if [ -f "system/classes/kohana/core.php" ];
then
	sed -e "s/VERSION[ ]*=[ ]*'.*'/VERSION = '${NEXT_VERSION_NUMBER}'/g" -i classes/kohana/core.php
	sed -e "s/CODENAME[ ]*=[ ]*'.*'/CODENAME = '${NEXT_VERSION_CODENAME}'/g" -i classes/kohana/core.php
	sed -e "s/VERSION_FINAL[ ]*=[ ]*.*/VERSION_FINAL = FALSE/g" -i classes/kohana/core.php
else
	sed -e "s/VERSION[ ]*=[ ]*'.*'/VERSION  = '${NEXT_VERSION_NUMBER}'/g" -i classes/Kohana/Core.php
	sed -e "s/CODENAME[ ]*=[ ]*'.*'/CODENAME = '${NEXT_VERSION_CODENAME}'/g" -i classes/Kohana/Core.php
	sed -e "s/VERSION_FINAL[ ]*=[ ]*.*/VERSION_FINAL = FALSE/g" -i classes/Kohana/Core.php
fi

git commit -a -m "Starting Kohana v${KOHANA_VERSION} iteration." || exit 1
git push origin HEAD:refs/head/${KOHANA_SERIES}/develop || exit 1
popd
