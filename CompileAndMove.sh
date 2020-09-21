#!/bin/sh

#Compile all TARDIS runner
cd RunFiles
echo "[COMPILE AND MOVE SCRIPT] Compiling all Run files..."
for f in *.java
do
	javac -cp /home/ubuntu/tardisFolder/tardisProva/tardis/master/build/libs/tardis-master-0.2.0-SNAPSHOT.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/runtime/build/libs/sushi-lib-0.2.0-SNAPSHOT.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/jbse/build/libs/jbse-0.10.0-SNAPSHOT-shaded.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/args4j/args4j/2.32/1ccacebdf8f2db750eb09a402969050f27695fb7/args4j-2.32.jar:/usr/lib/jvm/java-8-openjdk-amd64/lib/tools.jar $f && echo "[COMPILE AND MOVE SCRIPT] $f compiled" || echo "[COMPILE AND MOVE SCRIPT] $f: Failed"
done
cd ..

#Move TARDIS runner to the benchmark folders
echo "[COMPILE AND MOVE SCRIPT] Moving all Run files..."
#Authzforce
if [ -d core-release-13.3.0 ]; then
	mkdir core-release-13.3.0/pdp-engine/target/classes/settings; mv RunFiles/RunAuthzforce1.class $_ && echo "[COMPILE AND MOVE SCRIPT] Moved RunAuthzforce1.class to $_" || echo "[COMPILE AND MOVE SCRIPT] Failed"
fi

#Dubbo
if [ -d dubbo ]; then
	mkdir dubbo/dubbo-common/target/classes/settings; mv RunFiles/RunDubbo.class $_ && echo "[COMPILE AND MOVE SCRIPT] Moved RunDubbo.class to $_" || echo "[COMPILE AND MOVE SCRIPT] Failed"
fi

#Okio
if [ -d okio ]; then
	mkdir okio/okio/target/classes/settings; mv RunFiles/RunOkio.class $_ && echo "[COMPILE AND MOVE SCRIPT] Moved RunOkio.class to $_" || echo "[COMPILE AND MOVE SCRIPT] Failed"
fi

#Zxing
if [ -d zxing ]; then
	mkdir zxing/core/target/classes/settings; mv RunFiles/RunZxing.class $_ && echo "[COMPILE AND MOVE SCRIPT] Moved RunZxing.class to $_" || echo "[COMPILE AND MOVE SCRIPT] Failed"
fi

#WebMagic
if [ -d webmagic ]; then
	mkdir webmagic/webmagic-core/target/classes/settings; mv RunFiles/RunWebmagic2_3_4.class $_ && echo "[COMPILE AND MOVE SCRIPT] Moved RunWebmagic2_3_4.class to $_" || echo "[COMPILE AND MOVE SCRIPT] Failed"
	mkdir webmagic/webmagic-extension/target/classes/settings; mv RunFiles/RunWebmagic1_5.class $_ && echo "[COMPILE AND MOVE SCRIPT] Moved RunWebmagic1_5.class to $_" || echo "[COMPILE AND MOVE SCRIPT] Failed"
fi

#FastJson
if [ -d fastjson ]; then
	mkdir fastjson/target/classes/settings; mv RunFiles/RunFastjson.class $_ && echo "[COMPILE AND MOVE SCRIPT] Moved RunFastjson.class to $_" || echo "[COMPILE AND MOVE SCRIPT] Failed"
fi

#Jsoup
if [ -d jsoup ]; then
	mkdir jsoup/target/classes/settings; mv RunFiles/RunJsoup.class $_ && echo "[COMPILE AND MOVE SCRIPT] Moved RunRunJsoup.class to $_" || echo "[COMPILE AND MOVE SCRIPT] Failed"
fi

#Bcel
if [ -d bcel-6.0-src ]; then
	mkdir bcel-6.0-src/target/classes/settings; mv RunFiles/RunBcel.class $_ && echo "[COMPILE AND MOVE SCRIPT] Moved RunBcel.class to $_" || echo "[COMPILE AND MOVE SCRIPT] Failed"
fi

#Gson
if [ -d gson ]; then
	mkdir gson/gson/target/classes/settings; mv RunFiles/RunGson.class $_ && echo "[COMPILE AND MOVE SCRIPT] Moved RunGson.class to $_" || echo "[COMPILE AND MOVE SCRIPT] Failed"
fi

#Image
if [ -d commons-imaging ]; then
	mkdir commons-imaging/target/classes/settings; mv RunFiles/RunImage.class $_ && echo "[COMPILE AND MOVE SCRIPT] Moved RunImage.class to $_" || echo "[COMPILE AND MOVE SCRIPT] Failed"
fi

#Jxpath
if [ -d commons-jxpath-1.3-src ]; then
	mkdir commons-jxpath-1.3-src/target/classes/settings; mv RunFiles/RunJxpath.class $_ && echo "[COMPILE AND MOVE SCRIPT] Moved RunJxpath.class to $_" || echo "[COMPILE AND MOVE SCRIPT] Failed"
fi

#La4j
if [ -d la4j-0.6.0 ]; then
	mkdir la4j-0.6.0/target/classes/settings; mv RunFiles/RunLa4j.class $_ && echo "[COMPILE AND MOVE SCRIPT] Moved RunLa4j.class to $_" || echo "[COMPILE AND MOVE SCRIPT] Failed"
fi

#Re2j
if [ -d re2j ]; then
	mkdir re2j/target/classes/settings; mv RunFiles/RunRe2j.class $_ && echo "[COMPILE AND MOVE SCRIPT] Moved RunRe2j.class to $_" || echo "[COMPILE AND MOVE SCRIPT] Failed"
fi

#Okhttp
if [ -d okhttp ]; then
	mkdir okhttp/okhttp/target/classes/settings; mv RunFiles/RunOkhttp.class $_ && echo "[COMPILE AND MOVE SCRIPT] Moved RunOkhttp.class to $_" || echo "[COMPILE AND MOVE SCRIPT] Failed"
fi

#Fescar
if [ -d fescar ]; then
	mkdir fescar/core/target/classes/settings; mv RunFiles/RunFescar.class $_ && echo "[COMPILE AND MOVE SCRIPT] Moved RunFescar.class to $_" || echo "[COMPILE AND MOVE SCRIPT] Failed"
fi

#Spoon
if [ -d spoon ]; then
	mkdir spoon/target/classes/settings; mv RunFiles/RunSpoon.class $_ && echo "[COMPILE AND MOVE SCRIPT] Moved RunSpoon.class to $_" || echo "[COMPILE AND MOVE SCRIPT] Failed"
fi

#Guava
if [ -d guava ]; then
	mkdir guava/guava/target/classes/settings; mv RunFiles/RunGuava.class $_ && echo "[COMPILE AND MOVE SCRIPT] Moved RunGuava.class to $_" || echo "[COMPILE AND MOVE SCRIPT] Failed"
fi

#Pdfbox
if [ -d pdfbox ]; then
	mkdir pdfbox/pdfbox/target/classes/settings; mv RunFiles/RunPdfbox.class $_ && echo "[COMPILE AND MOVE SCRIPT] Moved RunPdfbox.class to $_" || echo "[COMPILE AND MOVE SCRIPT] Failed"
fi