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

echo "[DISK CLEANUP] Move or Delete?"
echo " ---------------------------- "
echo "| 1)  MOVE FOLDERS           |"
echo "| 2)  DELETE FOLDERS         |"
echo " ---------------------------- "
read mode

if [ $mode == "1" ]; then
	if [ $input == "2" ] || [ $input == "1" ]; then
		mkdir -p core-release-13.3.0/tardis-tmp/old
		for d in core-release-13.3.0/tardis-tmp/*/; do
			if [ $d != "core-release-13.3.0/tardis-tmp/old/" ]; then
				mv -v $d core-release-13.3.0/tardis-tmp/old
			fi
		done
	fi
	if [ $input == "3" ] || [ $input == "1" ]; then
		mkdir -p bcel-6.0-src/tardis-tmp/old
		for d in bcel-6.0-src/tardis-tmp/*/; do
			if [ $d != "bcel-6.0-src/tardis-tmp/old/" ]; then
				mv -v $d bcel-6.0-src/tardis-tmp/old
			fi
		done
	fi
	if [ $input == "4" ] || [ $input == "1" ]; then
		mkdir -p dubbo/tardis-tmp/old
		for d in dubbo/tardis-tmp/*/; do
			if [ $d != "dubbo/tardis-tmp/old/" ]; then
				mv -v $d dubbo/tardis-tmp/old
			fi
		done
	fi
	if [ $input == "5" ] || [ $input == "1" ]; then
		mkdir -p fastjson/tardis-tmp/old
		for d in fastjson/tardis-tmp/*/; do
			if [ $d != "fastjson/tardis-tmp/old/" ]; then
				mv -v $d fastjson/tardis-tmp/old
			fi
		done
	fi
	if [ $input == "6" ] || [ $input == "1" ]; then
		mkdir -p fescar/tardis-tmp/old
		for d in fescar/tardis-tmp/*/; do
			if [ $d != "fescar/tardis-tmp/old/" ]; then
				mv -v $d fescar/tardis-tmp/old
			fi
		done
	fi
	if [ $input == "7" ] || [ $input == "1" ]; then
		mkdir -p gson/tardis-tmp/old
		for d in gson/tardis-tmp/*/; do
			if [ $d != "gson/tardis-tmp/old/" ]; then
				mv -v $d gson/tardis-tmp/old
			fi
		done
	fi
	if [ $input == "8" ] || [ $input == "1" ]; then
		mkdir -p guava/tardis-tmp/old
		for d in guava/tardis-tmp/*/; do
			if [ $d != "guava/tardis-tmp/old/" ]; then
				mv -v $d guava/tardis-tmp/old
			fi
		done
	fi
	if [ $input == "9" ] || [ $input == "1" ]; then
		mkdir -p commons-imaging/tardis-tmp/old
		for d in commons-imaging/tardis-tmp/*/; do
			if [ $d != "commons-imaging/tardis-tmp/old/" ]; then
				mv -v $d commons-imaging/tardis-tmp/old
			fi
		done
	fi
	if [ $input == "10" ] || [ $input == "1" ]; then
		mkdir -p jsoup/tardis-tmp/old
		for d in jsoup/tardis-tmp/*/; do
			if [ $d != "jsoup/tardis-tmp/old/" ]; then
				mv -v $d jsoup/tardis-tmp/old
			fi
		done
	fi
	if [ $input == "11" ] || [ $input == "1" ]; then
		mkdir -p commons-jxpath-1.3-src/tardis-tmp/old
		for d in commons-jxpath-1.3-src/tardis-tmp/*/; do
			if [ $d != "commons-jxpath-1.3-src/tardis-tmp/old/" ]; then
				mv -v $d commons-jxpath-1.3-src/tardis-tmp/old
			fi
		done
	fi
	if [ $input == "12" ] || [ $input == "1" ]; then
		mkdir -p la4j-0.6.0/tardis-tmp/old
		for d in la4j-0.6.0/tardis-tmp/*/; do
			if [ $d != "la4j-0.6.0/tardis-tmp/old/" ]; then
				mv -v $d la4j-0.6.0/tardis-tmp/old
			fi
		done
	fi
	if [ $input == "13" ] || [ $input == "1" ]; then
		mkdir -p okhttp/tardis-tmp/old
		for d in okhttp/tardis-tmp/*/; do
			if [ $d != "okhttp/tardis-tmp/old/" ]; then
				mv -v $d okhttp/tardis-tmp/old
			fi
		done
	fi
	if [ $input == "14" ] || [ $input == "1" ]; then
		mkdir -p okio/tardis-tmp/old
		for d in okio/tardis-tmp/*/; do
			if [ $d != "okio/tardis-tmp/old/" ]; then
				mv -v $d okio/tardis-tmp/old
			fi
		done
	fi
	if [ $input == "15" ] || [ $input == "1" ]; then
		mkdir -p pdfbox/tardis-tmp/old
		for d in pdfbox/tardis-tmp/*/; do
			if [ $d != "pdfbox/tardis-tmp/old/" ]; then
				mv -v $d pdfbox/tardis-tmp/old
			fi
		done
	fi
	if [ $input == "16" ] || [ $input == "1" ]; then
		mkdir -p re2j/tardis-tmp/old
		for d in re2j/tardis-tmp/*/; do
			if [ $d != "re2j/tardis-tmp/old/" ]; then
				mv -v $d re2j/tardis-tmp/old
			fi
		done
	fi
	if [ $input == "17" ] || [ $input == "1" ]; then
		mkdir -p spoon/tardis-tmp/old
		for d in spoon/tardis-tmp/*/; do
			if [ $d != "spoon/tardis-tmp/old/" ]; then
				mv -v $d spoon/tardis-tmp/old
			fi
		done
	fi
	if [ $input == "18" ] || [ $input == "1" ]; then
		mkdir -p webmagic/tardis-tmp/old
		for d in webmagic/tardis-tmp/*/; do
			if [ $d != "webmagic/tardis-tmp/old/" ]; then
				mv -v $d webmagic/tardis-tmp/old
			fi
		done
	fi
	if [ $input == "19" ] || [ $input == "1" ]; then
		mkdir -p zxing/tardis-tmp/old
		for d in zxing/tardis-tmp/*/; do
			if [ $d != "zxing/tardis-tmp/old/" ]; then
				mv -v $d zxing/tardis-tmp/old
			fi
		done
	fi
fi

if [ $mode == "2" ]; then
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
fi
