#include "device_functions.h"

#include <libopencm3/stm32/rcc.h>
#include <libopencm3/stm32/gpio.h>

/* Function to Initialise all GPIOs */
void vGPIOInitialize() {
    /* Enable GPIOC clock. */
    rcc_periph_clock_enable(RCC_GPIOB);

    /* System LED */
    gpio_mode_setup(GPIOB, GPIO_MODE_OUTPUT, GPIO_PUPD_NONE, GPIO0);
    /* Status LED */
    gpio_mode_setup(GPIOB, GPIO_MODE_OUTPUT, GPIO_PUPD_NONE, GPIO7);
    /* Warning LED */
    gpio_mode_setup(GPIOB, GPIO_MODE_OUTPUT, GPIO_PUPD_NONE, GPIO14);
}

/* Function to Toggle System LED */
void vSystemLEDToggle() {
    gpio_toggle(GPIOB, GPIO0);
}

/* Function to Toggle Status LED */
void vStatusLEDToggle() {
    gpio_toggle(GPIOB, GPIO7);
}

/* Function to Toggle Warning LED */
void vWarningLEDToggle() {
    gpio_toggle(GPIOB, GPIO14);
}

/* Initialise All System Clock Architecture */
void vConfigureClock() {
    // TODO!
}
