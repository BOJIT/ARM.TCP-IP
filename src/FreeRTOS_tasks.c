#include "main.h"

/* Stack Overflow Handler */
extern void vApplicationStackOverflowHook(
    xTaskHandle *pxTask,
    signed portCHAR *pcTaskName);

void vApplicationStackOverflowHook(
  xTaskHandle *pxTask __attribute((unused)),
  signed portCHAR *pcTaskName __attribute((unused))
) {
    for(;;);    // Loop forever here..
}

/* Task 1 - Blink LED 1 */ 
void startTask1(void *args __attribute((unused))) {

    vGPIOInitialize();

    for (;;) {
        vStatusLEDToggle();
        vTaskDelay(pdMS_TO_TICKS(200));
	}
}
