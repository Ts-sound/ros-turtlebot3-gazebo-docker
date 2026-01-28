docker run -itd --privileged --shm-size=1g  --ulimit memlock=-1 --ulimit stack=67108864 --name sim -p 2202:22 ros2-humble-turtlebot3-sim /bin/bash -c "service ssh start && /bin/bash"
