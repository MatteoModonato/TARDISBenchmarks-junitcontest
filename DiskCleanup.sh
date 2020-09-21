#!/bin/sh

#empty all tardis-tmp folders
echo "[DISK CLEANUP] Tipe \"YES\" to empty all tardis-tmp folders"
read confirmation

if [ $confirmation == "YES" ]; then
rm -rf core-release-13.3.0/tardis-tmp && mkdir $_ && echo "[DISK CLEANUP] $_ cleaned" || echo "[DISK CLEANUP] $_: Failed"
rm -rf bcel-6.0-src/tardis-tmp && mkdir $_ && echo "[DISK CLEANUP] $_ cleaned" || echo "[DISK CLEANUP] $_: Failed"
rm -rf dubbo/tardis-tmp && mkdir $_ && echo "[DISK CLEANUP] $_ cleaned" || echo "[DISK CLEANUP] $_: Failed"
rm -rf fastjson/tardis-tmp && mkdir $_ && echo "[DISK CLEANUP] $_ cleaned" || echo "[DISK CLEANUP] $_: Failed"
rm -rf fescar/tardis-tmp && mkdir $_ && echo "[DISK CLEANUP] $_ cleaned" || echo "[DISK CLEANUP] $_: Failed"
rm -rf gson/tardis-tmp && mkdir $_ && echo "[DISK CLEANUP] $_ cleaned" || echo "[DISK CLEANUP] $_: Failed"
rm -rf guava/tardis-tmp && mkdir $_ && echo "[DISK CLEANUP] $_ cleaned" || echo "[DISK CLEANUP] $_: Failed"
rm -rf commons-imaging/tardis-tmp && mkdir $_ && echo "[DISK CLEANUP] $_ cleaned" || echo "[DISK CLEANUP] $_: Failed"
rm -rf jsoup/tardis-tmp && mkdir $_ && echo "[DISK CLEANUP] $_ cleaned" || echo "[DISK CLEANUP] $_: Failed"
rm -rf commons-jxpath-1.3-src/tardis-tmp && mkdir $_ && echo "[DISK CLEANUP] $_ cleaned" || echo "[DISK CLEANUP] $_: Failed"
rm -rf la4j-0.6.0/tardis-tmp && mkdir $_ && echo "[DISK CLEANUP] $_ cleaned" || echo "[DISK CLEANUP] $_: Failed"
rm -rf okhttp/tardis-tmp && mkdir $_ && echo "[DISK CLEANUP] $_ cleaned" || echo "[DISK CLEANUP] $_: Failed"
rm -rf okio/tardis-tmp && mkdir $_ && echo "[DISK CLEANUP] $_ cleaned" || echo "[DISK CLEANUP] $_: Failed"
rm -rf pdfbox/tardis-tmp && mkdir $_ && echo "[DISK CLEANUP] $_ cleaned" || echo "[DISK CLEANUP] $_: Failed"
rm -rf re2j/tardis-tmp && mkdir $_ && echo "[DISK CLEANUP] $_ cleaned" || echo "[DISK CLEANUP] $_: Failed"
rm -rf spoon/tardis-tmp && mkdir $_ && echo "[DISK CLEANUP] $_ cleaned" || echo "[DISK CLEANUP] $_: Failed"
rm -rf webmagic/tardis-tmp && mkdir $_ && echo "[DISK CLEANUP] $_ cleaned" || echo "[DISK CLEANUP] $_: Failed"
rm -rf zxing/tardis-tmp && mkdir $_ && echo "[DISK CLEANUP] $_ cleaned" || echo "[DISK CLEANUP] $_: Failed"
fi