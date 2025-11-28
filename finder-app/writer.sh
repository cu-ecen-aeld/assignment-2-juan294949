#!/bin/bash

writefile=$1
writestr=$2

# Return value 1 error and print statements in case that any of the parameters were not specified.
if [ $# -lt 2 ]; then

  echo "ERROR: Number of arguments: $#. Spected 2 "
  exit 1

else

  DIRPATH=$(dirname $writefile)
  
  if [ -d $DIRPATH  ]; then

      if [ ! -f $writefile ]; then

        touch $writefile

      fi

  else

    mkdir -p $DIRPATH
    touch $writefile
  fi
fi

# Create a new file with the in path writefile with content writestr.

if [[ $(echo $writestr > $writefile) -eq 0 ]]; then

  exit 0

else

  exit 1

fi
