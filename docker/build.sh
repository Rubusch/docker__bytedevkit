#!/bin/bash -e
export USER="$(whoami)"
export MY_HOME="/home/${USER}"

#export YOCTODIR="${MY_HOME}/poky"       

export YOCTOVERSION="2.7"
export YOCTODIR="${MY_HOME}/workdir/bytedevkit/${YOCTOVERSION}"

export BUILDDIR="${YOCTODIR}/build"

## this may take time
sudo chown ${USER}:${USER} -R ${YOCTODIR}

cd ${YOCTODIR}
MACHINE=bytedevkit DISTRO=poky-bytesatwork EULA=1 . setup-environment build

cd $BUILDDIR
bitbake devbase-image-bytesatwork

echo "READY."
echo
