#!/bin/bash

IMAGE_NAME=payara:micro.jcache

docker build -t $IMAGE_NAME .

if [ $? -ne 0 ]
then
    echo "Build failed!"
else
    echo "The payara-micro docker image has been built."
    echo "To start a new container, execute: docker run -it payara:micro.jcache"
fi

