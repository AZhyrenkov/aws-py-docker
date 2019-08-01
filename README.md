# aws-py-docker
Docker image with aws tools, python and docker inside

Basic idea behind - to speed up Gitlab CI image used for release to ECS via gitlab-runner running in AWS ec2

## Usage
Just put it in top of your .gitlab-ci.yml file:
```
image: ozhyrenkov/aws-py-docker:latest

```
## Update in docker registry:

```
docker build -t aws-py-docker . 
docker push aws-py-docker:latest
```
## Example of .gitlab-ci.yml:
```
image: ozhyrenkov/aws-py-docker:latest

variables:
  DOCKER_DRIVER: overlay

services:
  - docker:18.09.8-dind

before_script:
  - docker info

build-deploy-dev:
  only:
# Only in master branch
  - master
  script:
# login into Elastic Container Registry
  - aws ecr get-login --region eu-west-1 --no-include-email | bash  
# Build your app image from Dockerfile in repository
  - docker build -t my-app . 
# Tag built image and push it to registry in AWS
  - docker tag my-app:latest blah-blah.dkr.ecr.eu-west-1.amazonaws.com/my-app:latest
  - docker push blah-blah.dkr.ecr.eu-west-1.amazonaws.com/myapp-app:latest
# Force new deployment of ECS task
  - aws configure set region eu-west-1 
  - aws ecs update-service --cluster my-app --service my-app --force-new-deployment
```

