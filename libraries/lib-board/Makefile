CC=arm-cortexm3-eabi-gcc
AR=arm-cortexm3-eabi-ar

###########################################
PATHLIBCORE  = ../lib-core/CMSIS
INCLLIBCORE  = -I$(PATHLIBCORE)/Include -I$(PATHLIBCORE)/Device/ST/STM32L1xx/Include

PATHLIBPERIPH  = ../lib-mcu
INCLLIBPERIPH  = -I$(PATHLIBPERIPH) -I$(PATHLIBPERIPH)/STM32L1xx_StdPeriph_Driver/inc
INCLLIBPERIPH += -include $(PATHLIBPERIPH)/stm32l1xx_conf.h

vpath %.c ./Utilities
#vpath %.a $(PATHLIBPERIPH)

CFLAGS  = -g -O2 -Wall
CFLAGS += -mlittle-endian -mthumb -mcpu=cortex-m3 -march=armv7-m
CFLAGS += -ffreestanding -nostdlib
CFLAGS += -I. -I inc 
CFLAGS += $(INCLLIBCORE) $(INCLLIBPERIPH)

SRCS = stm32l_discovery_lcd.c
 
OBJS = $(SRCS:.c=.o)

#.PHONY: lib_Utilities.a

all: libstm32l1b.a

lib:
	$(MAKE) -C $(STD_PERIPH_LIB)

%.o : %.c
	$(CC) $(CFLAGS) -c -o $@ $^

libstm32l1b.a: $(OBJS)
	$(AR) -r $@ $(OBJS)

clean:
	rm -f $(OBJS) libstm32l1b.a
