#!/bin/bash

# Detect remote
REMOTE_URL=$(git config --get remote.origin.url)
PROFILE=""
NAME=""
SIGNING_KEY=""
EMAIL=""

setup()
{
  # Apply local config
  echo "Configuring '$PROFILE'..."
  git config user.name "$NAME"
  git config user.email "$EMAIL"
  git config commit.gpgsign true
  git config gpg.format ssh
  git config user.signingkey "$SIGNING_KEY"

  echo "Local configuration done for: '$PROFILE'"
  git config --get user.name
  git config --get user.email
  exit 0
}

manual_config()
{
  read -p "Manually config it ? (y/N) " manual
  if [[ "$manual" != "y" && "$manual" != "Y" ]]; then
    echo "Aborting"
    exit 1
  fi
  read -p "Name: " NAME
  read -p "Git mail: " EMAIL
  read -p "SSH key path: " SIGNING_KEY
  PROFILE="custom"
  setup
}

if [ ! -d ".git" ]; then
  echo "Not a git repo, check initialization or move on to an actual repo."
  exit 1
fi


if [ -z "$REMOTE_URL" ]; then
  echo "Git remote not yet configured."
  manual_config
fi

# Determine which profil use
if [[ "$REMOTE_URL" == *<Remote URL>* ]]; then
  PROFILE="perso"
  NAME="<Your account name>"
  EMAIL="<Your mail>"
  SIGNING_KEY="<Path to the key>"
elif [[ "$REMOTE_URL" == *<Remote URL>* ]]; then
  PROFILE="pro"
  NAME="<Your account name>"
  EMAIL="<Your mail>"
  SIGNING_KEY="<Path to the key>"
else
  echo "Can't tell which profile to use for: $REMOTE_URL"
  manual_config
fi
setup
