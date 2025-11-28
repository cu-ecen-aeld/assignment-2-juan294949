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

if [ $(echo $writestr > $writefile) -eq 0 ]; then

  echo " SUCCESS "
  exit 0
else

  echo " FAIL: A problem occured trying to write at $writefile"
  exit 1
fi
# Overwrite any existing file  and creating a new path if it does not exist.
# If file can not be created, exit with error 1 and print statement.

function getX ()
{
  # Argument 1 path to directory.
  filesdir=$1
  # Find total number of files and subdirectories at "filesdir"
  find $filesdir -type f | cat > ./X.txt
  # Obtain the number of lines that were redirected to the X.txt file"
  X=$(wc -l ./X.txt | cut -d' ' -f1)
  rm ./X.txt
  echo "$X"
}

function getY()
{
  # Argument 2 string to search.
  filesdir=$1
  searchstr=$2
  grep -r  $searchstr $filesdir/* | cat > ./Y.txt
  # number of matching lines found in respective files.
  Y=$(wc -l ./Y.txt | cut -d' ' -f1)
  rm ./Y.txt
  echo $Y
}

# X:  Is the number of files in the directory and all subdirectories. 
# Y:  Is the number of matching lines found in respective files. matching lines dictated by SEARCHSTR.

echo "The number of files are $(getX $1 ) and the number of matching lines are $(getY $1 $2) "
