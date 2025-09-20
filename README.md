# ros-turtlebot3-gazebo-docker

使用 turtlebot3 & Gazebo 配置了一个可以 方便启动的ros2 humble slam仿真环境（docker容器）。
![gazebo_sim](./assets/gazebo_sim.png)

## 编译docker镜像

```bash
cd src && ./build.sh
```

* 编译成功后，使用 `sudo docker images`查看编译好的镜像，如下：

```bash
~$ sudo docker images
REPOSITORY                   TAG                 IMAGE ID       CREATED             SIZE
ros2-humble-turtlebot3-sim   latest              9d824a494dd1   19 hours ago        4.55GB

```

* 由于国内网络的问题，从dockerhub拉取原始镜像大概率会失败，需要通过镜像站或代理，这个自行搜索可用的镜像站；
* 我这使用github Action 于编译好了镜像，也可以直接下载导入使用：
  * Release 地址：https://github.com/Ts-sound/ros-turtlebot3-gazebo-docker/releases/tag/v0.0.4
  * 文件 ： https://github.com/Ts-sound/ros-turtlebot3-gazebo-docker/releases/download/v0.0.4/ros2-humble-turtlebot3-sim-v0.0.4.tar.gz
  * 使用docker导入镜像：```sudo docker < ros2-humble-turtlebot3-sim-v0.0.4.tar.gz```
* 导入成功后，使用 `sudo docker images` 查看。

### Dockerfile说明

```Dockerfile
# 使用 ROS2 Humble 基础镜像作为构建起点
FROM althack/ros2:humble-base

# 更新软件包索引并安装基础工具
# openssh-server: 提供 SSH 远程访问能力
# vim/zip/git/screen: 开发调试常用工具
RUN apt update && apt install -y \
    openssh-server vim zip git screen

# 设置美式键盘布局
RUN echo "keyboard-configuration keyboard-configuration/layoutcode string us" | debconf-set-selections && \
    echo "keyboard-configuration keyboard-configuration/variantcode string" | debconf-set-selections && \
    apt install -y keyboard-configuration 

# joy: 游戏手柄控制节点
# teleop-twist-joy/keyboard: 键盘/手柄遥操作
# laser-proc: 激光雷达数据处理工具
RUN apt install -y \
    ros-humble-joy ros-humble-teleop-twist-joy \
    ros-humble-teleop-twist-keyboard ros-humble-laser-proc 

# 安装 Colcon 构建系统（ROS2 标准构建工具）
RUN apt install -y python3-colcon-common-extensions

# 安装可视化工具
# rviz2: ROS 可视化工具
# rqt-graph: 节点拓扑关系可视化
RUN apt install -y ros-humble-rviz2 ros-humble-rqt-graph

# 安装 Gazebo 仿真环境及其 ROS 集成
# ros-humble-gazebo-*: 包含所有 Gazebo 相关插件和接口
RUN apt install -y ros-humble-gazebo-*

# 安装 SLAM 工具 Cartographer
RUN apt install -y \
    ros-humble-cartographer \
    ros-humble-cartographer-ros

# 安装导航系统 Navigation2
RUN apt install -y \
    ros-humble-navigation2 \
    ros-humble-nav2-bringup

# 清理 apt 缓存以减小镜像体积
RUN rm -rf /var/lib/apt/lists/*

# 创建 SSH 服务运行目录（sshd 需要此目录）
RUN mkdir /var/run/sshd

# 修改 SSH 配置：
# 1. 允许 root 通过密码登录
# 2. 启用密码认证（默认禁用）
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# 复制启动脚本到容器内
# entrypoint.sh: 容器初始化脚本
# start_sim.py: 仿真环境启动脚本（可选）
COPY entrypoint.sh /root/entrypoint.sh
COPY start_sim.py /root/start_sim.py

# 声明容器运行时暴露的端口（SSH 默认端口）
EXPOSE 22

# 设置容器入口点脚本，在启动时自动执行
ENTRYPOINT ["bash","/root/entrypoint.sh"]
```

## docker镜像启动

```bash
cd src && sudo ./start_docker.sh
```

