#!/bin/bash

mkdir kohana || true
pushd kohana

tar xfz ../kohana-*.tar.gz --strip-components=1

if [ "${KOHANA_MODULE}" == "core" ]; then
	rm -rf system || true
	ln -s ../source system || true
else
	rm -rf modules/${KOHANA_MODULE} || true
	ln -s ../../source modules/${KOHANA_MODULE} || true
fi

popd
