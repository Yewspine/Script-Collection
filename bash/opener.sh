#!/bin/bash

# Check mime type
mime=$(file --mime-type -b "$1")

# Open the file using preferred app
case "$mime" in
  # Images
  image/*)
    sxiv "$1"
  ;;

  # Text file
  text/*)
    vim "$1"
  ;;

  # PDF
  application/pdf)
    atril "$1"
  ;;

  # Other
  *)
    xdg-open "$1"
  ;;
esac

