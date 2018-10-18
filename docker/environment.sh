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

# first argument is empty hint for help
if [ $# -eq 0 ]; then
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
    for COMPOSEGROUP in ${@:2}
    do
      composefile=$ROOTPATH/docker/compose/${COMPOSEGROUP}/docker-compose.yml
      echo Bringing up: $COMPOSEGROUP
      if [ -e $composefile ]
      then
        USERNAME=${USERNAME:=${USER}} \
        WORKDIR=${WORKDIR:=$(pwd)} \
        DEMO=${DEMO:=minimal} \
        docker-compose -f $composefile up -d
        retval=0
      else
        echo $prefix compose group \'${COMPOSEGROUP}\' not found
        retval=1
      fi
    done
    ;;
  --interactive)
    composefile=$ROOTPATH/docker/compose/$2/docker-compose.yml
    if [ -e $composefile ]
    then
      if [ "$2" = "jupyter-dlf" ] || [ "$2" = "jupyter-dev" ]
      then
        # wait up to 30 secs
        for I in 1 2 3 4 5 6
        do
          log=$(docker-compose -f $composefile logs 2>&1 | grep ?token= | head -n 1)
          token=$(echo $log | sed '/token=/!{q100}; {s/.*token=\(.*\)/\1/}')
          if [ ! "$log" = "$token" ]
          then
            sensible-browser http://localhost:8888/lab?token=${token}
            break;
          else
            echo "waiting for jupyter service to start ..."
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
    running=$(docker ps -qf name=$2)

    if [ "$2" = "jupyter-dlf" ] || [ "$2" = "jupyter-dev" ]
    then
      servicename=jupyter
    else
      servicename=$2
    fi

    if [ -e $composefile ] && [ -n "$running" ]
    then
      USERNAME=${USERNAME:=${USER}} \
      WORKDIR=${WORKDIR:=$(pwd)} \
      DEMO=${DEMO:=minimal} \
      docker-compose -f $composefile exec ${servicename} /bin/bash -c "$3"
    else
      echo "service $servicename: not found or not running"
    fi
    ;;
  --down)
    for COMPOSEGROUP in ${@:2}
    do
      composefile=$ROOTPATH/docker/compose/$COMPOSEGROUP/docker-compose.yml
      echo Bringing down: $COMPOSEGROUP
      if [ -e $composefile ]
      then
        USERNAME=${USERNAME:=${USER}} \
        WORKDIR=${WORKDIR:=$(pwd)} \
        DEMO=${DEMO:=minimal} \
        docker-compose -f $composefile down

        USERNAME=${USERNAME:=${USER}} \
        WORKDIR=${WORKDIR:=$(pwd)} \
        DEMO=${DEMO:=minimal} \
        docker-compose -f $composefile rm
        retval=0
      else
        echo $prefix compose group \'$COMPOSEGROUP\' not found
        retval=1
      fi
    done
    ;;
  *)
    echo $prefix "wrong argument $1"
    echo $prefix "type '$0 -h' for help"
    retval=1
    ;;
esac

exit $retval
