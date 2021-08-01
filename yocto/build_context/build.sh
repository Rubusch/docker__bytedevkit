#!/bin/bash -e

MY_USER="$(whoami)"
MY_HOME="/home/${MY_USER}"
SSH_DIR="${MY_HOME}/.ssh"
SSH_KNOWN_HOSTS="${SSH_DIR}/known_hosts"
YOCTO_BRANCH="dunfell"
YOCTO_DIR="${MY_HOME}/poky"
BYTEDEVKIT_DIR="${YOCTO_DIR}/bytedevkit-stm32mp1/3.2"
BUILD_DIR="${YOCTO_DIR}/build"

## permissions
for item in "${YOCTO_DIR}" "${SSH_DIR}"; do
    if [ ! "${MY_USER}" == "$( stat -c %U ${item} )" ]; then
        ## may take some time
        sudo chown "${MY_USER}:${MY_USER}" -R ${item}
    fi
done

## ssh known_hosts
touch ${SSH_KNOWN_HOSTS}
for item in "github.com" "bitbucket.org"; do
    if [ "" == "$( grep ${item} -r ${SSH_KNOWN_HOSTS} )" ]; then
        ssh-keyscan "${item}" >> "${SSH_KNOWN_HOSTS}"
    fi
done

## initial clone
FIRST="$(ls -A "${YOCTO_DIR}")"
if [ -z "${FIRST}" ]; then
    mkdir -p "${BYTEDEVKIT_DIR}"
    cd "${BYTEDEVKIT_DIR}"
    repo init -u https://github.com/bytesatwork/bsp-platform-st.git -b gatesgarth
    repo sync
    repo start work --all
fi

## source environment
cd "${BYTEDEVKIT_DIR}"
MACHINE=bytedevkit-stm32mp1 DISTRO=poky-bytesatwork EULA=1 . setup-environment build

## parallelize
export PARALLEL_MAKE="-j $(nproc)"
export BB_NUMBER_THREADS="$(nproc)"

## build
bitbake bytesatwork-minimal-image $@

## find output at
## ~/poky/bytedevkit-stm32mp1/3.2/build/tmp/deploy/images/bytedevkit-stm32mp1

echo "READY."
echo
