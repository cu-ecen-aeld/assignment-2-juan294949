#include <fcntl.h>
/*
  <fcntl.h>
  *open
  *
*/
#include <unistd.h> 
/*
  <unistd.h>
  *write
  *read
*/
#include <stdio.h>
/*
  <stdio.h>
  *printf
  *EOF
*/
#include <stdlib.h>
/*
  <stdlib.h>
  *malloc
*/
#include <ctype.h>
/*
  <ctype.h>
  *toupper
*/
#include <errno.h>
#include <string.h>

extern int errno;


int Cp(const char *Src,const char *Dst);

/* Main entry point for the program. */

int main(int NumberOfArguments,char *ArgumentsArray[])
{
  const char destination[] = "./FileCopied.txt";
  const char source[] = "./file-IO.c";

  printf("From file-IO.c: status returned = %d",Cp(source,destination));

  return 0;
}


typedef struct
{
  const char *fileDst; // Destination file path in the filesystem.
  int flagsDst; // Destination file flags.
  int modesDst; // Destination file modes.
  char sync; // Synch after write.

}WrFileIO;

/**
 * WriteFile - creates a new file called log.txt
 * @void: None
 *
 * Returns the status of the log created. if -1 failed. Otherwise, success.
 *
 */

int WriteToFile(WrFileIO fileStruct,char* pBuffer,unsigned long long bufferSize)
{
  int fd = (pBuffer != NULL && bufferSize > 0) ? 
            open(fileStruct.fileDst,fileStruct.flagsDst,fileStruct.modesDst):
            -1;
  if(fd < 0)
  {
    return fd;
  }

  char* pBufferStart = pBuffer;

  if(write(fd,pBufferStart,bufferSize) < 0 )
  {
    close(fd);
    return -1;
  }

  if((char)toupper((int)fileStruct.sync) == 'Y')fsync(fd);

  return close(fd);
}


int Cp(const char *Src,const char *Dst)
{
  int status = 0;
  int fd = open(Src,O_RDONLY); // Open the source file to read from it.

  if( fd >= 0)
  {
    off_t size = lseek(fd, 0, SEEK_END);
    lseek(fd, 0, SEEK_SET);
  
    char* pBuffer = (char*)malloc(((size_t)size)*sizeof(char));

    while(read(fd,pBuffer,(size_t)size) > 0);

    if(pBuffer != NULL )
    {
      WrFileIO wrFileIO = 
      {
        .fileDst = Dst,
        .flagsDst = (O_WRONLY| O_CREAT|O_TRUNC),
        .modesDst = (S_IRWXU|S_IRWXG|S_IRWXO),
        .sync = 'n'
      };

      WriteToFile(wrFileIO,pBuffer,size) >= 0 ?  (status = 0) : (status = -1);
      free(pBuffer);
      close(fd);
    }

  }else(status = -1);

  return status;
}

// long ReadLogFile(void)
// {
//   const char log[] = "./log.txt";
//   char strbuffer[BYTES_100] = {0};
//   ssize_t N_bytes = 0;
//   ssize_t stop = 0;

//   int fd = open(log,O_RDONLY);
//   if(fd < 0)
//   {
//     return fd;
//   }

//   while(!stop)
//   {
//     stop = read(fd,strbuffer,BYTES_100 -1);
//     // check if there is an error or End-of-File
//     if(stop == EOF_ || stop == ERROR_)
//     {
//       N_bytes = stop;
//       break;
//     }
//     // If we still getting bytes , add them to the 
//     N_bytes = N_bytes + stop;
//   }

//   close(fd);

//   return N_bytes;
// }

// int WriteFsynchTest(void)
// {

//   //  1).Write a program that creates a new file called log.txt
//   const char log[] = "./log.txt";
//   const char text_to_write[] = "System log initialization sequence started.\
//   This file is intentionally large enough to demonstrate buffered file I/O behavior in Linux.\
//   Each line represents a simulated log entry that might be written by a real system during\
//   startup, configuration, or runtime operation. The operating system does not immediately\
//   write this data to disk when write() is called. Instead, the data is placed into the page\
//   cache in memory and marked as dirty.\
//   Dirty data means that the in-memory copy of the file is newer than the version stored on\
//   persistent storage. The kernel will eventually flush this data to disk in the background,\
//   but there is no guarantee about when that will happen unless fsync() is explicitly called.\
//   If power is lost before the dirty data is written to disk, the data may be lost entirely.\
//   This behavior is intentional and exists for performance reasons. Writing small chunks of\
//   data directly to disk would be extremely slow and inefficient. By buffering writes in RAM,\
//   the operating system can batch disk operations, reorder writes safely, and significantly\
//   improve overall system performance.\
//   This text continues to grow in size to ensure that multiple memory pages are touched and\
//   that the kernel has real work to do when flushing data. On embedded systems, SD cards and\
//   eMMC devices often have additional internal caches, making the problem even more visible.\
//   Without fsync(), data loss after a crash or power failure is not only possible but common.\
//   End of test log.\
//   ";

//   //  2).Open the file using low-level POSIX file I/O.
//   int fd = open(log,O_CREAT|O_RDWR|O_TRUNC,S_IRWXU);
//   if(fd < 0)
//   {
//     return fd;
//   }
//   //  3).Write a short text line (e.g. “System started”)
//   if(write(fd,text_to_write,(size_t)((sizeof(text_to_write)/sizeof(*text_to_write))-1)) == (ssize_t)-1)
//   {
//     close(fd);
//     return -1;
//   }

//   fsync(fd);
//   //  4).Close the file cleanly
//   return close(fd);
// }