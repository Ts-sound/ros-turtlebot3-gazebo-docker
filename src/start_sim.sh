#!/bin/bash
# deprecated

SOURCE_ENV="source ~/.bashrc && source ~/catkin_ws/devel/setup.bash && export TURTLEBOT3_MODEL=waffle_pi"



#
pkill screen

# start roscore
screen -LdmS roscore && screen -S  roscore  -X stuff "roscore\n"

screen -LdmS world && screen -S  world  -X stuff $SOURCE_ENV" && roslaunch turtlebot3_gazebo turtlebot3_house.launch \n" 

screen -LdmS slam && screen -S  slam  -X stuff $SOURCE_ENV" && roslaunch turtlebot3_slam turtlebot3_slam.launch slam_methods:=gmapping \n" 

screen -LdmS key && screen -S  key  -X stuff $SOURCE_ENV" && roslaunch turtlebot3_teleop turtlebot3_teleop_key.launch \n" 