#include "device_functions.h"

#include <libopencm3/stm32/rcc.h>
#include <libopencm3/stm32/gpio.h>

/* Function to Initialise all GPIOs */
void vGPIOInitialize() {
    /* Enable GPIOC clock. */
    rcc_periph_clock_enable(RCC_GPIOB);

    gpio_mode_setup(GPIOB,GPIO_MODE_OUTPUT, GPIO_PUPD_NONE, GPIO7);
}

/* Function to Toggle Status LED */
void vStatusLEDToggle() {
    gpio_toggle(GPIOB,GPIO7);
}
