#!/bin/bash
find . -type f -name "*.iml" -exec rm "{}" \;
rm -rf .idea ./maven-multi-module/.idea
echo "Finished remove *.iml files and .idea directory"