#!/bin/bash

set -e

docker build -t ros2-humble-turtlebot3-sim:latest . 2>&1 | tee build.log