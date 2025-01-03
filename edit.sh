#!/bin/zsh

SCRIPT_DIR=${0%/*}
echo
echo -e "script directory is \e[1m$SCRIPT_DIR\e[0m"
echo

echo -e "starting idea from: \e[1m$SCRIPT_DIR/maven-multi-module/\e[0m"
idea $SCRIPT_DIR/maven-multi-module/.

echo
