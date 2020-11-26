#!/bin/bash

if ! command -v git &> /dev/null
then
  echo "no git?! what hell is this?"
  exit
fi

git config --global user.name "Prasanth Vaaheeswaran"
git config --global user.email prasanthv@icloud.com 
git config --global core.editor vim

git config --global --list
