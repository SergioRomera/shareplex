#!/bin/bash
#Description: shred functions

# ******************************************************************************
# Function dwt
# ******************************************************************************
function dwt() { 
  d=$(date "+%Y%m%d-%H%M%S")
  printf "$d\n" 
}

# Error message function
error () {
  printf "[$(dwt)]$@\n"
}

info () {
  printf "[$(dwt)] $@\n"
}
