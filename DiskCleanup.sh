#!/bin/sh

#empty tardis-tmp folders
echo "[DISK CLEANUP] Choose tardis-tmp folder:"
echo " ---------------------------- "
echo "| 1)  ALL TARDIS_TMP FOLDERS |"
echo "| 2)  AUTHZFORCE             |"
echo "| 3)  BCEL                   |"
echo "| 4)  DUBBO                  |"
echo "| 5)  FASTJSON               |"
echo "| 6)  FESCAR                 |"
echo "| 7)  GSON                   |"
echo "| 8)  GUAVA                  |"
echo "| 9)  IMAGE                  |"
echo "| 10) JSOUP                  |"
echo "| 11) JXPATH                 |"
echo "| 12) LA4J                   |"
echo "| 13) OKHTTP                 |"
echo "| 14) OKIO                   |"
echo "| 15) PDFBOX                 |"
echo "| 16) RE2J                   |"
echo "| 17) SPOON                  |"
echo "| 18) WEBMAGIC               |"
echo "| 19) ZXING                  |"
echo " ---------------------------- "
read input

echo "[DISK CLEANUP] Tipe \"YES\" to empty tardis-tmp folders"
read confirmation

if [ $confirmation == "YES" ]; then
	if [ $input == "2" ] || [ $input == "1" ]; then
		rm -rf core-release-13.3.0/tardis-tmp && mkdir $_ && echo "[DISK CLEANUP] $_ cleaned" || echo "[DISK CLEANUP] $_: Failed"
	fi
	if [ $input == "3" ] || [ $input == "1" ]; then
		rm -rf bcel-6.0-src/tardis-tmp && mkdir $_ && echo "[DISK CLEANUP] $_ cleaned" || echo "[DISK CLEANUP] $_: Failed"
	fi
	if [ $input == "4" ] || [ $input == "1" ]; then
		rm -rf dubbo/tardis-tmp && mkdir $_ && echo "[DISK CLEANUP] $_ cleaned" || echo "[DISK CLEANUP] $_: Failed"
	fi
	if [ $input == "5" ] || [ $input == "1" ]; then
		rm -rf fastjson/tardis-tmp && mkdir $_ && echo "[DISK CLEANUP] $_ cleaned" || echo "[DISK CLEANUP] $_: Failed"
	fi
	if [ $input == "6" ] || [ $input == "1" ]; then
		rm -rf fescar/tardis-tmp && mkdir $_ && echo "[DISK CLEANUP] $_ cleaned" || echo "[DISK CLEANUP] $_: Failed"
	fi
	if [ $input == "7" ] || [ $input == "1" ]; then
		rm -rf gson/tardis-tmp && mkdir $_ && echo "[DISK CLEANUP] $_ cleaned" || echo "[DISK CLEANUP] $_: Failed"
	fi
	if [ $input == "8" ] || [ $input == "1" ]; then
		rm -rf guava/tardis-tmp && mkdir $_ && echo "[DISK CLEANUP] $_ cleaned" || echo "[DISK CLEANUP] $_: Failed"
	fi
	if [ $input == "9" ] || [ $input == "1" ]; then
		rm -rf commons-imaging/tardis-tmp && mkdir $_ && echo "[DISK CLEANUP] $_ cleaned" || echo "[DISK CLEANUP] $_: Failed"
	fi
	if [ $input == "10" ] || [ $input == "1" ]; then
		rm -rf jsoup/tardis-tmp && mkdir $_ && echo "[DISK CLEANUP] $_ cleaned" || echo "[DISK CLEANUP] $_: Failed"
	fi
	if [ $input == "11" ] || [ $input == "1" ]; then
		rm -rf commons-jxpath-1.3-src/tardis-tmp && mkdir $_ && echo "[DISK CLEANUP] $_ cleaned" || echo "[DISK CLEANUP] $_: Failed"
	fi
	if [ $input == "12" ] || [ $input == "1" ]; then
		rm -rf la4j-0.6.0/tardis-tmp && mkdir $_ && echo "[DISK CLEANUP] $_ cleaned" || echo "[DISK CLEANUP] $_: Failed"
	fi
	if [ $input == "13" ] || [ $input == "1" ]; then
		rm -rf okhttp/tardis-tmp && mkdir $_ && echo "[DISK CLEANUP] $_ cleaned" || echo "[DISK CLEANUP] $_: Failed"
	fi
	if [ $input == "14" ] || [ $input == "1" ]; then
		rm -rf okio/tardis-tmp && mkdir $_ && echo "[DISK CLEANUP] $_ cleaned" || echo "[DISK CLEANUP] $_: Failed"
	fi
	if [ $input == "15" ] || [ $input == "1" ]; then
		rm -rf pdfbox/tardis-tmp && mkdir $_ && echo "[DISK CLEANUP] $_ cleaned" || echo "[DISK CLEANUP] $_: Failed"
	fi
	if [ $input == "16" ] || [ $input == "1" ]; then
		rm -rf re2j/tardis-tmp && mkdir $_ && echo "[DISK CLEANUP] $_ cleaned" || echo "[DISK CLEANUP] $_: Failed"
	fi
	if [ $input == "17" ] || [ $input == "1" ]; then
		rm -rf spoon/tardis-tmp && mkdir $_ && echo "[DISK CLEANUP] $_ cleaned" || echo "[DISK CLEANUP] $_: Failed"
	fi
	if [ $input == "18" ] || [ $input == "1" ]; then
		rm -rf webmagic/tardis-tmp && mkdir $_ && echo "[DISK CLEANUP] $_ cleaned" || echo "[DISK CLEANUP] $_: Failed"
	fi
	if [ $input == "19" ] || [ $input == "1" ]; then
		rm -rf zxing/tardis-tmp && mkdir $_ && echo "[DISK CLEANUP] $_ cleaned" || echo "[DISK CLEANUP] $_: Failed"
	fi
fi
