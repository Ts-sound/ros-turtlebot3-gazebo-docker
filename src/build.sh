#!/bin/bash

docker build -t ros-turtlebot3-sim . 2>&1 | tee build.log