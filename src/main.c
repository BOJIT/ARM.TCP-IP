#include <libopencm3/stm32/rcc.h>
#include <libopencm3/stm32/gpio.h>

static void
gpio_setup(void) {

	/* Enable GPIOC clock. */
	rcc_periph_clock_enable(RCC_GPIOB);

	gpio_mode_setup(GPIOB,GPIO_MODE_OUTPUT, GPIO_PUPD_NONE, GPIO7);
}

int
main(void) {
	int i;

	gpio_setup();

	for (;;) {
		gpio_clear(GPIOB,GPIO7);	/* LED on */
		for (i = 0; i < 1500000; i++)	/* Wait a bit. */
			__asm__("nop");

		gpio_set(GPIOB,GPIO7);		/* LED off */
		for (i = 0; i < 500000; i++)	/* Wait a bit. */
			__asm__("nop");
	}

	return 0;
}
