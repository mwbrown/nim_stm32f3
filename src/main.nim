
#
# main.nim
#
# Entry point for system image.
#

var SysTickCount {.volatile.} : cint = 0

# TODO determine if Nimrod is interrupt-safe
proc sys_tick_handler {.exportc.} =
    SysTickCount += 1

# Import some systick helper functions from libopencm3.
proc systick_set_reload(ticks: cint)       {.importc.}
proc systick_set_clocksource(enable: cint) {.importc.}
proc systick_interrupt_enable()            {.importc.}
proc systick_counter_enable()              {.importc.}

# The libopencm3 library looks for a main() symbol to link against, and will
# call this function after performing system initialization.
proc main() : cint {.exportc.} =
    var myVolatileVar {.volatile.} : cint

    # TODO implement SysTick_Config with checking

    systick_set_reload(8000000 * 2)
    systick_set_clocksource(1)
    systick_interrupt_enable()
    systick_counter_enable()

    # TODO add a blinking LED via RCC and GPIO functions

    while true:
        for x in 1..10:
            myVolatileVar = x

    return cint(0)
