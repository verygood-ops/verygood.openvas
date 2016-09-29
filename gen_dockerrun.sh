#!/bin/sh

set -e -x

DOCKER_CONFIG="config.json"
DOCKERRUN="Dockerrun.aws.json"

for file in $DOCKER_CONFIG $DOCKERRUN
do
    if [ -e $file ]
    then
        printf "You have a previously configured %d file. Please remove it to generate a new one.\n" $file
        exit 1
    fi
done

 
if [ $S3_AUTH_BUCKET == "" ]
then
    printf "Please set S3_AUTH_BUCKET to a value\n"
    exit 1
elif [ $AWS_ACCOUNT_ID == "" ]
then
    printf "Please set AWS_ACCOUNT_ID to a value\n"
    exit 1
elif [ $AWS_DEFAULT_REGION == "" ]
then
    printf "Please set AWS_DEFAULT_REGION to a value\n"
    exit 1
elif [ $ECR_SECRET == "" ]
then
    printf "Please set ECR_SECRET to a value\n"
    exit 1
fi

sed s/AWS_ACCOUNT_ID/${AWS_ACCOUNT_ID}/g $DOCKER_CONFIG.example > $DOCKER_CONFIG
# BSD sed needs this -i '' syntax
sed -i '' s/AWS_DEFAULT_REGION/${AWS_DEFAULT_REGION}/g $DOCKER_CONFIG
sed -i '' s/ECR_SECRET/${ECR_SECRET}/g $DOCKER_CONFIG

sed s/AWS_ACCOUNT_ID/${AWS_ACCOUNT_ID}/g $DOCKERRUN.example > $DOCKERRUN
sed -i '' s/AWS_DEFAULT_REGION/${AWS_DEFAULT_REGION}/g $DOCKERRUN
# trick to allow for / characters in the params
sed -i '' 's|S3_AUTH_BUCKET|'${S3_AUTH_BUCKET}'|g' $DOCKERRUN
