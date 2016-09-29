clean:
	rm -f config.json deploy/Dockerrun.aws.json Dockerrun.aws.json

config:
	./gen_dockerrun.sh

upload:
	aws s3 cp s3://$S3_AUTH_BUCKET/config.json

eb_deploy:
	./move_and_deploy.sh
