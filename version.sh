#!/bin/zsh
SCRIPT_DIR=${0%/*}
echo
echo -e "script directory is \e[1m$SCRIPT_DIR\e[0m"
echo
POM_VERSION=$(mvn -B -f $SCRIPT_DIR/maven-multi-module/pom.xml help:evaluate -Dexpression=project.version -q -DforceStdout)
POM_PROJECT=$(mvn -B -f $SCRIPT_DIR/maven-multi-module/pom.xml help:evaluate -Dexpression=project.artifactId -q -DforceStdout)
echo "project \e[1m$POM_PROJECT\e[0m version is \e[1m$POM_VERSION\e[0m"