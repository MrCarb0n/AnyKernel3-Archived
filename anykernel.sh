# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string=|               VV • YYYYMMDD • HHMM               |
do.devicecheck=1
do.cleanup=1
do.cleanuponabort=1
device.name1=mido
supported.versions=10-11
supported.patchlevels=2021-01-
'; }
# end properties

# shell variables
block=/dev/block/platform/soc/7824900.sdhci/by-name/boot;
is_slot_device=0;
no_block_display=0;
ramdisk_compression=auto;

## AnyKernel methods (DO NOT CHANGE)
. tools/ak3-core.sh;

## Check kernel base compatibility for 4.9-mido //
ui_print " " "| - Checking OS kernel compatibility..             |";
if [ ! -f /vendor/etc/init/hw/init.msm.usb.configfs.rc ]; then
ui_print "    Incompatible OS, installation aborted!"; exit 1;
fi; ui_print "    Requirement reached.";

## AnyKernel boot install
dump_boot;

write_boot;
## end boot install

## remove predefined i/o scheduler properties if available by @MrCarb0n
PBP=/system/product/build.prop;
PROP=persist.sys.io.scheduler;
if [ "$(grep -c $PROP $PBP)" == "1" ]; then
mount -o rw,remount -t auto /system >/dev/null;
restore_file $PBP;
backup_file $PBP;
remove_line $PBP $PROP; fi;
