#!/bin/zsh

function prop {
    grep "${1}" ${CONF_FILE} | cut -d'=' -f2
}

CONF_FILE="$HOME/.testcontainers.properties"
TEST_CONTAINERS_VALUE=$(prop 'testcontainers.reuse.enable')

if [[ -f "$CONF_FILE" ]]
then
    echo
    echo "test containers configuration file \e[1m${CONF_FILE}\e[0m found"
else
    echo
    echo "test containers configuration file \e[1m${CONF_FILE}\e[0m not found"
    echo
    echo "writing file \e[1m${CONF_FILE}\e[0m with property \e[1mtestcontainers.reuse.enable = true\e[0m"
    echo "testcontainers.reuse.enable=true" > $CONF_FILE
fi

if [[ $TEST_CONTAINERS_VALUE == true ]]
then
    echo
    echo "test containers conf property \e[1mtestcontainers.reuse.enable\e[0m found with value \e[1m$TEST_CONTAINERS_VALUE\e[0m"
else 
    echo "test containers conf property \e[1mtestcontainers.reuse.enable\e[0m not found (or false): you have to set it with value 'true'"
    exit -1
fi
