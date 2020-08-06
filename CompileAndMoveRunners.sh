#!/bin/sh
cd RunFiles
echo "Compile all Run files"
for f in *.java
do
	javac -cp /home/ubuntu/tardisFolder/tardisProva/tardis/master/build/libs/tardis-master-0.2.0-SNAPSHOT.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/runtime/build/libs/sushi-lib-0.2.0-SNAPSHOT.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/jbse/build/libs/jbse-0.10.0-SNAPSHOT-shaded.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/args4j/args4j/2.32/1ccacebdf8f2db750eb09a402969050f27695fb7/args4j-2.32.jar:/usr/lib/jvm/java-8-openjdk-amd64/lib/tools.jar $f && echo "$f compiled" || echo "$f: Failed"
done
cd ..

#Authzforce
if [ -d core-release-13.3.0 ]; then
	echo "Moving RunAuthzforce1.class"
	mkdir core-release-13.3.0/pdp-engine/target/classes/settings; mv RunFiles/RunAuthzforce1.class $_ && echo "Moved RunAuthzforce1.class to $_" || echo "Failed"
fi

#Dubbo
if [ -d dubbo ]; then
	echo "Moving RunDubbo.class"
	mkdir dubbo/dubbo-common/target/classes/settings; mv RunFiles/RunDubbo.class $_ && echo "Moved RunDubbo.class to $_" || echo "Failed"
fi

#Okio
if [ -d okio ]; then
	echo "Moving RunOkio.class"
	mkdir okio/okio/target/classes/settings; mv RunFiles/RunOkio.class $_ && echo "Moved RunOkio.class to $_" || echo "Failed"
fi

#Zxing
if [ -d zxing ]; then
	echo "Moving RunZxing.class"
	mkdir zxing/core/target/classes/settings; mv RunFiles/RunZxing.class $_ && echo "Moved RunZxing.class to $_" || echo "Failed"
fi

#WebMagic
if [ -d webmagic ]; then
	echo "Moving RunWebmagic.class"
	mkdir webmagic/webmagic-core/target/classes/settings; mv RunFiles/RunWebmagic2_3_4.class $_ && echo " Moved RunWebmagic2_3_4.class to $_" || echo "Failed"
	mkdir webmagic/webmagic-extension/target/classes/settings; mv RunFiles/RunWebmagic1_5.class $_ && echo " Moved RunWebmagic1_5.class to $_" || echo "Failed"
fi

#FastJson
if [ -d fastjson ]; then
	echo "Moving RunFastjson.class"
	mkdir fastjson/target/classes/settings; mv RunFiles/RunFastjson.class $_ && echo "Moved RunFastjson.class to $_" || echo "Failed"
fi

#Jsoup
if [ -d jsoup ]; then
	echo "Moving RunJsoup.class"
	mkdir jsoup/target/classes/settings; mv RunFiles/RunJsoup.class $_ && echo "Moved RunRunJsoup.class to $_" || echo "Failed"
fi

echo "All Run.class files copied to /target/classes/settings folders"