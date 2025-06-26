#!/bin/bash

docker build -t ros2-turtlebot3-sim . 2>&1 | tee build.log