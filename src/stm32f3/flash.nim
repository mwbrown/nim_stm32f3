
import memmap

const FLASH_ACR     = cast[ptr cuint](FLASH_MEM_INTERFACE_BASE + 0x00)
const FLASH_KEYR    = cast[ptr cuint](FLASH_MEM_INTERFACE_BASE + 0x04)
const FLASH_OPTKEYR = cast[ptr cuint](FLASH_MEM_INTERFACE_BASE + 0x08)
const FLASH_SR      = cast[ptr cuint](FLASH_MEM_INTERFACE_BASE + 0x0C)
const FLASH_CR      = cast[ptr cuint](FLASH_MEM_INTERFACE_BASE + 0x10)
const FLASH_AR      = cast[ptr cuint](FLASH_MEM_INTERFACE_BASE + 0x14)
const FLASH_OBR     = cast[ptr cuint](FLASH_MEM_INTERFACE_BASE + 0x1C)
const FLASH_WRPR    = cast[ptr cuint](FLASH_MEM_INTERFACE_BASE + 0x20)

#define FLASH_ACR_LATENCY_0WS       0x00
#define FLASH_ACR_LATENCY_1WS       0x01
#define FLASH_ACR_LATENCY_2WS       0x02
#define FLASH_ACR_LATENCY_3WS       0x03
#define FLASH_ACR_LATENCY_4WS       0x04
#define FLASH_ACR_LATENCY_5WS       0x05
#define FLASH_ACR_LATENCY_6WS       0x06
#define FLASH_ACR_LATENCY_7WS       0x07

#define FLASH_KEYR_KEY1         ((uint32_t)0x45670123)
#define FLASH_KEYR_KEY2         ((uint32_t)0xcdef89ab)


#define FLASH_ACR_PRFTBS        (1 << 5)
#define FLASH_ACR_PRFTBE        (1 << 4)
#define FLASH_ACR_HLFCYA        (1 << 3)

#define FLASH_SR_BSY            (1 << 0)
#define FLASH_SR_ERLYBSY        (1 << 1)
#define FLASH_SR_PGPERR         (1 << 2)
#define FLASH_SR_WRPRTERR       (1 << 4)
#define FLASH_SR_EOP            (1 << 5)

#define FLASH_CR_OBL_LAUNCH     (1 << 13)
#define FLASH_CR_EOPIE          (1 << 12)
#define FLASH_CR_ERRIE          (1 << 10)
#define FLASH_CR_OPTWRE         (1 << 9)
#define FLASH_CR_LOCK           (1 << 7)
#define FLASH_CR_STRT           (1 << 6)
#define FLASH_CR_OPTER          (1 << 5)
#define FLASH_CR_OPTPG          (1 << 4)
#define FLASH_CR_MER            (1 << 2)
#define FLASH_CR_PER            (1 << 1)
#define FLASH_CR_PG         (1 << 0)
