# syntax=docker/dockerfile:1.0

FROM jenkins/agent:bullseye-jdk11

ARG JENKINS_URL=$JENKINS_URL
ARG JENKINS_SECRET=$JENKINS_SECRET

USER root

RUN set -o pipefail && \
    apt-get update && \
    apt-get -y --no-install-suggests --no-install-recommends install \
        ca-certificates \
        curl \
        gnupg \
        lsb-release && \
    mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
    $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    apt-get update && \
    apt-get install docker-ce-cli -y

USER jenkins
