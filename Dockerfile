FROM docker:latest
MAINTAINER Oleksii Zhyrenkov <ozhyrenkov@gmail.com>

# Install python
RUN apk update && apk --no-cache add python py-pip python-dev build-base git bash nano

# Install pip
RUN pip install --upgrade pip

# Install aws command line services
RUN pip install awscli awsebcli
