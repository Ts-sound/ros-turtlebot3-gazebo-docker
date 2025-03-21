# ros-turtlebot3-gazebo-docker
ROS docker image using the turtlebot3 and Gazebo simulation

# 添加docker镜像
> 在国内无法访问 dockerhub, 需要添加相应的镜像站； 将以下内容添加到 /etc/docker/daemon.json：
```json
{
    "registry-mirrors": [
        "https://docker.1ms.run",
        "https://docker.xuanyuan.me",
    ]
}
```

```bash
# restart docker
sudo systemctrl daemon-reload
sudo systemctrl restart docker
```

> dockerfile用的镜像是docker.1ms.run，可根据情况进行替换；

# build docker
```bash
cd src && sudo ./build.sh
```

# start docker
```bash
cd src && sudo ./start_docker.sh
```

# start sim

```bash
cd ~ && python3 start_sim.py
```

> 使用 mobaxterm 登录, 用户名root,端口2202, ip 使用ifconfig 检查；
> mobaxterm 带有 xserver 可以直接显示图像，可使用其他GUI显示工具； 

> 第一次启动时，由于仿真环境第一次启动较慢，slam仿真可能启动不成功，等仿真环境加载完成，通过 screen -x slam 进入对应终端，重启roslaunch 对应指令。

> 通过 screen -x key 进入对应终端，可以通过 wasd 键 控制小车行走。

# screen 简单使用
查看所以会话：screen -ls 
进入会话：screen -x [session_name]
分离会话：CTRL+A , 松开，按D ，可以分离会话。会话在后台运行。

kill 所以会话： pkill screen && screen -wipe


# ref
https://emanual.robotis.com/docs/en/platform/turtlebot3/quick-start/
docker version : 27.2.0
ros : noetic