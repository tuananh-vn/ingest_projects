#!/bin/bash

prefix='datalabframework environment: '

# check if docker and docker-compose are installed
if ! which docker > /dev/null
then
  echo $prefix docker executable not found
  exit 1
fi

if ! which docker-compose > /dev/null
then
  echo $prefix docker-compose executable not found
  exit 1
fi

# first argument is empty, or incorrect # of arguments hint for help
if [ $# -eq 0 ] || [ "$4" ]; then
  echo $prefix "type '$0 -h' for help"
  exit 1
fi

ROOTPATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )"/.. >/dev/null && pwd )"

# first argument is -h or empty, display help
case $1 in
  -h)
    echo $prefix Help:
    echo "   "  "'$0 -h' for help"
    echo "   "  "'$0 [--up|--down|--list] <compose-group>' brings up/down/list compose groups"
    retval=0
    ;;
  --list)
    echo $prefix
    echo compose groups:
    for fn in $(find  $ROOTPATH/docker/compose -name docker-compose.yml); do
      pathname=$(dirname $fn)
      prefix=$ROOTPATH/docker/compose/
      groupname=${pathname#$prefix}
      echo "   - $groupname"
    done
    echo
    echo "Hint:"
    echo "use 'sudo lsof -n -i :<port number> | grep LISTEN'"
    echo "to check which process is using the given <port number>"
    retval=0
    ;;
  --up)
    composefile=$ROOTPATH/docker/compose/$2/docker-compose.yml
    if [ -e $composefile ]
    then
      REGISTRY=${REGISTRY:='localhost:5000'} \
      USERNAME=${USERNAME:=${USER}} \
      IMAGENAME=${IMAGENAME:=datalabframework} \
      IMAGETAG=${IMAGETAG:=latest} \
      PROJECTDIR=${PROJECTDIR:=$(pwd)} \
      docker-compose -f $composefile up -d
      retval=0
    else
      echo $prefix compose group \'$2\' not found
      retval=1
    fi
    ;;
  --interactive)
    composefile=$ROOTPATH/docker/compose/$2/docker-compose.yml
    if [ -e $composefile ]
    then
      if [ "$2" = "jupyter" ]
      then
        for I in 1 2 3
        do
          log=$(docker-compose -f $composefile logs jupyter 2>&1 | grep ?token= | head -n 1)
          token=$(echo $log | sed '/token=/!{q100}; {s/.*token=\(.*\)/\1/}')
          if [ ! "$log" = "$token" ]
          then
            sensible-browser http://localhost:8888/lab?token=${token}
            break;
          else
            sleep 5
          fi
        done
      fi
      retval=0
    else
      echo $prefix compose group \'$2\' not found
      retval=1
    fi
    ;;
  --exec)
    composefile=$ROOTPATH/docker/compose/$2/docker-compose.yml
    if [ -e $composefile ]
    then
        REGISTRY=${REGISTRY:='localhost:5000'} \
        USERNAME=${USERNAME:=${USER}} \
        IMAGENAME=${IMAGENAME:=datalabframework} \
        IMAGETAG=${IMAGETAG:=latest} \
        PROJECTDIR=${PROJECTDIR:=$(pwd)} \
        docker-compose -f $composefile exec $2 /bin/bash -c "$3"
        #'cd /home/$NB_USER/demo/test && make'
    fi
    ;;
  --down)
    composefile=$ROOTPATH/docker/compose/$2/docker-compose.yml
    if [ -e $composefile ]
    then
      REGISTRY=${REGISTRY:='localhost:5000'} \
      USERNAME=${USERNAME:=${USER}} \
      IMAGENAME=${IMAGENAME:=datalabframework} \
      IMAGETAG=${IMAGETAG:=latest} \
      PROJECTDIR=${PROJECTDIR:=$(pwd)} \
      docker-compose -f $composefile down

      REGISTRY=${REGISTRY:='localhost:5000'} \
      USERNAME=${USERNAME:=${USER}} \
      IMAGENAME=${IMAGENAME:=datalabframework} \
      IMAGETAG=${IMAGETAG:=latest} \
      PROJECTDIR=${PROJECTDIR:=$(pwd)} \
      docker-compose -f $composefile rm
      retval=0
    else
      echo $prefix compose group \'$2\' not found
      retval=1
    fi
    ;;
  *)
    echo $prefix "wrong argument $1"
    echo $prefix "type '$0 -h' for help"
    retval=1
    ;;
esac

exit $retval
