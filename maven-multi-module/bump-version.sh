#!/bin/zsh

usage() {
    echo -e "script to update poms version"
    echo -e " use \e[1m-c\e[0m to enable git commit and push"
    echo -e " use \e[1m-s\e[0m to switch to snapshot version"
    exit 1
}

while getopts 'csh' arg; do
    case $arg in
        c) GIT_PUSH=true;;
        s) SNAPSHOT=true;;
        h) HELP=true
    esac
done
if [[ -v HELP ]]; then
    usage
fi
if [[ -v SNAPSHOT ]]; then
    echo ""
    echo -e "move or update snapshot maven release"
    mvn -q versions:set -DnextSnapshot -DgenerateBackupPoms=false
    ../version.sh
    if [[ -v GIT_PUSH ]]; then
        echo -e "commit and push maven poms to git"
        echo ""
        git add . ; git commit -m "bump to snapshot" ; git push
    else
        echo -e "git commit and push is disabled: use \e[1m-c\e[0m to enable it"
        echo ""
    fi
else
    echo ""
    echo -e "move or update final maven release"
    POM_VERSION=$(mvn -B help:evaluate -Dexpression=project.version -q -DforceStdout)
    if [[ "$POM_VERSION" == *"SNAPSHOT"* ]]; then
        mvn -q versions:set -DremoveSnapshot -DgenerateBackupPoms=false
    else
        mvn -q versions:set -DgenerateBackupPoms=false
    fi
    ../version.sh
    if [[ -v GIT_PUSH ]]; then
        echo -e "commit and push maven poms to git"
        echo ""
        git add . ; git commit -m "bump to final" ; git push
    else
        echo -e "git commit and push is disabled: use \e[1m-c\e[0m to enable it"
        echo ""
    fi
fi
