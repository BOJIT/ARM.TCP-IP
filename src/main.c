// MAIN USER APPLICATION
#include "device_functions.h"

int main(void) {
	int i;

	vGPIOInitialize();

	for (;;) {
		vStatusLEDToggle();	/* LED on */
		for (i = 0; i < 50000; i++)	/* Wait a bit. */
			__asm__("nop");
	}

	return 0;
}
