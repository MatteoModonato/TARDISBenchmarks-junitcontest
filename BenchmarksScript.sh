#!/bin/sh

echo "[SHELL SCRIPT] STARTING at $(date)"

#Unzip all benchmarks?
echo "[SHELL SCRIPT] Unzip all benchmarks? [y]es , [n]o"
read UnzipBenchmarks
if [ $UnzipBenchmarks == "y" ]; then
	echo "[SHELL SCRIPT] Unzipping all benchmarks..."
	for z in *.zip
	do
		if [ $z == "zxingSplit.zip" ]; then
			cat zxingSplit.z01 zxingSplit.zip > zxing_joined.zip && unzip zxing_joined.zip && echo "[SHELL SCRIPT] $z unzipped" || echo "[SHELL SCRIPT] $z: Failed"
		else
			unzip $z && echo "[SHELL SCRIPT] $z unzipped" || echo "[SHELL SCRIPT] $z: Failed"
		fi
	done
fi

#Compile all benchmarks?
echo "[SHELL SCRIPT] Compile all benchmarks? [y]es , [n]o"
read CompileBenchmarks
if [ $CompileBenchmarks == "y" ]; then
	echo "[SHELL SCRIPT] Compiling all benchmarks..."
	for d in */
	do
		if [ $d != "RunFiles/" ]; then
    		cd $d && mvn compile && echo "[SHELL SCRIPT] $d compiled" || echo "[SHELL SCRIPT] $d: Failed"
    		cd .. 
    	fi
	done
fi

#Compile all TARDIS runner
cd RunFiles
echo "[SHELL SCRIPT] Compiling all Run files..."
for f in *.java
do
	javac -cp /home/ubuntu/tardisFolder/tardisProva/tardis/master/build/libs/tardis-master-0.2.0-SNAPSHOT.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/runtime/build/libs/sushi-lib-0.2.0-SNAPSHOT.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/jbse/build/libs/jbse-0.10.0-SNAPSHOT-shaded.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/args4j/args4j/2.32/1ccacebdf8f2db750eb09a402969050f27695fb7/args4j-2.32.jar:/usr/lib/jvm/java-8-openjdk-amd64/lib/tools.jar $f && echo "[SHELL SCRIPT] $f compiled" || echo "[SHELL SCRIPT] $f: Failed"
done
cd ..

#Move TARDIS runner to the benchmark folders
echo "[SHELL SCRIPT] Moving all Run files..."
#Authzforce
if [ -d core-release-13.3.0 ]; then
	mkdir core-release-13.3.0/pdp-engine/target/classes/settings; mv RunFiles/RunAuthzforce1.class $_ && echo "[SHELL SCRIPT] Moved RunAuthzforce1.class to $_" || echo "[SHELL SCRIPT] Failed"
fi

#Dubbo
if [ -d dubbo ]; then
	mkdir dubbo/dubbo-common/target/classes/settings; mv RunFiles/RunDubbo.class $_ && echo "[SHELL SCRIPT] Moved RunDubbo.class to $_" || echo "[SHELL SCRIPT] Failed"
fi

#Okio
if [ -d okio ]; then
	mkdir okio/okio/target/classes/settings; mv RunFiles/RunOkio.class $_ && echo "[SHELL SCRIPT] Moved RunOkio.class to $_" || echo "[SHELL SCRIPT] Failed"
fi

#Zxing
if [ -d zxing ]; then
	mkdir zxing/core/target/classes/settings; mv RunFiles/RunZxing.class $_ && echo "[SHELL SCRIPT] Moved RunZxing.class to $_" || echo "[SHELL SCRIPT] Failed"
fi

#WebMagic
if [ -d webmagic ]; then
	mkdir webmagic/webmagic-core/target/classes/settings; mv RunFiles/RunWebmagic2_3_4.class $_ && echo "[SHELL SCRIPT] Moved RunWebmagic2_3_4.class to $_" || echo "[SHELL SCRIPT] Failed"
	mkdir webmagic/webmagic-extension/target/classes/settings; mv RunFiles/RunWebmagic1_5.class $_ && echo "[SHELL SCRIPT] Moved RunWebmagic1_5.class to $_" || echo "[SHELL SCRIPT] Failed"
fi

#FastJson
if [ -d fastjson ]; then
	mkdir fastjson/target/classes/settings; mv RunFiles/RunFastjson.class $_ && echo "[SHELL SCRIPT] Moved RunFastjson.class to $_" || echo "[SHELL SCRIPT] Failed"
fi

#Jsoup
if [ -d jsoup ]; then
	mkdir jsoup/target/classes/settings; mv RunFiles/RunJsoup.class $_ && echo "[SHELL SCRIPT] Moved RunRunJsoup.class to $_" || echo "[SHELL SCRIPT] Failed"
fi

#Bcel
if [ -d bcel-6.0-src ]; then
	mkdir bcel-6.0-src/target/classes/settings; mv RunFiles/RunBcel.class $_ && echo "[SHELL SCRIPT] Moved RunBcel.class to $_" || echo "[SHELL SCRIPT] Failed"
fi

#Gson
if [ -d gson ]; then
	mkdir gson/gson/target/classes/settings; mv RunFiles/RunGson.class $_ && echo "[SHELL SCRIPT] Moved RunGson.class to $_" || echo "[SHELL SCRIPT] Failed"
fi

#Image
if [ -d commons-imaging ]; then
	mkdir commons-imaging/target/classes/settings; mv RunFiles/RunImage.class $_ && echo "[SHELL SCRIPT] Moved RunImage.class to $_" || echo "[SHELL SCRIPT] Failed"
fi

#Jxpath
if [ -d commons-jxpath-1.3-src ]; then
	mkdir commons-jxpath-1.3-src/target/classes/settings; mv RunFiles/RunJxpath.class $_ && echo "[SHELL SCRIPT] Moved RunJxpath.class to $_" || echo "[SHELL SCRIPT] Failed"
fi

#La4j
if [ -d la4j-0.6.0 ]; then
	mkdir la4j-0.6.0/target/classes/settings; mv RunFiles/RunLa4j.class $_ && echo "[SHELL SCRIPT] Moved RunLa4j.class to $_" || echo "[SHELL SCRIPT] Failed"
fi

#Re2j
if [ -d re2j ]; then
	mkdir re2j/target/classes/settings; mv RunFiles/RunRe2j.class $_ && echo "[SHELL SCRIPT] Moved RunRe2j.class to $_" || echo "[SHELL SCRIPT] Failed"
fi

#TODO Launch TARDIS...

echo "[SHELL SCRIPT] ENDING at $(date)"