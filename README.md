[![CircleCI](https://circleci.com/gh/Rubusch/docker__bytedevkit.svg?style=shield)](https://circleci.com/gh/Rubusch/docker__bytedevkit)
[![License: GPL v2](https://img.shields.io/badge/License-GPL%20v2-blue.svg)](https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html)


# Build Container

Contains a Dockerfile for building the board support package.  



## Resources

https://bytewiki.readthedocs.io/en/latest/yocto/2.7/bytedevkit.html



## Yocto

Login user: 'root'  
TODO    


### Build

```
$ cd ./docker__yocto/
$ time docker build --build-arg USER=$USER -t rubuschl/bytedevkit:$(date +%Y%m%d%H%M%S) .
```


### Usage

```
$ docker images
    REPOSITORY               TAG                 IMAGE ID            CREATED             SIZE
    rubuschl/bytedevkit      20191104161353      cbf4cb380168        24 minutes ago      10.5GB
    ...

$ docker run --rm -ti --user=$USER:$USER --workdir=/home/$USER -v $PWD/output:/home/$USER/poky/build rubuschl/bytedevkit:20191104161353 /bin/bash

docker$> build.sh
```



