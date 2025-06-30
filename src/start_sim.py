import os

SOURCE_ENV="source ~/.bashrc &&  source ~/turtlebot3_ws/install/setup.bash && export TURTLEBOT3_MODEL=waffle_pi && "

#
os.system("pkill screen")

def screen_start(name,cmd):
    return os.system('screen -LdmS '+name+' && screen -S  '+name+'  -X stuff "'+SOURCE_ENV+cmd+'\n"')

# start 
screen_start("world","ros2 launch turtlebot3_gazebo turtlebot3_house.launch.py")
screen_start("slam","ros2 launch turtlebot3_cartographer cartographer.launch.py use_sim_time:=True")
screen_start("key","ros2 run turtlebot3_teleop teleop_keyboard")
