/* MAIN USER APPLICATION */
#include "main.h"

int main(void) {

    xTaskCreate(startTask1, "task1", 100, NULL, configMAX_PRIORITIES-1, NULL);

    vTaskStartScheduler();

    // This point is never reached!
    for (;;);
    return 0;
}


// SORT OUT CLOCKING! //
