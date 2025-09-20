#!/bin/bash

set -e

# mkdir -p src/ \
#     && cd src/ \
#     && git clone -b humble https://github.com/ROBOTIS-GIT/DynamixelSDK.git \
#     && git clone -b humble https://github.com/ROBOTIS-GIT/turtlebot3_msgs.git \
#     && git clone -b humble https://github.com/ROBOTIS-GIT/turtlebot3.git \
#     && git clone -b humble https://github.com/ROBOTIS-GIT/turtlebot3_simulations.git \
#     && /bin/bash -c "source /opt/ros/humble/setup.bash && cd ~/turtlebot3_ws && colcon build --symlink-install "

source /opt/ros/humble/setup.bash &&  colcon build --symlink-install 
