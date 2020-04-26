/* MAIN USER APPLICATION */
#include "main.h"

int main(void) {

    vConfigureClock();  // Configure RCC, System Clock Tree, PLL, etc...

    vGPIOInitialize();

    xTaskCreate(startTask1, "task1", 100, NULL, configMAX_PRIORITIES-1, NULL);
    xTaskCreate(startTask2, "task2", 100, NULL, configMAX_PRIORITIES-1, NULL);
    xTaskCreate(startTask3, "task3", 100, NULL, configMAX_PRIORITIES-1, NULL);

    vTaskStartScheduler();

    // This point is never reached!
    for (;;);
    return 0;
}
