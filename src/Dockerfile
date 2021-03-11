FROM osrf/ros:kinetic-desktop-full

# nvidia-docker hooks
# use GPU
#LABEL com.nvidia.volumes.needed="nvidia_driver"
#ENV PATH /usr/local/nvidia/bin:${PATH}
#ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64:${LD_LIBRARY_PATH}

# Update repos and install some packages
RUN apt update && \
    apt upgrade -y && \
    apt install -y --no-install-recommends apt-utils

RUN apt install -y \
    python-catkin-tools \
    ros-kinetic-desktop-full \
    software-properties-common \
    git \
    sudo \
    unzip \
    vim \ 
    wget

RUN apt install -y \
    ros-kinetic-ros-control \
    ros-kinetic-ros-controllers \
    ros-kinetic-move-base \
    ros-kinetic-jsk-visualization \
    ros-kinetic-robot-localization \
    ros-kinetic-gmapping \
    ros-kinetic-amcl \
    ros-kinetic-map-server \
    ros-kinetic-joy \
    ros-kinetic-joystick-drivers \
    ros-kinetic-gazebo-ros-control \
    ros-kinetic-ar-track-alvar \
    ros-kinetic-rosserial \
    zsh \
    bc

# 操作感びみょかったからtmux追加


# Install gazebo7 from osrf
# See https://goo.gl/BqzTNk for detail
WORKDIR /tmp/
RUN sh -c 'echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-stable.list'
RUN wget http://packages.osrfoundation.org/gazebo.key -O - | sudo apt-key add -
RUN apt update && \
    apt install -y gazebo7 libignition-math2-dev


# Arguments picked from the command line!
ARG user
ARG uid
ARG gid

#Add new user with our credentials
# エントリーポイントへ移行
# userの設定がどうなるかわからん
ENV USERNAME ${user}
RUN useradd -m $USERNAME && \
        echo "$USERNAME:$USERNAME" | chpasswd && \
        usermod --shell /bin/zsh $USERNAME && \
        echo "%${user}    ALL=(ALL)   NOPASSWD:    ALL" >> /etc/sudoers.d/${user} && \
        usermod -aG sudo $USERNAME && \
        chmod 0440 /etc/sudoers.d/${user} && \
        usermod  --uid ${uid} $USERNAME && \
        groupmod --gid ${gid} $USERNAME

USER ${user}

# COPY zshrc
COPY ./config/.zshrc /home/$USERNAME/
COPY ./config/90-usb-serial-devices.rules /etc/udev/rules.d/

RUN mkdir -p /home/${user}/.cache/shell

# Create catkin workspace
RUN mkdir -p /home/${user}/catkin_ws/src

WORKDIR /home/${user}/catkin_ws

# デフォルトシェルをzshへ変更する
# なんかエラー出てる
# あとOpenGLエラー消えてない
SHELL ["/usr/bin/zsh", "-c"]
RUN source /opt/ros/kinetic/setup.zsh && catkin build

# catkin build したあとに自動でパス登録するかどうか一考

ENTRYPOINT ["/bin/zsh"]
