#!/bin/bash
POM_VERSION=$(mvn -B --settings ./.github/workflows/settings.xml -f ./maven-multi-module/pom.xml help:evaluate -Dexpression=project.version -q -DforceStdout)
echo version is $POM_VERSION
TAG="v$POM_VERSION"
echo tag is $TAG
TITLE="release$POM_VERSION"
echo title is $TITLE
gh release create $TAG --target main --title $TITLE --notes "released from cli"