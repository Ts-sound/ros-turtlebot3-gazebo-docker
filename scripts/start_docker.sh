#!/bin/bash

# 推荐使用 Docker Compose 启动容器：docker compose up -d
# 此脚本保留向后兼容，功能等同于 docker compose up

docker run -itd --privileged --shm-size=1g  --ulimit memlock=-1 --ulimit stack=67108864 --name sim -p 2202:22 ros2-humble-turtlebot3-sim /bin/bash -c "service ssh start && /bin/bash"
