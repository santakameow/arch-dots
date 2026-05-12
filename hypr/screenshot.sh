#!/usr/bin/env bash
# set drectory
XDG_PICTURES_DIR=$(xdg-user-dir PICTURES)
DIR="$XDG_PICTURES_DIR/Screenshots/$(date +%m-%Y)"
# create directory if not exist
mkdir -p "$DIR"
# make screenshot and save to $DIR
grimblast copysave area "$DIR/$(date +%H:%M:%S).png"
