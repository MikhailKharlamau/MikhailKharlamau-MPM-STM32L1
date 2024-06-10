#include "stm32l1xx_conf.h"
#include "stm32l_discovery_lcd.h"

int main(void)
{
    // low level access to GPIO
    // we init the pin by direct manipulation of registers
    RCC->AHBENR |= RCC_AHBENR_GPIOCEN; 	// enable the clock to GPIOC
                                        // (RM0091 lists this as IOPCEN, not GPIOCEN)
    GPIOC->MODER = (1 << 16);

    // middle level access to GPIO (via the peripheral library)
    GPIO_InitTypeDef  GPIO_InitStructure;

    //RCC_AHBPeriphClockCmd(RCC_AHBPeriph_GPIOC, ENABLE);  // Enable the GPIO LEDs clock

    // by [DocID025474 Rev 1] the red LED is hardwired to PC7
    // by default PC7 is the 7th signal of GPIO bank C
    GPIO_InitStructure.GPIO_Pin = GPIO_Pin_7;
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_OUT;
    GPIO_InitStructure.GPIO_OType = GPIO_OType_PP;
    GPIO_InitStructure.GPIO_PuPd = GPIO_PuPd_NOPULL;
    GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
    GPIO_Init(GPIOC, &GPIO_InitStructure);

    // high level access to GPIO (via the board library)
    STM_EVAL_LEDInit(LED5);

    SysTick_Config(SystemCoreClock/100);

    while(1);
}

