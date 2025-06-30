#!/bin/bash

# 
echo 'root:1' | chpasswd
if [-n "$ROOT_PASSWD"]; then
    echo 'root:$ROOT_PASSWD' | chpasswd
fi


/sbin/sshd -d


# setup env 
echo 'export ROS_DOMAIN_ID=30 #TURTLEBOT3' >> /root/.bashrc
echo 'source /usr/share/gazebo/setup.sh' >> /root/.bashrc
echo 'source /opt/ros/humble/setup.bash' >> /root/.bashrc
source /root/.bashrc