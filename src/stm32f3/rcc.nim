
import memmap

#
# RCC Registers
#

const RCC_CR*       = cast[ptr cuint](RCC_BASE + 0x00)
const RCC_CFGR*     = cast[ptr cuint](RCC_BASE + 0x04)
const RCC_CIR*      = cast[ptr cuint](RCC_BASE + 0x08)
const RCC_APB2RSTR* = cast[ptr cuint](RCC_BASE + 0x0C)
const RCC_APB1RSTR* = cast[ptr cuint](RCC_BASE + 0x10)
const RCC_AHBENR*   = cast[ptr cuint](RCC_BASE + 0x14)
const RCC_APB2ENR*  = cast[ptr cuint](RCC_BASE + 0x18)
const RCC_APB1ENR*  = cast[ptr cuint](RCC_BASE + 0x1C)
const RCC_BDCR*     = cast[ptr cuint](RCC_BASE + 0x20)
const RCC_CSR*      = cast[ptr cuint](RCC_BASE + 0x24)
const RCC_AHBRSTR*  = cast[ptr cuint](RCC_BASE + 0x28)
const RCC_CFGR2*    = cast[ptr cuint](RCC_BASE + 0x2C)
const RCC_CFGR3*    = cast[ptr cuint](RCC_BASE + 0x30)

#
# RCC_CR Values
#

const RCC_CR_PLLRDY* = (1 shl 25)
const RCC_CR_PLLON*  = (1 shl 24)
const RCC_CR_CSSON*  = (1 shl 19)
const RCC_CR_HSEBYP* = (1 shl 18)
const RCC_CR_HSERDY* = (1 shl 17)
const RCC_CR_HSEON*  = (1 shl 16)
#/* HSICAL: [15:8] */
#/* HSITRIM: [7:3] */
const RCC_CR_HSIRDY* : cuint = (1 shl 1)
const RCC_CR_HSION*  = (1 shl 0)

#
# RCC_CFGR
#

const RCC_CFGR_MCOF*     = (1 shl 28)
const RCC_CFGR_I2SSRC*   = (1 shl 23)
const RCC_CFGR_USBPRES*  = (1 shl 22)
const RCC_CFGR_PLLXTPRE* = (1 shl 17)
const RCC_CFGR_PLLSRC*   = (1 shl 16)

#/* MCO: Microcontroller clock output */
#define RCC_CFGR_MCO_SHIFT          24
#define RCC_CFGR_MCO_MASK           0x7
#define RCC_CFGR_MCO_DISABLED           0x0
#/*Reserve RCC_CFGR_MCO              0x1*/
#define RCC_CFGR_MCO_LSI            0x2
#define RCC_CFGR_MCO_LSE            0x3
#define RCC_CFGR_MCO_SYSCLK         0x4
#define RCC_CFGR_MCO_HSI            0x5
#define RCC_CFGR_MCO_HSE            0x6
#define RCC_CFGR_MCO_PLL            0x7

#/* PLLSRC: PLL source values */
const RCC_CFGR_PLLSRC_HSI_DIV2*   = 0
const RCC_CFGR_PLLSRC_HSE_PREDIV1* = 1

#/* PLLMUL: PLL multiplication factor */
#define RCC_CFGR_PLLMUL_SHIFT           18
#define RCC_CFGR_PLLMUL_MASK            0xF
#define RCC_CFGR_PLLMUL_PLL_IN_CLK_X2       0x0
#define RCC_CFGR_PLLMUL_PLL_IN_CLK_X3       0x1
#define RCC_CFGR_PLLMUL_PLL_IN_CLK_X4       0x2
#define RCC_CFGR_PLLMUL_PLL_IN_CLK_X5       0x3
#define RCC_CFGR_PLLMUL_PLL_IN_CLK_X6       0x4
#define RCC_CFGR_PLLMUL_PLL_IN_CLK_X7       0x5
#define RCC_CFGR_PLLMUL_PLL_IN_CLK_X8       0x6
#define RCC_CFGR_PLLMUL_PLL_IN_CLK_X9       0x7
#define RCC_CFGR_PLLMUL_PLL_IN_CLK_X10      0x8
#define RCC_CFGR_PLLMUL_PLL_IN_CLK_X11      0x9
#define RCC_CFGR_PLLMUL_PLL_IN_CLK_X12      0xA
#define RCC_CFGR_PLLMUL_PLL_IN_CLK_X13      0xB
#define RCC_CFGR_PLLMUL_PLL_IN_CLK_X14      0xC
#define RCC_CFGR_PLLMUL_PLL_IN_CLK_X15      0xD
#define RCC_CFGR_PLLMUL_PLL_IN_CLK_X16      0xE

#/* PPRE2: APB high-speed prescaler (APB2) */
#define RCC_CFGR_PPRE2_SHIFT            11
#define RCC_CFGR_PPRE2_MASK         0x7
#/* 0XX: HCLK not divided */
const RCC_CFGR_PPRE2_DIV_1*    = 0x0
const RCC_CFGR_PPRE2_DIV_2*    = 0x4
const RCC_CFGR_PPRE2_DIV_4*    = 0x5
const RCC_CFGR_PPRE2_DIV_8*    = 0x6
const RCC_CFGR_PPRE2_DIV_16*   = 0x7

#/* PPRE1:APB Low-speed prescaler (APB1) */
#define RCC_CFGR_PPRE1_SHIFT            8
#define RCC_CFGR_PPRE1_MASK         0x7
#/* 0XX: HCLK not divided */
const RCC_CFGR_PPRE1_DIV_1*    = 0x0
const RCC_CFGR_PPRE1_DIV_2*    = 0x4
const RCC_CFGR_PPRE1_DIV_4*    = 0x5
const RCC_CFGR_PPRE1_DIV_8*    = 0x6
const RCC_CFGR_PPRE1_DIV_16*   = 0x7

#/* HPRE: HLCK prescaler */
#define RCC_CFGR_HPRE_SHIFT         4
#define RCC_CFGR_HPRE_MASK          0xf
#/* 0XXX: SYSCLK not divided */
const RCC_CFGR_HPRE_DIV_1*     = 0x0
const RCC_CFGR_HPRE_DIV_2*     = 0x8
const RCC_CFGR_HPRE_DIV_4*     = 0x9
const RCC_CFGR_HPRE_DIV_8*     = 0xA
const RCC_CFGR_HPRE_DIV_16*    = 0xB
const RCC_CFGR_HPRE_DIV_64*    = 0xC
const RCC_CFGR_HPRE_DIV_128*   = 0xD
const RCC_CFGR_HPRE_DIV_256*   = 0xE
const RCC_CFGR_HPRE_DIV_512*   = 0xF

#/* SWS: System clock switch status */
#define RCC_CFGR_SWS_SHIFT          2
#define RCC_CFGR_SWS_HSI            0x0
#define RCC_CFGR_SWS_HSE            0x1
#define RCC_CFGR_SWS_PLL            0x2

#/* SW: System clock switch */
#define RCC_CFGR_SW_SHIFT           0
#define RCC_CFGR_SW_HSI             0x0
#define RCC_CFGR_SW_HSE             0x1
#define RCC_CFGR_SW_PLL             0x2
