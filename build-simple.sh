#!/bin/bash
COMPONENT=${PWD##*/}
docker build --no-cache --rm . -t ${COMPONENT}
