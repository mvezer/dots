#!/usr/bin/env bash
LOCAL_DIR="$HOME/Dropbox/notes"
REMOTE_DIR="dropbox:notes"
LOG_FILE="$HOME/.rclone-sync.log"

# Sync remote changes to local first
rclone sync $REMOTE_DIR $LOCAL_DIR --update --use-server-modtime --log-file=$LOG_FILE

# Then sync local changes to remote
rclone sync $LOCAL_DIR $REMOTE_DIR --update --log-file=$LOG_FILE
