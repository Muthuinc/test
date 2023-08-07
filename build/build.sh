#! /bin/bash

# building the docker image

docker build -t muthuinc/react2:"${GIT_COMMIT}" -f ../.

echo "success"

