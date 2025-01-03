#!/bin/bash
find . -type f -name "pom.xml.versionsBackup" -exec rm "{}" \;
echo "Finished remove pom.xml.versionsBackup"