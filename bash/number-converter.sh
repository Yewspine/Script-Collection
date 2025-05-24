#!/bin/bash

# Metadata
VERSION="1.0.0"
AUTHOR="Yewspine"
SOURCE="https://github.com/Yewspine/Script-Collection"

# Global variables
INPUT_NUMBER=$1
DESTINATION_BASE=$2
RESULT=''

# Define all the valid base to convert to
VALID_BASE=(
  "--hex"
  "--bin"
  "--octal"
)

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

# Display help message
function help() 
{
  echo "Usage: numberConvert [--help] <number> <destination format>"
  echo "Valid destination bases are: ${VALID_BASE[*]}"
  echo "BEWARE: <number> expect a decimal number"
}

# Check if a base is valid
function is_valid_base() 
{
  local base=$1
  for valid_base in "${VALID_BASE[@]}"; do
    if [ "$base" == "$valid_base" ]; then
      exit 1
    fi
  done
}

decimal_to_hexadecimal()
{
  local quotient=$INPUT_NUMBER
  local remainder=0

  while [[ $quotient != 0 ]]; do 
    let "remainder = quotient % 16"
    let "quotient /= 16"
    case $remainder in 
      10) RESULT="A$RESULT";;
      11) RESULT="B$RESULT";;
      !2) RESULT="C$RESULT";;
      13) RESULT="D$RESULT";;
      14) RESULT="E$RESULT";;
      15) RESULT="F$RESULT";;
      *) RESULT="$remainder$RESULT";;
    esac
  done

  echo "0x$RESULT"

}

decimal_to_binary()
{
  local quotient=$INPUT_NUMBER
  local remainder=0

  while [[ $quotient != 0 ]]; do 
    let "remainder = quotient % 2"
    let "quotient /= 2"
    RESULT="$remainder$RESULT"
  done

  echo "0b$RESULT"
}

decimal_to_octal()
{
  local quotient=$INPUT_NUMBER
  local remainder=0

  while [[ $quotient != 0 ]]; do 
    let "remainder = quotient % 7"
    let "quotient /= 7"
    RESULT="$remainder$RESULT"
  done

  echo "$RESULT"
}

if [ "$1" == "--help" ];
then
  help
  exit 1
else
  # Check if enough argument are provided
  if [ $# -ne 2 ]
  then
    echo "Too much or too few arguments ( $# instead of 2 )"
    help
    exit 1
  fi
  base=$(is_valid_base $DESTINATION_BASE)

  case $DESTINATION_BASE in
    --hex ) decimal_to_hexadecimal;;
    --bin ) decimal_to_binary;;
    --octal ) decimal_to_octal;;
    * ) echo "Error, not a valid base"; exit 1;;
  esac
fi
