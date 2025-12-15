CFLAGS = -Wall
# Native compiler and Cross compiler.
COMPILER = gcc
CROSS_COMPILER = aarch64-none-linux-gnu-gcc

TARGET = writer
SRCS = writer.c
OBJS = $(SRCS:.c=.o)

native:${TARGET}
	${COMPILER} ${CFLAGS} -c ${SRCS} -o ${OBJS}

cross_compile:${TARGET}
	${CROSS_COMPILER} -c ${SRCS} -o ${OBJS}

clean:
	@rm -rf ${OBJS}
	@rm -rf ${TARGET}
