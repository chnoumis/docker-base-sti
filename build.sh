#!/bin/sh

. ./setenv.sh
sudo docker build -t base-sti:${DOCKER_VERSION} .