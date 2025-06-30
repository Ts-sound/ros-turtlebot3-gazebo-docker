#!/bin/bash

docker build -t ros2-humble-turtlebot3-sim . 2>&1 | tee build.log