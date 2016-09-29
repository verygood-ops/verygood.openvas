#!/bin/sh

mv Dockerrun.aws.json deploy/
pushd deploy

if [ -d .elasticbeanstalk ]
then
    eb create
else
    eb init
    eb create
fi

eb setenv HTTP_ONLY=true
popd
