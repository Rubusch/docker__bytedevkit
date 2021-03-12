FROM ubuntu:20.04
MAINTAINER Lothar Rubusch <lotophagon@bytesatwork.ch>
WORKDIR /root
ENV DEBIAN_FRONTEND=noninteractive


################################################################################
## the USER is needed to make it available as --build-arg
## in case docker complains for a not set USER, perhaps you forgot to use --build-arg USER=$USER
ARG USER="${USER}"

## the yocto branch
ARG BRANCH_YOCTO="warrior"
ARG YOCTOVERSION="2.7"

#ARG BRANCH_YOCTO="dunfell"
#ARG YOCTOVERSION="3.1"

ARG YOCTODIR="/home/user/workdir/bytedevkit/${YOCTOVERSION}"


################################################################################
## set up apt fully functional
RUN apt-get update && apt-get upgrade -y && apt-get autoremove -y --purge

RUN apt-get install -y  \
    apt-utils

RUN apt-get install -y  \
    build-essential \
    chrpath \
    diffstat \
    gawk \
    libncurses5-dev \
    texinfo \
    zlib1g-dev \
    bison \
    flex \
    binutils \
    unzip \
    python \
    bzip2 \
    libssl-dev \
    locales \
    libsdl1.2-dev \
    xterm \
    bc \
    cpio \
    rsync \
    wget \
    git-core \
    dosfstools

## (opt) tools for debugging and working, e.g. X11-apps for testing the xserver via xclock
RUN apt-get install -y   \
    vim \
    screen \
    minicom \
    sudo \
    x11-apps



################################################################################
## locale settings
RUN locale-gen en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8



################################################################################
## install repo

RUN mkdir -p /usr/local/
RUN cd /usr/local && git clone -b stable https://github.com/Rubusch/repo.git
RUN cp -arf /usr/local/repo/repo /usr/bin/repo
RUN chmod a+x /usr/bin/repo


################################################################################
## setup user and run stuff under user
RUN useradd "$USER" -m --password "$USER"
RUN usermod -a -G sudo "$USER"
RUN sed -i '/%sudo/s/.*/%sudo   ALL=NOPASSWD: ALL/' /etc/sudoers



################################################################################
## get sources

RUN mkdir -p ${YOCTODIR}
RUN cd ${YOCTODIR} && repo init -u https://github.com/bytesatwork/bsp-platform-st.git -b ${BRANCH_YOCTO}

# TODO 
#RUN sudo cp -f ${YOCTODIR}/.repo/repo/repo /usr/bin/repo

RUN cd ${YOCTODIR} && repo sync


################################################################################
## command mode
COPY build.sh /usr/local/bin/build.sh
CMD ["/bin/bash", "/usr/local/bin/build.sh"]
