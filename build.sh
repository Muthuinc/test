#! /bin/bash

# building the docker image

docker build -t muthuinc/reactprod2:"${GIT_COMMIT}" .


echo "success"

