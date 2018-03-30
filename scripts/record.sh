#!/bin/bash
set -e

# if [ $# -lt 1 ]; then
#     echo "usage: $0 log_file.rcg video_name.mp4"
#     exit
# fi

START_FRAME=0
SOCCERWINDOW="/home/abhisheknaik96/CS/CS7011/Project/HFO-master/bin/soccerwindow2"
# DIR=`mktemp -d`
# PATH="/home/abhisheknaik96/CS/CS7011/Project/Screenshots/"
# DIR="1v1_naive/"
# LOG="20171029045514-base_left_0-vs-base_right_0.rcg"
PATH=$1
DIR=$2
LOG=$3

$SOCCERWINDOW -l $PATH$DIR$LOG --auto-image-save --canvas-size=640x400 --image-save-dir=$PATH$DIR
# ffmpeg -r 10 -start_number $START_FRAME -i $DIR/image-%05d.png -f mp4 -c:v libx264 -s 1024x768 -vf "crop=iw/2.5:8.38*ih/10:iw/2:ih/10,transpose=1" -pix_fmt yuv420p $OUT
# rm -fr $DIR
