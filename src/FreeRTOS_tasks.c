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

/* Task 1 - Blink System LED */
void startTask1(void *args __attribute((unused))) {

    for (;;) {
        vSystemLEDToggle();
        vTaskDelay(100);
	}
}

/* Task 2 - Blink Status LED */
void startTask2(void *args __attribute((unused))) {

    for (;;) {
        vStatusLEDToggle();
        vTaskDelay(500);
	}
}

/* Task 3 - Blink Warning LED */
void startTask3(void *args __attribute((unused))) {

    for (;;) {
        vWarningLEDToggle();
        vTaskDelay(1000);
	}
}
