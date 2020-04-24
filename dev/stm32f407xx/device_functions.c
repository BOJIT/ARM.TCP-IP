#include "device_functions.h"

#include <libopencm3/stm32/rcc.h>
#include <libopencm3/stm32/gpio.h>

/* Function to Initialise all GPIOs */
void vGPIOInitialize() {
    /* Enable GPIOC clock. */
    rcc_periph_clock_enable(RCC_GPIOC);

    gpio_mode_setup(GPIOC,GPIO_MODE_OUTPUT, GPIO_PUPD_NONE, GPIO3);
}

/* Function to Toggle Status LED */
void vStatusLEDToggle() {
    gpio_toggle(GPIOC,GPIO3);
}
