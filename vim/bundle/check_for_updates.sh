#!/bin/sh
oldcwd=$(pwd)

cd "$(dirname "$0")";
for submodule in *; do
    if [ -e "$submodule/.git" ]; then
        cd "$submodule";
        echo "--- $submodule";
        git co master;
        git pull;
        cd ..;
    fi
done

cd "$oldcwd";
