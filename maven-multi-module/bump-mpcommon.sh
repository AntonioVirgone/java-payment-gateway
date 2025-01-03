#!/bin/zsh

VERSION="1.0.0"
usage() {
    echo -e "script to update mpcommon, version ${VERSION}"
    exit 1
}

while getopts 'csh' arg; do
    case $arg in
        h) HELP=true;;
    esac
done
if [[ -v HELP ]]; then
    usage
fi

echo ""
mvn -B -U -ntp -N versions:update-property -Dproperty=version.wise.mp-common
echo ""
mvn -B -U -ntp -N versions:update-parent -DallowSnapshots=false
echo ""
git --no-pager diff pom.xml
