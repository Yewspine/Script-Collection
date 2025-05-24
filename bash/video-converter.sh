#!/bin/bash

# Just a bunch of Variables
AUDIO_CODEC=libvorbis
VIDEO_CODEC=vp9
VERSION="1.0.0"
AUTHOR="Yewspine"
SOURCE="https://github.com/Yewspine/Script-Collection"
PURGE=false
DESTINATION=`pwd`
INPUT=None
OUTPUT=None

# Help function, display simple usage
function help()
{
  echo "usage: video-converter [ -A <audio codec name> ] [ -V <video codec name> ] -i </path/to/file> -o <video extension name> [-d </path/to/output/dir>] [-p]"
  echo "-i      Set the input file to convert"
  echo "-o      Set the new video extension"
  echo "-d      Destination. If present, automatically move the output file to the desired location"
  echo "-p      Purge. If present, automatically delete the input file"
  echo "-A      Set the desired audio codec, if not present use libvorbis by default"
  echo "-V      Set the desired video codec, if not present use vp9 by default"
  echo "-h      Display this help message"
  echo "-v      Display the application version"
  echo "-a      Display the author name"
  echo "-s      Display the source code link"
}

# Display the tool version
function version()
{
  echo "$VERSION"
}

# Display the author name
function author()
{
  echo "$AUTHOR"
}

# Display the link to the source of the tool
function source()
{
  echo "$SOURCE"
}

# Parse short options
OPTIND=1
while getopts "d:i:o:p:A:V:hvas" opt
do
  case "$opt" in
    'i') INPUT="$OPTARG";;
    'd') DESTINATION="$OPTARG";;
    'o') OUTPUT="$OPTARG";;
    'p') PURGE=true;;
    'A') AUDIO_CODEC="$OPTARG";;
    'V') VIDEO_CODEC="$OPTARG";;
    'h') help; exit 0 ;;
    'v') version; exit 0 ;;
    'a') author; exit 0 ;;
    's') source; exit 0 ;;
  esac
done

# Remove options from positional parameters
shift $(expr $OPTIND - 1) 

# Check if the file is usable
if [ ! -f $INPUT ] || [ ! -e $INPUT ] 
then
  echo "File does not exist"
  exit 1
fi

# Concatenate input file name with output video extension
FINAL_FILE="${INPUT%%.*}.$OUTPUT"
# Convert it to output file using provided video and audio codec. Or use default vp9 and libvorbis codec
ffmpeg -i $INPUT -c:v $VIDEO_CODEC -c:a $AUDIO_CODEC $FINAL_FILE
# Move the output file to the destination
mv $FINAL_FILE $DESTINATION
# If present, remove the original file
if [ $PURGE ] 
then
  rm -rf $INPUT
fi
