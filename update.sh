#!/bin/bash
set -x

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

git_msg ( ) {
    printf "Last DNS update at %s" "$(date)"
}

curl -s -o "$THIS_DIR/update.txt" "http://www.myexternalip.com/raw" && \
    git -C "$THIS_DIR" add  "$THIS_DIR/update.txt" && \
    git -C "$THIS_DIR" commit -m "$(git_msg)"      && \
    git -C "$THIS_DIR" push origin master
