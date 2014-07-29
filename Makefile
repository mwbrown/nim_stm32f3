
NIMFILE=src/main.nim
PROJECT=nimrod_stm32

CFLAGS:=
CLIBS:=
CLIBDIRS:=

#
# Do not modify below this line.
#

CLIBDIRS  += -Llibopencm3/lib
CLIBS     += -lopencm3_stm32f3
LD_SCRIPT := stm32f303vct6.ld

CFLAGS    += -Wl,-gc-sections,-T,$(LD_SCRIPT)
CFLAGS    += --static -nostartfiles

.PHONY: clean all

all: $(PROJECT).bin

clean:
	rm -rf nimcache
	rm -r $(PROJECT).bin $(PROJECT).elf

$(PROJECT).elf: $(NIMFILE) nimrod.cfg
	nimrod c --nimcache=$(CURDIR)/nimcache $(NIMFILE)
	arm-none-eabi-gcc $(CFLAGS) -o $@ nimcache/*.o $(CLIBDIRS) $(CLIBS)

%.bin: %.elf
	arm-none-eabi-objcopy $< -O binary $@
