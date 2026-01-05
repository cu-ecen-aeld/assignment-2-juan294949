CFLAGS = -Wall -g
# Native compiler and Cross compiler.
COMPILER = gcc
CROSS_COMPILER = aarch64-none-linux-gnu-gcc

TARGET = writer
SRCS = writer.c
OBJS = $(SRCS:.c=.o)

SRCS_DONUT = ./donut-folder/donut.c
TARGET_DONUT = ./donut-folder/donut
OBJS_DONUT = $(SRCS_DONUT:.c=.o)

SRCS_FILE_IO = ./extra-activity/file-IO.c
TARGET_FILE_IO = ./extra-activity/file-IO
OBJS_FILE_IO = $(SRCS_FILE_IO:.c=.o)

fileIO:${TARGET_FILE_IO}
	${COMPILER} ${CFLAGS} -c ${SRCS_FILE_IO}  -o ${OBJS_FILE_IO} 

dona:${TARGET_DONUT}
	${COMPILER} ${CFLAGS} -c ${SRCS_DONUT} -o ${OBJS_DONUT}

native:${TARGET}
	${COMPILER} ${CFLAGS} -c ${SRCS} -o ${OBJS}

cross_compile:${TARGET}
	${CROSS_COMPILER} -c ${SRCS} -o ${OBJS}

clean:
	@rm -rf ${OBJS}
	@rm -rf ${TARGET}
