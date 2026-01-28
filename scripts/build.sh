#!/bin/bash

set -e

cd docker
docker build -t ros2-humble-turtlebot3-sim:latest . 2>&1 | tee build.log