* `start_docker.sh` 文件说明：
  * 其中 `ROOT_PASSWD=1` 密码存在一定的 **安全风险** ，请进入容器后修改密码，ssh也可以禁用root用户登录并设置密钥登陆。
  * 由于我是在自己电脑里虚拟机里面运行的docker,网络环境有隔离，外部无法访问，为了使用方便就按简单的方式来。

```bash
docker run -itd \                          # 后台交互模式
  -e ROOT_PASSWD=1 \                       # 传递root密码环境变量（需在容器内处理）
  --privileged \                           # 赋予特权（访问设备等）
  --shm-size=1g \                          # 共享内存1GB（Gazebo等需要）
  --ulimit memlock=-1 \                    # 不限制锁定内存
  --ulimit stack=67108864 \                # 设置栈大小为64MB
  --name sim \                             # 容器名称
  -p 2202:22 \                             # 端口映射：宿主机2202->容器22
  ros2-humble-turtlebot3-sim \             # 镜像名称
  /bin/bash -c "service ssh start && /bin/bash"  # 启动命令：启动SSH并进入bash
```

* 也可以添加 `-v /home/t/Desktop/workspace/git-repo:/root/ws` ，将自己的工作空间

## ssh 登录容器

* 由于通过 `-p 2202:22` 我们把ssh端口映射到虚拟机的 `2202` 端口，可以通过ssh进入容器：

```powershell
PS C:\Users\tong> ssh root@192.168.129.152 -p 2202
root@192.168.129.152's password:
```

* 输入默认密码 `1` , 就可以进入了。
* 这里推荐使用 mobaxterm 工具，一个windows上非常好用且免费的远程软件（X11 server, SSH , ftp , ... ）。
* 后面 gazebo,rviz 图像转发直接使用 mobaxterm自带的x11 server, 不然还要配置其他的图像转发工具。
* mobaxterm官方网站： https://mobaxterm.mobatek.net/

## 启动仿真环境

### 编译 turtlebot3_simulations 组件

* git clone 时要包含子模块克隆：`git clone -b ros2-humble --recurse-submodules https://github.com/Ts-sound/ros-turtlebot3-gazebo-docker.git`
* 仿真环境工作空间为 `ros-ws`,其中 `build_turtlebot3_sim.sh` 是用来编译 turtlebot3_simulations 相关组件的。
* 将 `ros-ws` 映射到容器 `~/ros-ws` 目录，或直接复制进去，
* 容器里编译 turtlebot3_simulations 组件 ：`cd ~/ros-ws && source /opt/ros/humble/setup.bash &&  colcon build --symlink-install`

### 启动

* 这里通过 python 使用screen 写了个一键启动脚本 `start_sim.py`
* 运行：

```bash
cd ~/ros-ws && python3 start_sim.py
```

* 查看screen会话：

```bash
~# screen -ls
There are screens on:
        7609.key        (09/20/2025 04:03:15 AM)        (Detached)
        7592.world      (09/20/2025 04:03:15 AM)        (Detached)
        7598.slam       (09/20/2025 04:03:15 AM)        (Detached)
3 Sockets in /run/screen/S-root.
```

* 其中：
  * key ：启动 `ros2 run turtlebot3_teleop teleop_keyboard` ,用来通过键盘控制仿真小车运动。
  * world ：启动 `ros2 launch turtlebot3_gazebo turtlebot3_house.launch.py` , gazebo 仿真。
  * slam ：启动 `ros2 launch turtlebot3_cartographer cartographer.launch.py use_sim_time:=True` ， 启动 cartographer node 和 rviz。

* 效果如下：
![gazebo_sim](./assets/gazebo_sim.png)

* 后面就可以根据自己的需求修改 cartographer组件 源码进行测试，或者添加一些其他的 slam 组件进行使用。
* gazebo 仿真相对来说 对电脑的要求不是很高，我的测试机 CPU是 i5-10210U，内存16G的轻薄本，就可以正常跑。

## repo

* https://github.com/Ts-sound/ros-turtlebot3-gazebo-docker
* 参考： https://emanual.robotis.com/docs/en/platform/turtlebot3/quick-start/
