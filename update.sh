#!/bin/bash
set -x

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

LOG_FILE="$THIS_DIR/update.log"

git_msg ( ) {
    printf "Last DNS update at %s" "$(date)"
}

echo "\n==== Invoking CRON at $(date) ==== \n" > "$LOG_FILE" 2>&1

curl -s -o "$THIS_DIR/update.txt" "http://www.myexternalip.com/raw"  > "$LOG_FILE" 2>&1 && \
    git -C "$THIS_DIR" add  "$THIS_DIR/update.txt"  > "$LOG_FILE" 2>&1 && \
    git -C "$THIS_DIR" commit -m "$(git_msg)"  > "$LOG_FILE" 2>&1

git -C "$THIS_DIR" push origin master
