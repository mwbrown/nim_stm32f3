
NIMFILE=src/main.nim

NIMDEPS:=

NIMDEPS +=                   \
	src/panicoverride.nim    \
	src/rcc_pll.nim          \
	src/stm32f3/rcc.nim      \
	src/stm32f3/memmap.nim   \
	src/stm32f3/ptr_macros.nim

PROJECT=nim_stm32

CFLAGS:=
CLIBS:=
CLIBDIRS:=

#
# Do not modify below this line.
#

OCM3_DIR  := ./libopencm3
OCM3_LIB  := opencm3_stm32f3

CLIBDIRS  += -L$(OCM3_DIR)/lib
CLIBS     += -l$(OCM3_LIB)
LD_SCRIPT := stm32f303vct6.ld


CFLAGS    += -Wl,-gc-sections,-T,$(LD_SCRIPT)
CFLAGS    += -mcpu=cortex-m4 -mthumb -mfloat-abi=hard -mfpu=fpv4-sp-d16

.PHONY: clean all

all: $(PROJECT).bin

clean:
	rm -rf nimcache
	rm -f $(PROJECT).bin $(PROJECT).elf

$(PROJECT).elf: $(NIMFILE) $(NIMDEPS) $(OCM3_DIR)/lib/lib$(OCM3_LIB).a nim.cfg
	nim c --nimcache=$(CURDIR)/nimcache $(NIMFILE)
	arm-none-eabi-gcc $(CFLAGS) -o $@ nimcache/*.o $(CLIBDIRS) $(CLIBS)

$(OCM3_DIR)/lib/lib$(OCM3_LIB).a:
	$(MAKE) -C $(OCM3_DIR)

%.bin: %.elf
	arm-none-eabi-objcopy $< -O binary $@
