#ifndef DEVICE_FUNCTIONS
#define DEVICE_FUNCTIONS

/* Global Clock Configuration */
#define HSE_FREQ         8000000 // 8 MHz External Crystal
#define SYSCLK_FREQ      96000000 // 96 MHz System Frequency

/* Function to Initialise all GPIOs */
void vGPIOInitialize();

/* Function to Toggle System LED */
void vSystemLEDToggle();

/* Function to Toggle Status LED */
void vStatusLEDToggle();

/* Function to Toggle Warning LED */
void vWarningLEDToggle();

/* Initialise All System Clock Architecture */
void vConfigureClock();

#endif
