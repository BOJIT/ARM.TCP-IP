# Shell script for automating MCU flashing/programming

FORMAT_PURPLE='\033[1m\033[95m'
FORMAT_WHITE='\033[1m\033[36m'
FORMAT_RED='\033[1m\033[91m'
FORMAT_OFF='\033[0m'

echo "${FORMAT_RED}Flashing ${BINARY}...${FORMAT_OFF}\n"

st-flash write bin/stm32f767xx/stm32f767xx.bin 0x8000000

echo "${FORMAT_RED}Flashing Complete!${FORMAT_OFF}\n"
