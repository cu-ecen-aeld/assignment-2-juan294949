#!/bin/bash

writefile=$1
writestr=$2
DIRPATH=$(dirname $writefile)

# Return value 1 error and print statements in case that any of the parameters were not specified.
if [ $# -lt 2 ]; then

  echo " Number of arguments: $#. Spected 2 "
  exit 1

elif [ -d $DIRPATH  ]; then

  echo " Directory $1 found in filesystem."

    if [ -f $writefile ]; then

      echo " file $writefile found in filesystem."

    else

      echo " file $writefile not found in filesystem. Creating now"
      touch $writefile

    fi
else

  echo " Directory $1 Not found in filesystem. Creating path and file. "
  mkdir -p $DIRPATH
  touch $writefile

fi

# Create a new file with the in path writefile with content writestr.

if [[ $(echo $writestr > $writefile) -eq 0 ]]; then

  exit 0

else

  exit 1

fi
