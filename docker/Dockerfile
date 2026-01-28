# pull image
FROM althack/ros2:humble-base
# FROM osrf/ros:humble-desktop-full

# install deb
RUN apt update && apt install -y \
    openssh-server vim zip git screen openssh-server

# set keyboard
RUN echo "keyboard-configuration keyboard-configuration/layoutcode string us" | debconf-set-selections && \
    echo "keyboard-configuration keyboard-configuration/variantcode string" | debconf-set-selections && \
    apt install -y \
    keyboard-configuration 

RUN apt install -y \
    ros-humble-joy ros-humble-teleop-twist-joy \
    ros-humble-teleop-twist-keyboard ros-humble-laser-proc 

RUN apt install -y  python3-colcon-common-extensions

# install rviz2 rqt-graph
RUN apt install -y ros-humble-rviz2 ros-humble-rqt-graph

# install gazebo
RUN apt install -y ros-humble-gazebo-*

# install Cartographer
RUN apt install -y \
    ros-humble-cartographer \
    ros-humble-cartographer-ros

# install navigation2
RUN apt install -y \
    ros-humble-navigation2 \
    ros-humble-nav2-bringup

# or install desktop full
# RUN apt install -y  ros-humble-desktop-full
    
# clean
RUN rm -rf /var/lib/apt/lists/*

# permit ssh root login
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# 
RUN /bin/bash -c "echo 'export ROS_DOMAIN_ID=30 #TURTLEBOT3' >> ~/.bashrc \
    && echo 'source /usr/share/gazebo/setup.sh' >> ~/.bashrc \
    && echo 'source /opt/ros/humble/setup.bash' >> ~/.bashrc \
    && source ~/.bashrc "

# build turtlebot3
COPY ros-ws /root/ros-ws

RUN /bin/bash -c " cd /root/ros-ws \
 && ./build_turtlebot3_sim.sh "

# 
EXPOSE 22

