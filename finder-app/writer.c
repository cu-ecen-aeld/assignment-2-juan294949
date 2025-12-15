#include <stdio.h>
#include <syslog.h>

unsigned int writer(char* writefile,char* writestr);
#define MAX_ARGUMENTS   (2)
#define ARG1            (1)
#define ARG2            (2)

// test file.

int main(int argc, char *argv[])
{
  unsigned int status = 0;
  if( argc < MAX_ARGUMENTS )
  {
    return 1;
  }

  printf("argv[1]: %s, argv[2]: %s", argv[1],argv[2]);

  openlog("From writer.c: ",LOG_PID | LOG_PERROR,LOG_USER);

  status = writer(argv[ARG1],argv[ARG2]);

  syslog(LOG_INFO," writer returned with status = %u ",status);

  closelog();

  printf("LOG closed");

  return status;
}

/*

  From writer.sh instruction. 
    - Write a shell script finder-app/writer.sh as described below

    Accepts the following arguments:
      - Creates a new file with name and path writefile with content writestr, 
        overwriting any existing file and creating the path if it doesn’t exist.
      - Exits with value 1 and error print statement if the file could not be created.

  NOTE: Using File IO as described in LSP chapter 2.

  1).One difference from the write.sh instructions in Assignment 1: 
    - You do not need to make your "writer" utility create directories which do not exist.  
    - You can assume the directory is created by the caller.

  2).Setup syslog logging for your utility using the LOG_USER facility.

  3).Use the syslog capability to write a message “Writing <string> to <file>” where <string> 
    is the text string written to file (second argument) and <file> is the file created by the script.
    This should be written with LOG_DEBUG level.

  4).Use the syslog capability to log any unexpected errors with LOG_ERR level.

*/
unsigned int writer
(
  /*
    The first argument is a full path to a file (including filename) on the filesystem, 
    referred to below as writefile;
  */
  char* writefile,
  /*
    The second argument is a text string which will be written within this file, 
    referred to below as writestr.
  */
  char* writestr
){

  if((writefile == NULL) || writestr == NULL )
  {
    //Exits with value 1 error and print statements if any of the arguments above were not specified.
    syslog(LOG_ERR,"Missing statements.\n\rwritefile: %s\n\r writestr: %s\n\r",writefile,writestr);
    return 1;
  }

  FILE* PtrFile = fopen(writefile,"w");
  if(PtrFile == NULL)
  {
    syslog(LOG_ERR ," %m  at: %s" , writefile);
    return 1;
  }
  
  //Creates a new file with name and path writefile with content writestr.
  syslog(LOG_INFO," Writing %s to %s",writestr,writefile);
  fputs(writestr,PtrFile) >= 0 ?  syslog(LOG_INFO," SUCCESS") :
                                  syslog(LOG_ERR," %m Could not write to %s ",writefile);

  return fclose(PtrFile);

}
