#!/bin/bash

# Return value 1 error and print statements in case that any of the parameters were not specified.
if [ $# -lt 2 ]; then

  echo " Number of arguments: $#. Spected 2 "
  exit 1

# Return value 1 error and print statements if FILESDIR does not represent a directory on the filesystem.
elif [ -d $1  ]; then

  echo " Directory $1 found in filesystem "

else

  echo " Directory $1 Not found in filesystem "
  exit 1

fi

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
