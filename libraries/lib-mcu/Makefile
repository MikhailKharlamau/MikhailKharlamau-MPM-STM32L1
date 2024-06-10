CC=arm-cortexm3-eabi-gcc
AR=arm-cortexm3-eabi-ar

###########################################

PATHLIBCORE = ../lib-core/CMSIS
INCLLIBCORE = -I$(PATHLIBCORE)/Include -I$(PATHLIBCORE)/Device/ST/STM32L1xx/Include

vpath %.c STM32L1xx_StdPeriph_Driver/src

CFLAGS  = -g -O2 -Wall
CFLAGS += -mlittle-endian -mthumb -mcpu=cortex-m3 -march=armv7-m
CFLAGS += -ffreestanding -nostdlib
CFLAGS += -includestm32l1xx_conf.h $(INCLLIBCORE) -ISTM32L1xx_StdPeriph_Driver/inc


SRCS = misc.c stm32l1xx_adc.c stm32l1xx_aes.c stm32l1xx_cec.c stm32l1xx_aes_util.c stm32l1xx_comp.c stm32l1xx_crc.c \
	stm32l1xx_dac.c stm32l1xx_dbgmcu.c stm32l1xx_dma.c stm32l1xx_exti.c \
	stm32l1xx_flash.c stm32l1xx_flash_ramfunc.c stm32l1xx_fsmc.c stm32l1xx_gpio.c stm32l1xx_i2c.c stm32l1xx_iwdg.c \
	stm32l1xx_lcd.c stm32l1xx_opamp.c stm32l1xx_pwr.c stm32l1xx_rcc.c stm32l1xx_rtc.c \
	stm32l1xx_sdio.c stm32l1xx_spi.c stm32l1xx_syscfg.c stm32l1xx_tim.c \
	stm32l1xx_usart.c stm32l1xx_wwdg.c

OBJS = $(SRCS:.c=.o)

.PHONY: libstm32l1.a

all: libstm32l1.a

%.o : %.c
	$(CC) $(CFLAGS) -c -o $@ $^

libstm32l1.a: $(OBJS)
	$(AR) -r $@ $(OBJS)

clean:
	rm -f $(OBJS) libstm32l1.a
