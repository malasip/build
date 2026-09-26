# Allwinner T113-i dual core 512MB RAM SoC 32GB eMMC WiFi GBE
BOARD_NAME="Creality K2 Pro"
BOARD_VENDOR="creality"
BOARDFAMILY="sun8i"
BOARD_MAINTAINER="Sibis <mika.ala-sippola@outlook.com>"
INTRODUCED="2026"
BOOTCONFIG="mangopi_mq_r_defconfig"
BOOT_FDT_FILE="allwinner/sun8i-creality-k2pro-t113i.dtb"
BOOTFS_TYPE="fat"
BOOTSIZE="128"
DEFAULT_OVERLAYS="analog-codec"
SERIALCON="ttyS0"
KERNEL_TARGET="current,edge"
KERNEL_TEST_TARGET="current"
declare -g KERNEL_BTF="no"
ARCH="arm"
LINUXFAMILY="sunxi"

PACKAGE_LIST_BOARD="bluez bluez-tools rfkill wireless-regdb i2c-tools evtest"

# AIC8800 WiFi
AIC8800_TYPE="sdio"
enable_extension "radxa-aic8800"

function post_family_tweaks_bsp__aic8800_wireless() {
	display_alert "$BOARD" "Installing AIC8800 Tweaks" "info"
	mkdir -p "${destination}"/etc/modprobe.d
	mkdir -p "${destination}"/etc/modules-load.d
	cat > "${destination}"/etc/modprobe.d/aic8800.conf <<- EOT
		options aic8800_bsp_sdio aic_fw_path=/lib/firmware/aic8800_fw/SDIO/aic8800DC
		options aic8800_bsp aic_fw_path=/lib/firmware/aic8800_fw/SDIO/aic8800DC
		options aic8800_fdrv_sdio aicwf_dbg_level=0 custregd=0 ps_on=0
		options aic8800_fdrv aicwf_dbg_level=0 custregd=0 ps_on=0
	EOT
	cat > "${destination}"/etc/modules-load.d/aic8800.conf <<- EOT
		aic8800_bsp_sdio
		aic8800_fdrv_sdio
	EOT
}
