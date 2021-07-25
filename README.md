[![CircleCI](https://circleci.com/gh/Rubusch/docker__bytedevkit.svg?style=shield)](https://circleci.com/gh/Rubusch/docker__bytedevkit)
[![License: GPL v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0.html)


# Docker Container for my Bytedevkit


## References

https://bytewiki.readthedocs.io/en/latest/yocto/3.2/bytedevkit-stm32mp1.html


## Tools Needed

```
$ sudo curl -L "https://github.com/docker/compose/releases/download/1.28.6/docker-comp\
ose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
$ sudo chmod a+x /usr/local/bin/docker-compose
```

NB: Where 1.28.6 is the latest version (currently not supported by devian/ubuntu package management)  


## Build


```
$ cd ./yocto
$ docker-compose up
docker $> build.sh
```


## Usage

In case of a re-build, make sure to clean sufficiently before  

```
$ cd ./docker
$ docker-compose -f ./docker-compose.yml run --rm bytedevkit /bin/bash
```

**yocto SDK** - Inside the **same** session, you can compile as follows.  
