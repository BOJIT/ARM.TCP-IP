# Shell script for automating MCU flashing/programming

FORMAT_PURPLE='\033[1m\033[95m'
FORMAT_WHITE='\033[1m\033[36m'
FORMAT_RED='\033[1m\033[91m'
FORMAT_OFF='\033[0m'

if [[ $1 == "-g" ]]
then
    # Debug Script
    echo "${FORMAT_RED}Debugging ${BINARY}...${FORMAT_OFF}\n"

    ## For some reason, launching the st-util as a child process seems to cause
    ## issues. for now, just launch st-util in a separate terminal.

    #st-util & # Start GDB server (automatically stopped when finished)

    #sleep 1 # Wait for GDB server to launch

    # Start GDB debugger on localhost:
    arm-none-eabi-gdb --command=flash/gdb_stm32f767xx

    kill 0

    echo "${FORMAT_RED}Debugging Complete!${FORMAT_OFF}\n"

else
    # Flash Script
    echo "${FORMAT_RED}Flashing ${BINARY}...${FORMAT_OFF}\n"

    st-flash write bin/stm32f767xx/stm32f767xx.bin 0x8000000

    echo "${FORMAT_RED}Flashing Complete!${FORMAT_OFF}\n"
fi
