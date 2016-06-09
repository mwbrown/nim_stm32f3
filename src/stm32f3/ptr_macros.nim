
# TODO: Make these inline

proc volatileLoad*[T](address: ptr T) : T {.inline.} =

    when sizeof(T) == 1:
        {.emit: "`result` = *((volatile NU8 *)(`address`));" .}
    elif sizeof(T) == 2:
        {.emit: "`result` = *((volatile NU16 *)(`address`));" .}
    elif sizeof(T) == 4:
        {.emit: "`result` = *((volatile NU32 *)(`address`));" .}
    else:
        {.error: "Unhandled size" .}

proc volatileStore*[T](address: ptr T, value: T) {.inline.} =

    when sizeof(T) == 1:
        {.emit: "*((volatile NU8 *)(`address`)) = `value`;" .}
    elif sizeof(T) == 2:
        {.emit: "*((volatile NU16 *)(`address`)) = `value`;" .}
    elif sizeof(T) == 4:
        {.emit: "*((volatile NU32 *)(`address`)) = `value`;" .}
    else:
        {.error: "Unhandled size" .}

proc volatileSetBits*[T](address: ptr T, bits: T) {.inline.} =
    var currValue = volatileLoad(address)
    volatileStore(address, currValue or bits)

proc volatileClrBits*[T](address: ptr T, bits: T) {.inline.} =
    var currValue = volatileLoad(address)
    volatileStore(address, currValue and (not bits))

proc volatileTestBits*[T](address: ptr T, bits: T) : bool {.inline.} =
    var currValue = volatileLoad(address)
    return (currValue and bits) == bits
