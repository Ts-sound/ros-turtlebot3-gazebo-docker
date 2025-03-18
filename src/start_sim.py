import os

SOURCE_ENV="source ~/.bashrc && source ~/catkin_ws/devel/setup.bash && export TURTLEBOT3_MODEL=waffle_pi && "

#
os.system("pkill screen")

def screen_start(name,cmd):
    return os.system('screen -LdmS '+name+' && screen -S  '+name+'  -X stuff "'+SOURCE_ENV+cmd+'\n"')

# start 
screen_start("roscore","roscore")
screen_start("world","roslaunch turtlebot3_gazebo turtlebot3_house.launch")
screen_start("slam","roslaunch turtlebot3_slam turtlebot3_slam.launch slam_methods:=gmapping")
screen_start("key","roslaunch turtlebot3_teleop turtlebot3_teleop_key.launch")
