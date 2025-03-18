# pull image
FROM docker.1ms.run/library/ros:noetic-ros-base

# install deb
RUN apt-get update && apt-get install -y \
    openssh-server vim zip git screen openssh-server

# set keyboard
RUN echo "keyboard-configuration keyboard-configuration/layoutcode string us" | debconf-set-selections && \
    echo "keyboard-configuration keyboard-configuration/variantcode string" | debconf-set-selections && \
    apt-get install -y \
    keyboard-configuration 

RUN apt-get install -y \
    ros-noetic-joy ros-noetic-teleop-twist-joy \
    ros-noetic-teleop-twist-keyboard ros-noetic-laser-proc 

RUN apt-get install -y \
    ros-noetic-rgbd-launch ros-noetic-rosserial-arduino \
    ros-noetic-rosserial-python ros-noetic-rosserial-client \
    ros-noetic-rosserial-msgs ros-noetic-amcl ros-noetic-map-server \
    ros-noetic-move-base ros-noetic-urdf ros-noetic-xacro \
    ros-noetic-compressed-image-transport ros-noetic-rqt* ros-noetic-rviz \
    ros-noetic-gmapping ros-noetic-navigation ros-noetic-interactive-markers 

RUN apt-get install -y \
    ros-noetic-dynamixel-sdk ros-noetic-turtlebot3-msgs ros-noetic-turtlebot3 \
    ros-noetic-gazebo-ros ros-noetic-gazebo-ros-pkgs ros-noetic-gazebo-ros-control


    

RUN rm -rf /var/lib/apt/lists/*

# build turtlebot3_simulations
RUN mkdir -p ~/catkin_ws/src/ \
    && cd ~/catkin_ws/src/ \
    && git clone -b melodic-devel https://github.com/ROBOTIS-GIT/turtlebot3_simulations.git \
    && /bin/bash -c "source /opt/ros/noetic/setup.bash && cd ~/catkin_ws && catkin_make "


RUN mkdir /var/run/sshd


# permit ssh root login
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

COPY entrypoint.sh /root/entrypoint.sh
COPY start_sim.py /root/start_sim.py

# 
EXPOSE 22


ENTRYPOINT ["bash","/root/entrypoint.sh"]

