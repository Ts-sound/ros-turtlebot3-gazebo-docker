# pull image
FROM althack/ros2:humble-base
# FROM osrf/ros:humble-desktop-full

# install deb
RUN apt-get update && apt-get install -y \
    openssh-server vim zip git screen openssh-server

# set keyboard
RUN echo "keyboard-configuration keyboard-configuration/layoutcode string us" | debconf-set-selections && \
    echo "keyboard-configuration keyboard-configuration/variantcode string" | debconf-set-selections && \
    apt-get install -y \
    keyboard-configuration 

RUN apt-get install -y \
    ros-humble-joy ros-humble-teleop-twist-joy \
    ros-humble-teleop-twist-keyboard ros-humble-laser-proc 

RUN apt-get install -y  python3-colcon-common-extensions

# install rviz2 rqt-graph
RUN apt-get install -y ros-humble-rviz2 ros-humble-rqt-graph

# install gazebo
RUN apt-get install -y ros-humble-gazebo-*

# install Cartographer
RUN apt-get install -y \
    ros-humble-cartographer \
    ros-humble-cartographer-ros

# install navigation2
RUN apt-get install -y \
    ros-humble-navigation2 \
    ros-humble-nav2-bringup

# or install desktop full
# RUN apt-get install -y  ros-humble-desktop-full
    

RUN rm -rf /var/lib/apt/lists/*

# build turtlebot3_simulations
RUN mkdir -p ~/turtlebot3_ws/src/ \
    && cd ~/turtlebot3_ws/src/ \
    && git clone -b humble https://github.com/ROBOTIS-GIT/DynamixelSDK.git \
    && git clone -b humble https://github.com/ROBOTIS-GIT/turtlebot3_msgs.git \
    && git clone -b humble https://github.com/ROBOTIS-GIT/turtlebot3.git \
    && git clone -b humble https://github.com/ROBOTIS-GIT/turtlebot3_simulations.git \
    && /bin/bash -c "source /opt/ros/humble/setup.bash && cd ~/turtlebot3_ws && colcon build --symlink-install "


RUN mkdir /var/run/sshd


# permit ssh root login
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

COPY entrypoint.sh /root/entrypoint.sh
COPY start_sim.py /root/start_sim.py

# 
EXPOSE 22


ENTRYPOINT ["bash","/root/entrypoint.sh"]

