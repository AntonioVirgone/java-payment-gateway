#!/bin/zsh

while getopts ':dp:' arg; do
  case $arg in
    d) MVN_DEBUG=true;;
    p) HTTP_PORT=$OPTARG;;
  esac
done

SCRIPT_DIR=${0%/*}
printf -- "\n"
printf -- "Hi $USER, the script directory is \033[1m$SCRIPT_DIR\033[0m\n"
printf -- "\n"

SCRIPT_TESTCONTAINERS_CHECK="$SCRIPT_DIR/start_testcontainers_check.sh"
if [ -f "$SCRIPT_TESTCONTAINERS_CHECK" ]
then
    echo "$SCRIPT_TESTCONTAINERS_CHECK exists: run it"
    source $SCRIPT_TESTCONTAINERS_CHECK
    echo
else
    echo "test containers script not found"
    echo
fi

if [[ -v HTTP_PORT ]]; then
  echo -e "listening on provided port \e[1m$HTTP_PORT\e[0m"
  echo
else
  HTTP_PORT=8080
  echo -e "listening on standard port \e[1m$HTTP_PORT\e[0m: use start.sh -p \e[1mport\e[0m to change it"
  echo
fi

if [[ -v MVN_DEBUG ]]; then
  echo -e "starting jvm in remote debug mode"
  echo
else
  MVN_DEBUG=false
  echo -e "jvm remote debug mode is disabled: use start.sh -d to enable it"
  echo
fi

mvn clean compile quarkus:dev -T 1 -Dquarkus.live-reload.url=http://localhost:$HTTP_PORT -Dquarkus.http.port=$HTTP_PORT -f $SCRIPT_DIR/maven-multi-module/pom.xml -Ddebug=$MVN_DEBUG
echo
