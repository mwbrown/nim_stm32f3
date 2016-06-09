
import stm32f3.rcc
import stm32f3.ptr_macros

const HSE_STARTUP_TIMEOUT = 0x500

proc rcc_pll_init*() : bool =

    # Enable the HSE register.
    volatileSetBits(RCC_CR, RCC_CR_HSEON)

    var startup_ctr = HSE_STARTUP_TIMEOUT
    while startup_ctr > 0:
        if volatileTestBits(RCC_CR, RCC_CR_HSERDY):
            break
        startup_ctr -= 1

    # Determine if the HSE timed out becoming ready.
    if startup_ctr == 0:
        return false

    # Enable prefetch buffer and set Flash latency.
    #volatileSetBits(FLASH_ACR, FLASH_ACR_PRFTBE or FLASH_ACR_LATENCY_1)

    # Set HCLK, PCLK2, PCLK1
    volatileSetBits(RCC_CFGR, RCC_CFGR_HPRE_DIV1 or RCC_CFGR_PPRE2_DIV1 or RCC_CFGR_PPRE1_DIV2)

    # Set PLL Configuration
    #volatileClrBits(RCC_CFGR, RCC_CFGR_PLLSRC or RCC_CFGR_PLLXTPRE or RCC_CFGR_PLLMULL)
    #volatileSetBits(RCC_CFGR, RCC_CFGR_PLLSRC_PREDIV1 or RCC_CFGR_PLLXTPRE_PREDIV1 or RCC_CFGR_PLLMULL9)

    # Enable PLL.
    volatileSetBits(RCC_CR, RCC_CR_PLLON)

    # Wait until PLL is ready.
    while not volatileTestBits(RCC_CR, RCC_CR_PLLRDY):
        discard

    # Use the PLL as the system clock source.
    #volatileClrBits(RCC_CFGR, RCC_CFGR_SW)
    #volatileSetBits(RCC_CFGR, RCC_CFGR_SW_PLL)

    # Wait until the PLL is the active clock.
    #while (volatileLoad(RCC_CFGR) and RCC_CFGR_SWS) != RCC_CFGR_SWS_PLL:
    #    discard

    return true
