# put your *.o targets here, make should handle the rest!
SRCS = main.c system_stm32l1xx.c

# all the files will be generated with this name (main.elf, main.bin, main.hex, etc)
PROJ_NAME=main

# Location of the linker scripts
LDSCRIPT_INC=device/ldscripts

# location of OpenOCD Board .cfg files (only used with 'make program')
OPENOCD_BOARD_DIR=/usr/share/openocd/scripts/board

# Configuration (cfg) file containing programming directives for OpenOCD
OPENOCD_PROC_FILE=extra/stm32f0-openocd-hex.cfg

# Location of the individual libraries and the spells to cast in order to use them
PATHLIBCORE = libraries/lib-core
INCLLIBCORE = -I$(PATHLIBCORE)/CMSIS/Device/ST/STM32L1xx/Include -I$(PATHLIBCORE)/CMSIS/Include 

PATHLIBPERIPH = libraries/lib-mcu
INCLLIBPERIPH = -I$(PATHLIBPERIPH) -I$(PATHLIBPERIPH)/STM32L1xx_StdPeriph_Driver/inc -include $(PATHLIBPERIPH)/stm32l1xx_conf.h
STATLIBPERIPH = -L$(PATHLIBPERIPH) -lstm32l1

PATHLIBBOARD = libraries/lib-board
INCLLIBBOARD = -I$(PATHLIBBOARD)/Utilities
STATLIBBOARD = -L$(PATHLIBBOARD) -lstm32l1b

# tools in toolchain
CC=arm-cortexm3-eabi-gcc
OBJCOPY=arm-cortexm3-eabi-objcopy
OBJDUMP=arm-cortexm3-eabi-objdump
SIZE=arm-cortexm3-eabi-size

# compiler flags
CFLAGS  = -Wall -g -std=c99 -Os
# TODO next line seems facultative if the used toolchain
#      has the architecture hardcoded
#      we should try not using it
CFLAGS += -mlittle-endian -mcpu=cortex-m3 -march=armv7-m -mthumb
CFLAGS += -ffunction-sections -fdata-sections
CFLAGS += -Wl,--gc-sections -Wl,-Map=$(PROJ_NAME).map

CFLAGS += -I inc
CFLAGS += $(INCLLIBCORE)
CFLAGS += $(INCLLIBPERIPH)  # comment this line if you dont use standard peripheral library
CFLAGS += $(INCLLIBBOARD)   # comment this line if you dont use the board library

# linker flags
# TODO inclusion order does not allow for efficient commenting out
LDFLAGS  = $(STATLIBBOARD)  # comment this line if you dont use the board library
LDFLAGS += $(STATLIBPERIPH) # comment this line if you dont use standard peripheral library
LDFLAGS += -L$(LDSCRIPT_INC) -Tstm32f0.ld
###################################################

# startup code written is assembly
# contains code of importat handlers activated in the startup sequence
SRCS  = device/startup_stm32l1xx_hd.s
SRCS += src/system_stm32l1xx.c
SRCS += src/stm32l1xx_it.c
SRCS += src/main.c

OBJS = $(SRCS:.c=.o)

###################################################

all: lib proj

lib:
	$(MAKE) -C $(PATHLIBPERIPH)
	$(MAKE) -C $(PATHLIBBOARD)

proj: $(PROJ_NAME).elf

$(PROJ_NAME).elf: $(SRCS)
	$(CC) $(CFLAGS) $^ -o $@ $(LDFLAGS)
	$(OBJCOPY) -O ihex $(PROJ_NAME).elf $(PROJ_NAME).hex
	$(OBJCOPY) -O binary $(PROJ_NAME).elf $(PROJ_NAME).bin
	$(OBJDUMP) -St $(PROJ_NAME).elf >$(PROJ_NAME).lst
	$(SIZE) $(PROJ_NAME).elf
	
program: $(PROJ_NAME).bin
	openocd -f $(OPENOCD_BOARD_DIR)/stm32ldiscovery.cfg -f $(OPENOCD_PROC_FILE) -c "stm_flash `pwd`/$(PROJ_NAME).bin" -c shutdown

clean:
	find ./ -name '*~' | xargs rm -f
	rm -f *.o
	rm -f $(PROJ_NAME).elf
	rm -f $(PROJ_NAME).hex
	rm -f $(PROJ_NAME).bin
	rm -f $(PROJ_NAME).map
	rm -f $(PROJ_NAME).lst

deepclean: clean
	$(MAKE) -C $(PATHLIBPERIPH) clean
	$(MAKE) -C $(PATHLIBBOARD) clean
