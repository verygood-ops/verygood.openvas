## OpenVAS deployment via Elastic Beanstalk

### Local development

* Run container locally from Dockerfile at https://github.com/lazzarello/openvas-docker

### Devlopment deployment

Upload image to ECR
    1. aws ecr get-login --region us-west-2
    1. _execute command output in your shell_
    1. aws ecr create-repository --repository-name openvas
    1. docker tag <image id> <repository uri>
    1. docker push <repository uri>

_Now you have the container published in ECR. Any ECR compatible
applications can launch an instance of it. We will be using Elastic
Beanstalk._

Configure your environment. Ensure the following variables are set to
meaningful values. These determine what account and credentials are used
for the deployment.

`$ECR_SECRET` is the secret generated by the `aws ecr get-login` step.
It can also be found in `~/.docker/config.json`

`$S3_AUTH_BUCKET` requires a value which is the bucket name containing
your Docker configuration, in the format indicated in `config.json`

`$AWS_DEFAULT_REGION` requires a value indicating the region in AWS
format. For example `us-west-2`

`$AWS_ACCOUNT_ID` is the account ID associated with the account where
you will deploy your application. 

`./gen_dockerrun.sh`
`eb init`
`eb create`
`eb setenv HTTP_ONLY=true`

This will test that everything can deploy correctly. The application
listens on port 80. A production deployment should set up a load
balancer to do secure termination in front of the container server.
