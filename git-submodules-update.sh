#!/bin/bash

# Prepare the environment with some common variables
BASEDIR=$(dirname $0)
. $BASEDIR/environment

# Update the submodules
pushd ${SOURCEDIR}
git reset --hard
git clean -fdx

if [ -n "${SUBMODULE}" ];
then
	if [ "${SUBMODULE}" == "core" ];
	then
		pushd system
	else
		pushd modules/${SUBMODULE}
	fi

	# Update that specific module
	git checkout ${GIT_BRANCH#origin/}
	git pull --ff-only
	popd
        if [ "${SUBMODULE}" == "core" ];
        then
		git commit -m "Update system submodule" system
        else
		git commit -m "Update ${SUBMODULE} submodule" modules/${SUBMODULE}
        fi
else
	git submodule foreach git checkout ${GIT_BRANCH#origin/}
	git submodule foreach git pull --ff-only
	git commit -a -m "Update submodules"
fi

popd
