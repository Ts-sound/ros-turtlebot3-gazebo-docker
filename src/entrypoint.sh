#!/bin/bash

# 
echo 'root:1' | chpasswd
if [-n "$ROOT_PASSWD"]; then
    echo 'root:$ROOT_PASSWD' | chpasswd
fi


/sbin/sshd -d


# setup env 
echo "source /opt/ros/noetic/setup.bash" >> /root/.bashrc