#!/usr/bin/env bash
docker build -t gxml-docker .
docker run --rm -u ${UID}:${GROUPS} -v $(pwd)/build/:/build/ -w / -ti gxml-docker
