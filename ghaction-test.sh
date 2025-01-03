#!/bin/bash
git switch test ; git pull ; git merge --no-ff --no-edit origin/main ; git push ; git switch main
