
#
# panicoverride.nim
#
# Provides required functions for Nimrod in standalone mode.
#

proc rawoutput(s: string) =
    discard

proc panic(s: string) =
    rawoutput(s)

    while true:
        discard