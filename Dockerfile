FROM ubuntu:xenial

MAINTAINER "Lampoo <yh.zheng@yuneec.com>"
LABEL "version=0.0.4"

# ENV
ENV ROS_DISTRO kinetic
#ENV http_proxy http://10.1.192.48:911
#ENV https_proxy https://10.1.192.48:911
ENV CATKIN_WS /root/idl
#ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# setup sources.list
RUN echo "deb http://packages.ros.org/ros/ubuntu xenial main" > /etc/apt/sources.list.d/ros-latest.list

# setup keys
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 421C365BD9FF1F717815A3895523BAEEB01FA116

# install packages
RUN apt-get update && apt-get install -y --quiet --no-install-recommends \
	build-essential gcc g++ cmake make
	
RUN apt-get update && apt-get install -y --quiet --no-install-recommends \
	libusb-1.0-0-dev

RUN apt-get update && apt-get install -y --quiet --no-install-recommends \
	python-wstool python-catkin-tools

RUN apt-get update && apt-get install -y --quiet --no-install-recommends \
	ros-kinetic-cpp-common ros-kinetic-actionlib ros-kinetic-actionlib-msgs \
	ros-kinetic-bond ros-kinetic-bondcpp ros-kinetic-catkin \
	ros-kinetic-class-loader ros-kinetic-cmake-modules ros-kinetic-gencpp \
	ros-kinetic-geneus ros-kinetic-genlisp ros-kinetic-genmsg \
	ros-kinetic-gennodejs ros-kinetic-genpy ros-kinetic-geometry-msgs \
	ros-kinetic-image-transport ros-kinetic-message-filters ros-kinetic-message-generation \
	ros-kinetic-message-runtime ros-kinetic-nav-msgs ros-kinetic-nodelet \
	ros-kinetic-pluginlib ros-kinetic-rosbag ros-kinetic-rosbag-storage \
	ros-kinetic-rosbuild ros-kinetic-rosclean ros-kinetic-rosconsole \
	ros-kinetic-roscpp ros-kinetic-roscpp-serialization ros-kinetic-roscpp-traits \
	ros-kinetic-rosgraph ros-kinetic-rosgraph-msgs ros-kinetic-roslaunch \
	ros-kinetic-roslib ros-kinetic-roslint ros-kinetic-roslz4 \
	ros-kinetic-rosmaster ros-kinetic-rosout ros-kinetic-rospack \
	ros-kinetic-rosparam ros-kinetic-rospy ros-kinetic-rostest ros-kinetic-rostime \
	ros-kinetic-rostopic ros-kinetic-rosunit ros-kinetic-sensor-msgs \
	ros-kinetic-smclib ros-kinetic-std-msgs ros-kinetic-std-srvs \
	ros-kinetic-tf2 ros-kinetic-tf2-msgs ros-kinetic-tf2-py \
	ros-kinetic-tf2-ros ros-kinetic-tf2-eigen ros-kinetic-tf2-geometry-msgs \
	ros-kinetic-topic-tools ros-kinetic-xmlrpcpp ros-kinetic-mav-comm \
	ros-kinetic-mav-msgs ros-kinetic-image-common ros-kinetic-visualization-msgs \
	ros-kinetic-cv-bridge && rm -rf /var/lib/apt/lists/*

# Install YUNEEC IDL
ADD yuneec_idl.tar.gz /root/idl/install

WORKDIR /root/idl

RUN echo "source $CATKIN_WS/install/setup.bash" >> ~/.bashrc

CMD ["bash"]
