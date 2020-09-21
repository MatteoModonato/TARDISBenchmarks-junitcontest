#!/bin/sh
echo "[TARDIS LAUNCHER] STARTING at $(date)"

while getopts t:m:e:g: flag
do
    case "${flag}" in
        t) thread=${OPTARG};;
        m) mosa=${OPTARG};;
        e) evosuiteTime=${OPTARG};;
		g) globalTime=${OPTARG};;
    esac
done
echo "thread: $thread";
echo "mosa: $mosa";
echo "evosuiteTime: $evosuiteTime";
echo "globalTime: $globalTime";

echo "[TARDIS LAUNCHER] Choose the benchmarks to run:"
echo " ------------------------ "
echo "|  1)  ALL BENCHMARKS    |"
echo "|  2)  AUTHZFORCE        |"
echo "|  3)  BCEL              |"
echo "|  4)  DUBBO             |"
echo "|  5)  FASTJSON          |"
echo "|  6)  FESCAR            |"
echo "|  7)  GSON              |"
echo "|  8)  GUAVA             |"
echo "|  9)  IMAGE             |"
echo "|  10) JSOUP             |"
echo "|  11) JXPATH            |"
echo "|  12) LA4J              |"
echo "|  13) OKHTTP            |"
echo "|  14) OKIO              |"
echo "|  15) PDFBOX            |"
echo "|  16) RE2J              |"
echo "|  17) SPOON             |"
echo "|  18) WEBMAGIC          |"
echo "|  19) ZXING             |"
echo " ------------------------ "
read input

dt=$(date +%Y:%m:%d_%H:%M:%S)
mkdir /home/ubuntu/tardisFolder/tardisExperiments/$dt

#Authzforce
if [ $input == "2" ] || [ $input == "1" ]; then
	sed -i "s/\(setNumOfThreads(\).*\();\)/\1$thread\2/g
			s/\(setNumMOSATargets(\).*\();\)/\1$mosa\2/g
			s/\(setEvosuiteTimeBudgetDuration(\).*\();\)/\1$evosuiteTime\2/g
			s/\(setGlobalTimeBudgetDuration(\).*\();\)/\1$globalTime\2/g" RunFiles/RunAuthzforce1.java
	for BENCHMARK in TARGET_CLASS_1 TARGET_CLASS_11 TARGET_CLASS_27 TARGET_CLASS_32 TARGET_CLASS_33 TARGET_CLASS_48 TARGET_CLASS_5 TARGET_CLASS_52 TARGET_CLASS_63 TARGET_CLASS_65
	do
		echo "[TARDIS LAUNCHER] Run benchmark AUTHZFORCE -- Target class: $BENCHMARK"
		sed -i "s/\(setTargetClass(\).*\();\)/\1$BENCHMARK\2/g" RunFiles/RunAuthzforce1.java
		bash CompileAndMove.sh
		java -Xms16G -Xmx16G -cp /home/ubuntu/tardisFolder/tardisExperiments/bin/TARDISBenchmarks-junitcontest/core-release-13.3.0/pdp-engine/target/classes:/home/ubuntu/tardisFolder/tardisProva/tardis/master/build/libs/tardis-master-0.2.0-SNAPSHOT.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/runtime/build/libs/sushi-lib-0.2.0-SNAPSHOT.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/jbse/build/libs/jbse-0.10.0-SNAPSHOT-shaded.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/args4j/args4j/2.32/1ccacebdf8f2db750eb09a402969050f27695fb7/args4j-2.32.jar:/usr/lib/jvm/java-8-openjdk-amd64/lib/tools.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/com.opencsv/opencsv/5.0/6aa7ff327f0ad7e3e9dabd6fe29ee19122b382c3/opencsv-5.0.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/com.github.javaparser/javaparser-core/3.15.9/998ab964f295e6cecd4467a76d4a6369a8193e5a/javaparser-core-3.15.9.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/jbse/libs/javassist.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/org.jacoco/org.jacoco.core/0.7.5.201505241946/1ea906dc5201d2a1bc0604f8650534d4bcaf4c95/org.jacoco.core-0.7.5.201505241946.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/org.ow2.asm/asm-debug-all/5.0.1/f69b5f7d96cec0d448acf1c1a266584170c9643b/asm-debug-all-5.0.1.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/junit/junit/4.12/2973d150c0dc1fefe998f834810d68f278ea58ec/junit-4.12.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/org.hamcrest/hamcrest-core/1.3/42a25dc3219429f0e5d060061f71acb49bf010a0/hamcrest-core-1.3.jar:/home/ubuntu/tardisFolder/tardisExperiments/bin/TARDISBenchmarks-junitcontest/core-release-13.3.0/dependencies/* settings.RunAuthzforce1 |& tee /home/ubuntu/tardisFolder/tardisExperiments/$dt/tardisLog$BENCHMARK.txt
	done
fi

#Bcel
if [ $input == "3" ] || [ $input == "1" ]; then
	sed -i "s/\(setNumOfThreads(\).*\();\)/\1$thread\2/g
			s/\(setNumMOSATargets(\).*\();\)/\1$mosa\2/g
			s/\(setEvosuiteTimeBudgetDuration(\).*\();\)/\1$evosuiteTime\2/g
			s/\(setGlobalTimeBudgetDuration(\).*\();\)/\1$globalTime\2/g" RunFiles/RunBcel.java
	for BENCHMARK in TARGET_CLASS_1 TARGET_CLASS_2 TARGET_CLASS_3 TARGET_CLASS_4 TARGET_CLASS_5 TARGET_CLASS_6 TARGET_CLASS_7 TARGET_CLASS_8 TARGET_CLASS_9 TARGET_CLASS_10
	do
		echo "[TARDIS LAUNCHER] Run benchmark BCEL -- Target class: $BENCHMARK"
		sed -i "s/\(setTargetClass(\).*\();\)/\1$BENCHMARK\2/g" RunFiles/RunBcel.java
		bash CompileAndMove.sh
		java -Xms16G -Xmx16G -cp /home/ubuntu/tardisFolder/tardisExperiments/bin/TARDISBenchmarks-junitcontest/bcel-6.0-src/target/classes:/home/ubuntu/tardisFolder/tardisProva/tardis/master/build/libs/tardis-master-0.2.0-SNAPSHOT.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/runtime/build/libs/sushi-lib-0.2.0-SNAPSHOT.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/jbse/build/libs/jbse-0.10.0-SNAPSHOT-shaded.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/args4j/args4j/2.32/1ccacebdf8f2db750eb09a402969050f27695fb7/args4j-2.32.jar:/usr/lib/jvm/java-8-openjdk-amd64/lib/tools.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/com.opencsv/opencsv/5.0/6aa7ff327f0ad7e3e9dabd6fe29ee19122b382c3/opencsv-5.0.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/com.github.javaparser/javaparser-core/3.15.9/998ab964f295e6cecd4467a76d4a6369a8193e5a/javaparser-core-3.15.9.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/jbse/libs/javassist.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/org.jacoco/org.jacoco.core/0.7.5.201505241946/1ea906dc5201d2a1bc0604f8650534d4bcaf4c95/org.jacoco.core-0.7.5.201505241946.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/org.ow2.asm/asm-debug-all/5.0.1/f69b5f7d96cec0d448acf1c1a266584170c9643b/asm-debug-all-5.0.1.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/junit/junit/4.12/2973d150c0dc1fefe998f834810d68f278ea58ec/junit-4.12.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/org.hamcrest/hamcrest-core/1.3/42a25dc3219429f0e5d060061f71acb49bf010a0/hamcrest-core-1.3.jar:/home/ubuntu/tardisFolder/tardisExperiments/bin/TARDISBenchmarks-junitcontest/bcel-6.0-src/dependencies/* settings.RunBcel |& tee /home/ubuntu/tardisFolder/tardisExperiments/$dt/tardisLog$BENCHMARK.txt
	done
fi

#Dubbo
if [ $input == "4" ] || [ $input == "1" ]; then
	sed -i "s/\(setNumOfThreads(\).*\();\)/\1$thread\2/g
			s/\(setNumMOSATargets(\).*\();\)/\1$mosa\2/g
			s/\(setEvosuiteTimeBudgetDuration(\).*\();\)/\1$evosuiteTime\2/g
			s/\(setGlobalTimeBudgetDuration(\).*\();\)/\1$globalTime\2/g" RunFiles/RunDubbo.java
	for BENCHMARK in TARGET_CLASS_2 TARGET_CLASS_3 TARGET_CLASS_4 TARGET_CLASS_5 TARGET_CLASS_6 TARGET_CLASS_7 TARGET_CLASS_8 TARGET_CLASS_9 TARGET_CLASS_10
	do
		echo "[TARDIS LAUNCHER] Run benchmark DUBBO -- Target class: $BENCHMARK"
		sed -i "s/\(setTargetClass(\).*\();\)/\1$BENCHMARK\2/g" RunFiles/RunDubbo.java
		bash CompileAndMove.sh
		java -Xms16G -Xmx16G -cp /home/ubuntu/tardisFolder/tardisExperiments/bin/TARDISBenchmarks-junitcontest/dubbo/dubbo-common/target/classes:/home/ubuntu/tardisFolder/tardisProva/tardis/master/build/libs/tardis-master-0.2.0-SNAPSHOT.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/runtime/build/libs/sushi-lib-0.2.0-SNAPSHOT.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/jbse/build/libs/jbse-0.10.0-SNAPSHOT-shaded.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/args4j/args4j/2.32/1ccacebdf8f2db750eb09a402969050f27695fb7/args4j-2.32.jar:/usr/lib/jvm/java-8-openjdk-amd64/lib/tools.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/com.opencsv/opencsv/5.0/6aa7ff327f0ad7e3e9dabd6fe29ee19122b382c3/opencsv-5.0.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/com.github.javaparser/javaparser-core/3.15.9/998ab964f295e6cecd4467a76d4a6369a8193e5a/javaparser-core-3.15.9.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/jbse/libs/javassist.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/org.jacoco/org.jacoco.core/0.7.5.201505241946/1ea906dc5201d2a1bc0604f8650534d4bcaf4c95/org.jacoco.core-0.7.5.201505241946.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/org.ow2.asm/asm-debug-all/5.0.1/f69b5f7d96cec0d448acf1c1a266584170c9643b/asm-debug-all-5.0.1.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/junit/junit/4.12/2973d150c0dc1fefe998f834810d68f278ea58ec/junit-4.12.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/org.hamcrest/hamcrest-core/1.3/42a25dc3219429f0e5d060061f71acb49bf010a0/hamcrest-core-1.3.jar:/home/ubuntu/tardisFolder/tardisExperiments/bin/TARDISBenchmarks-junitcontest/dubbo/dependencies/* settings.RunDubbo |& tee /home/ubuntu/tardisFolder/tardisExperiments/$dt/tardisLog$BENCHMARK.txt
	done
fi

#Fastjson
if [ $input == "5" ] || [ $input == "1" ]; then
	sed -i "s/\(setNumOfThreads(\).*\();\)/\1$thread\2/g
			s/\(setNumMOSATargets(\).*\();\)/\1$mosa\2/g
			s/\(setEvosuiteTimeBudgetDuration(\).*\();\)/\1$evosuiteTime\2/g
			s/\(setGlobalTimeBudgetDuration(\).*\();\)/\1$globalTime\2/g" RunFiles/RunFastjson.java
	for BENCHMARK in TARGET_CLASS_1 TARGET_CLASS_2 TARGET_CLASS_3 TARGET_CLASS_4 TARGET_CLASS_5 TARGET_CLASS_6 TARGET_CLASS_7 TARGET_CLASS_8 TARGET_CLASS_9 TARGET_CLASS_10
	do
		echo "[TARDIS LAUNCHER] Run benchmark FASTJSON -- Target class: $BENCHMARK"
		sed -i "s/\(setTargetClass(\).*\();\)/\1$BENCHMARK\2/g" RunFiles/RunFastjson.java
		bash CompileAndMove.sh
		java -Xms16G -Xmx16G -cp /home/ubuntu/tardisFolder/tardisExperiments/bin/TARDISBenchmarks-junitcontest/fastjson/target/classes:/home/ubuntu/tardisFolder/tardisProva/tardis/master/build/libs/tardis-master-0.2.0-SNAPSHOT.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/runtime/build/libs/sushi-lib-0.2.0-SNAPSHOT.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/jbse/build/libs/jbse-0.10.0-SNAPSHOT-shaded.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/args4j/args4j/2.32/1ccacebdf8f2db750eb09a402969050f27695fb7/args4j-2.32.jar:/usr/lib/jvm/java-8-openjdk-amd64/lib/tools.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/com.opencsv/opencsv/5.0/6aa7ff327f0ad7e3e9dabd6fe29ee19122b382c3/opencsv-5.0.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/com.github.javaparser/javaparser-core/3.15.9/998ab964f295e6cecd4467a76d4a6369a8193e5a/javaparser-core-3.15.9.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/jbse/libs/javassist.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/org.jacoco/org.jacoco.core/0.7.5.201505241946/1ea906dc5201d2a1bc0604f8650534d4bcaf4c95/org.jacoco.core-0.7.5.201505241946.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/org.ow2.asm/asm-debug-all/5.0.1/f69b5f7d96cec0d448acf1c1a266584170c9643b/asm-debug-all-5.0.1.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/junit/junit/4.12/2973d150c0dc1fefe998f834810d68f278ea58ec/junit-4.12.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/org.hamcrest/hamcrest-core/1.3/42a25dc3219429f0e5d060061f71acb49bf010a0/hamcrest-core-1.3.jar:/home/ubuntu/tardisFolder/tardisExperiments/bin/TARDISBenchmarks-junitcontest/fastjson/dependencies/* settings.RunFastjson |& tee /home/ubuntu/tardisFolder/tardisExperiments/$dt/tardisLog$BENCHMARK.txt
	done
fi

#Fescar
if [ $input == "6" ] || [ $input == "1" ]; then
	sed -i "s/\(setNumOfThreads(\).*\();\)/\1$thread\2/g
			s/\(setNumMOSATargets(\).*\();\)/\1$mosa\2/g
			s/\(setEvosuiteTimeBudgetDuration(\).*\();\)/\1$evosuiteTime\2/g
			s/\(setGlobalTimeBudgetDuration(\).*\();\)/\1$globalTime\2/g" RunFiles/RunFescar.java
	for BENCHMARK in TARGET_CLASS_1 TARGET_CLASS_12 TARGET_CLASS_18 TARGET_CLASS_23 TARGET_CLASS_25 TARGET_CLASS_36 TARGET_CLASS_37 TARGET_CLASS_41 TARGET_CLASS_42 TARGET_CLASS_7 TARGET_CLASS_2 TARGET_CLASS_5 TARGET_CLASS_6 TARGET_CLASS_8 TARGET_CLASS_9 TARGET_CLASS_10 TARGET_CLASS_13 TARGET_CLASS_15 TARGET_CLASS_17 TARGET_CLASS_28 TARGET_CLASS_32 TARGET_CLASS_33 TARGET_CLASS_34
	do
		echo "[TARDIS LAUNCHER] Run benchmark FESCAR -- Target class: $BENCHMARK"
		sed -i "s/\(setTargetClass(\).*\();\)/\1$BENCHMARK\2/g" RunFiles/RunFescar.java
		bash CompileAndMove.sh
		java -Xms16G -Xmx16G -cp /home/ubuntu/tardisFolder/tardisExperiments/bin/TARDISBenchmarks-junitcontest/fescar/core/target/classes:/home/ubuntu/tardisFolder/tardisProva/tardis/master/build/libs/tardis-master-0.2.0-SNAPSHOT.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/runtime/build/libs/sushi-lib-0.2.0-SNAPSHOT.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/jbse/build/libs/jbse-0.10.0-SNAPSHOT-shaded.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/args4j/args4j/2.32/1ccacebdf8f2db750eb09a402969050f27695fb7/args4j-2.32.jar:/usr/lib/jvm/java-8-openjdk-amd64/lib/tools.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/com.opencsv/opencsv/5.0/6aa7ff327f0ad7e3e9dabd6fe29ee19122b382c3/opencsv-5.0.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/com.github.javaparser/javaparser-core/3.15.9/998ab964f295e6cecd4467a76d4a6369a8193e5a/javaparser-core-3.15.9.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/jbse/libs/javassist.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/org.jacoco/org.jacoco.core/0.7.5.201505241946/1ea906dc5201d2a1bc0604f8650534d4bcaf4c95/org.jacoco.core-0.7.5.201505241946.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/org.ow2.asm/asm-debug-all/5.0.1/f69b5f7d96cec0d448acf1c1a266584170c9643b/asm-debug-all-5.0.1.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/junit/junit/4.12/2973d150c0dc1fefe998f834810d68f278ea58ec/junit-4.12.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/org.hamcrest/hamcrest-core/1.3/42a25dc3219429f0e5d060061f71acb49bf010a0/hamcrest-core-1.3.jar:/home/ubuntu/tardisFolder/tardisExperiments/bin/TARDISBenchmarks-junitcontest/fescar/dependencies/* settings.RunFescar |& tee /home/ubuntu/tardisFolder/tardisExperiments/$dt/tardisLog$BENCHMARK.txt
	done
fi

#Gson
if [ $input == "7" ] || [ $input == "1" ]; then
	sed -i "s/\(setNumOfThreads(\).*\();\)/\1$thread\2/g
			s/\(setNumMOSATargets(\).*\();\)/\1$mosa\2/g
			s/\(setEvosuiteTimeBudgetDuration(\).*\();\)/\1$evosuiteTime\2/g
			s/\(setGlobalTimeBudgetDuration(\).*\();\)/\1$globalTime\2/g" RunFiles/RunGson.java
	for BENCHMARK in TARGET_CLASS_1 TARGET_CLASS_2 TARGET_CLASS_3 TARGET_CLASS_4 TARGET_CLASS_5 TARGET_CLASS_6 TARGET_CLASS_7 TARGET_CLASS_8 TARGET_CLASS_9 TARGET_CLASS_10
	do
		echo "[TARDIS LAUNCHER] Run benchmark GSON -- Target class: $BENCHMARK"
		sed -i "s/\(setTargetClass(\).*\();\)/\1$BENCHMARK\2/g" RunFiles/RunGson.java
		bash CompileAndMove.sh
		java -Xms16G -Xmx16G -cp /home/ubuntu/tardisFolder/tardisExperiments/bin/TARDISBenchmarks-junitcontest/gson/gson/target/classes:/home/ubuntu/tardisFolder/tardisProva/tardis/master/build/libs/tardis-master-0.2.0-SNAPSHOT.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/runtime/build/libs/sushi-lib-0.2.0-SNAPSHOT.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/jbse/build/libs/jbse-0.10.0-SNAPSHOT-shaded.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/args4j/args4j/2.32/1ccacebdf8f2db750eb09a402969050f27695fb7/args4j-2.32.jar:/usr/lib/jvm/java-8-openjdk-amd64/lib/tools.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/com.opencsv/opencsv/5.0/6aa7ff327f0ad7e3e9dabd6fe29ee19122b382c3/opencsv-5.0.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/com.github.javaparser/javaparser-core/3.15.9/998ab964f295e6cecd4467a76d4a6369a8193e5a/javaparser-core-3.15.9.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/jbse/libs/javassist.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/org.jacoco/org.jacoco.core/0.7.5.201505241946/1ea906dc5201d2a1bc0604f8650534d4bcaf4c95/org.jacoco.core-0.7.5.201505241946.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/org.ow2.asm/asm-debug-all/5.0.1/f69b5f7d96cec0d448acf1c1a266584170c9643b/asm-debug-all-5.0.1.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/junit/junit/4.12/2973d150c0dc1fefe998f834810d68f278ea58ec/junit-4.12.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/org.hamcrest/hamcrest-core/1.3/42a25dc3219429f0e5d060061f71acb49bf010a0/hamcrest-core-1.3.jar:/home/ubuntu/tardisFolder/tardisExperiments/bin/TARDISBenchmarks-junitcontest/gson/dependencies/* settings.RunGson |& tee /home/ubuntu/tardisFolder/tardisExperiments/$dt/tardisLog$BENCHMARK.txt
	done
fi

#Guava
if [ $input == "8" ] || [ $input == "1" ]; then
	sed -i "s/\(setNumOfThreads(\).*\();\)/\1$thread\2/g
			s/\(setNumMOSATargets(\).*\();\)/\1$mosa\2/g
			s/\(setEvosuiteTimeBudgetDuration(\).*\();\)/\1$evosuiteTime\2/g
			s/\(setGlobalTimeBudgetDuration(\).*\();\)/\1$globalTime\2/g" RunFiles/RunGuava.java
	for BENCHMARK in TARGET_CLASS_2 TARGET_CLASS_22 TARGET_CLASS_39 TARGET_CLASS_47 TARGET_CLASS_90 TARGET_CLASS_95 TARGET_CLASS_102 TARGET_CLASS_110 TARGET_CLASS_128 TARGET_CLASS_129 TARGET_CLASS_159 TARGET_CLASS_169 TARGET_CLASS_177 TARGET_CLASS_181 TARGET_CLASS_184 TARGET_CLASS_196 TARGET_CLASS_206 TARGET_CLASS_212 TARGET_CLASS_224 TARGET_CLASS_240
	do
		echo "[TARDIS LAUNCHER] Run benchmark GUAVA -- Target class: $BENCHMARK"
		sed -i "s/\(setTargetClass(\).*\();\)/\1$BENCHMARK\2/g" RunFiles/RunGuava.java
		bash CompileAndMove.sh
		java -Xms16G -Xmx16G -cp /home/ubuntu/tardisFolder/tardisExperiments/bin/TARDISBenchmarks-junitcontest/guava/guava/target/classes:/home/ubuntu/tardisFolder/tardisProva/tardis/master/build/libs/tardis-master-0.2.0-SNAPSHOT.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/runtime/build/libs/sushi-lib-0.2.0-SNAPSHOT.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/jbse/build/libs/jbse-0.10.0-SNAPSHOT-shaded.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/args4j/args4j/2.32/1ccacebdf8f2db750eb09a402969050f27695fb7/args4j-2.32.jar:/usr/lib/jvm/java-8-openjdk-amd64/lib/tools.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/com.opencsv/opencsv/5.0/6aa7ff327f0ad7e3e9dabd6fe29ee19122b382c3/opencsv-5.0.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/com.github.javaparser/javaparser-core/3.15.9/998ab964f295e6cecd4467a76d4a6369a8193e5a/javaparser-core-3.15.9.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/jbse/libs/javassist.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/org.jacoco/org.jacoco.core/0.7.5.201505241946/1ea906dc5201d2a1bc0604f8650534d4bcaf4c95/org.jacoco.core-0.7.5.201505241946.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/org.ow2.asm/asm-debug-all/5.0.1/f69b5f7d96cec0d448acf1c1a266584170c9643b/asm-debug-all-5.0.1.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/junit/junit/4.12/2973d150c0dc1fefe998f834810d68f278ea58ec/junit-4.12.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/org.hamcrest/hamcrest-core/1.3/42a25dc3219429f0e5d060061f71acb49bf010a0/hamcrest-core-1.3.jar:/home/ubuntu/tardisFolder/tardisExperiments/bin/TARDISBenchmarks-junitcontest/guava/dependencies/* settings.RunGuava |& tee /home/ubuntu/tardisFolder/tardisExperiments/$dt/tardisLog$BENCHMARK.txt
	done
fi

#Image
if [ $input == "9" ] || [ $input == "1" ]; then
	sed -i "s/\(setNumOfThreads(\).*\();\)/\1$thread\2/g
			s/\(setNumMOSATargets(\).*\();\)/\1$mosa\2/g
			s/\(setEvosuiteTimeBudgetDuration(\).*\();\)/\1$evosuiteTime\2/g
			s/\(setGlobalTimeBudgetDuration(\).*\();\)/\1$globalTime\2/g" RunFiles/RunImage.java
	for BENCHMARK in TARGET_CLASS_1 TARGET_CLASS_2 TARGET_CLASS_3 TARGET_CLASS_4
	do
		echo "[TARDIS LAUNCHER] Run benchmark IMAGE -- Target class: $BENCHMARK"
		sed -i "s/\(setTargetClass(\).*\();\)/\1$BENCHMARK\2/g" RunFiles/RunImage.java
		bash CompileAndMove.sh
		java -Xms16G -Xmx16G -cp /home/ubuntu/tardisFolder/tardisExperiments/bin/TARDISBenchmarks-junitcontest/commons-imaging/target/classes:/home/ubuntu/tardisFolder/tardisProva/tardis/master/build/libs/tardis-master-0.2.0-SNAPSHOT.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/runtime/build/libs/sushi-lib-0.2.0-SNAPSHOT.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/jbse/build/libs/jbse-0.10.0-SNAPSHOT-shaded.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/args4j/args4j/2.32/1ccacebdf8f2db750eb09a402969050f27695fb7/args4j-2.32.jar:/usr/lib/jvm/java-8-openjdk-amd64/lib/tools.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/com.opencsv/opencsv/5.0/6aa7ff327f0ad7e3e9dabd6fe29ee19122b382c3/opencsv-5.0.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/com.github.javaparser/javaparser-core/3.15.9/998ab964f295e6cecd4467a76d4a6369a8193e5a/javaparser-core-3.15.9.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/jbse/libs/javassist.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/org.jacoco/org.jacoco.core/0.7.5.201505241946/1ea906dc5201d2a1bc0604f8650534d4bcaf4c95/org.jacoco.core-0.7.5.201505241946.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/org.ow2.asm/asm-debug-all/5.0.1/f69b5f7d96cec0d448acf1c1a266584170c9643b/asm-debug-all-5.0.1.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/junit/junit/4.12/2973d150c0dc1fefe998f834810d68f278ea58ec/junit-4.12.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/org.hamcrest/hamcrest-core/1.3/42a25dc3219429f0e5d060061f71acb49bf010a0/hamcrest-core-1.3.jar:/home/ubuntu/tardisFolder/tardisExperiments/bin/TARDISBenchmarks-junitcontest/commons-imaging/dependencies/* settings.RunImage |& tee /home/ubuntu/tardisFolder/tardisExperiments/$dt/tardisLog$BENCHMARK.txt
	done
fi

#Jsoup
if [ $input == "10" ] || [ $input == "1" ]; then
	sed -i "s/\(setNumOfThreads(\).*\();\)/\1$thread\2/g
			s/\(setNumMOSATargets(\).*\();\)/\1$mosa\2/g
			s/\(setEvosuiteTimeBudgetDuration(\).*\();\)/\1$evosuiteTime\2/g
			s/\(setGlobalTimeBudgetDuration(\).*\();\)/\1$globalTime\2/g" RunFiles/RunJsoup.java
	for BENCHMARK in TARGET_CLASS_1 TARGET_CLASS_2 TARGET_CLASS_3 TARGET_CLASS_4 TARGET_CLASS_5
	do
		echo "[TARDIS LAUNCHER] Run benchmark JSOUP -- Target class: $BENCHMARK"
		sed -i "s/\(setTargetClass(\).*\();\)/\1$BENCHMARK\2/g" RunFiles/RunJsoup.java
		bash CompileAndMove.sh
		java -Xms16G -Xmx16G -cp /home/ubuntu/tardisFolder/tardisExperiments/bin/TARDISBenchmarks-junitcontest/jsoup/target/classes:/home/ubuntu/tardisFolder/tardisProva/tardis/master/build/libs/tardis-master-0.2.0-SNAPSHOT.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/runtime/build/libs/sushi-lib-0.2.0-SNAPSHOT.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/jbse/build/libs/jbse-0.10.0-SNAPSHOT-shaded.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/args4j/args4j/2.32/1ccacebdf8f2db750eb09a402969050f27695fb7/args4j-2.32.jar:/usr/lib/jvm/java-8-openjdk-amd64/lib/tools.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/com.opencsv/opencsv/5.0/6aa7ff327f0ad7e3e9dabd6fe29ee19122b382c3/opencsv-5.0.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/com.github.javaparser/javaparser-core/3.15.9/998ab964f295e6cecd4467a76d4a6369a8193e5a/javaparser-core-3.15.9.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/jbse/libs/javassist.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/org.jacoco/org.jacoco.core/0.7.5.201505241946/1ea906dc5201d2a1bc0604f8650534d4bcaf4c95/org.jacoco.core-0.7.5.201505241946.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/org.ow2.asm/asm-debug-all/5.0.1/f69b5f7d96cec0d448acf1c1a266584170c9643b/asm-debug-all-5.0.1.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/junit/junit/4.12/2973d150c0dc1fefe998f834810d68f278ea58ec/junit-4.12.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/org.hamcrest/hamcrest-core/1.3/42a25dc3219429f0e5d060061f71acb49bf010a0/hamcrest-core-1.3.jar:/home/ubuntu/tardisFolder/tardisExperiments/bin/TARDISBenchmarks-junitcontest/jsoup/dependencies/* settings.RunJsoup |& tee /home/ubuntu/tardisFolder/tardisExperiments/$dt/tardisLog$BENCHMARK.txt
	done
fi

#Jxpath
if [ $input == "11" ] || [ $input == "1" ]; then
	sed -i "s/\(setNumOfThreads(\).*\();\)/\1$thread\2/g
			s/\(setNumMOSATargets(\).*\();\)/\1$mosa\2/g
			s/\(setEvosuiteTimeBudgetDuration(\).*\();\)/\1$evosuiteTime\2/g
			s/\(setGlobalTimeBudgetDuration(\).*\();\)/\1$globalTime\2/g" RunFiles/RunJxpath.java
	for BENCHMARK in TARGET_CLASS_1 TARGET_CLASS_2 TARGET_CLASS_3 TARGET_CLASS_4 TARGET_CLASS_5 TARGET_CLASS_6 TARGET_CLASS_7 TARGET_CLASS_8 TARGET_CLASS_9 TARGET_CLASS_10
	do
		echo "[TARDIS LAUNCHER] Run benchmark JXPATH -- Target class: $BENCHMARK"
		sed -i "s/\(setTargetClass(\).*\();\)/\1$BENCHMARK\2/g" RunFiles/RunJxpath.java
		bash CompileAndMove.sh
		java -Xms16G -Xmx16G -cp /home/ubuntu/tardisFolder/tardisExperiments/bin/TARDISBenchmarks-junitcontest/commons-jxpath-1.3-src/target/classes:/home/ubuntu/tardisFolder/tardisProva/tardis/master/build/libs/tardis-master-0.2.0-SNAPSHOT.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/runtime/build/libs/sushi-lib-0.2.0-SNAPSHOT.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/jbse/build/libs/jbse-0.10.0-SNAPSHOT-shaded.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/args4j/args4j/2.32/1ccacebdf8f2db750eb09a402969050f27695fb7/args4j-2.32.jar:/usr/lib/jvm/java-8-openjdk-amd64/lib/tools.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/com.opencsv/opencsv/5.0/6aa7ff327f0ad7e3e9dabd6fe29ee19122b382c3/opencsv-5.0.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/com.github.javaparser/javaparser-core/3.15.9/998ab964f295e6cecd4467a76d4a6369a8193e5a/javaparser-core-3.15.9.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/jbse/libs/javassist.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/org.jacoco/org.jacoco.core/0.7.5.201505241946/1ea906dc5201d2a1bc0604f8650534d4bcaf4c95/org.jacoco.core-0.7.5.201505241946.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/org.ow2.asm/asm-debug-all/5.0.1/f69b5f7d96cec0d448acf1c1a266584170c9643b/asm-debug-all-5.0.1.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/junit/junit/4.12/2973d150c0dc1fefe998f834810d68f278ea58ec/junit-4.12.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/org.hamcrest/hamcrest-core/1.3/42a25dc3219429f0e5d060061f71acb49bf010a0/hamcrest-core-1.3.jar:/home/ubuntu/tardisFolder/tardisExperiments/bin/TARDISBenchmarks-junitcontest/commons-jxpath-1.3-src/dependencies/* settings.RunJxpath |& tee /home/ubuntu/tardisFolder/tardisExperiments/$dt/tardisLog$BENCHMARK.txt
	done
fi

#La4j
if [ $input == "12" ] || [ $input == "1" ]; then
	sed -i "s/\(setNumOfThreads(\).*\();\)/\1$thread\2/g
			s/\(setNumMOSATargets(\).*\();\)/\1$mosa\2/g
			s/\(setEvosuiteTimeBudgetDuration(\).*\();\)/\1$evosuiteTime\2/g
			s/\(setGlobalTimeBudgetDuration(\).*\();\)/\1$globalTime\2/g" RunFiles/RunLa4j.java
	for BENCHMARK in TARGET_CLASS_1 TARGET_CLASS_2 TARGET_CLASS_3 TARGET_CLASS_4 TARGET_CLASS_5 TARGET_CLASS_6 TARGET_CLASS_7 TARGET_CLASS_8 TARGET_CLASS_9 TARGET_CLASS_10
	do
		echo "[TARDIS LAUNCHER] Run benchmark LA4J -- Target class: $BENCHMARK"
		sed -i "s/\(setTargetClass(\).*\();\)/\1$BENCHMARK\2/g" RunFiles/RunLa4j.java
		bash CompileAndMove.sh
		java -Xms16G -Xmx16G -cp /home/ubuntu/tardisFolder/tardisExperiments/bin/TARDISBenchmarks-junitcontest/la4j-0.6.0/target/classes:/home/ubuntu/tardisFolder/tardisProva/tardis/master/build/libs/tardis-master-0.2.0-SNAPSHOT.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/runtime/build/libs/sushi-lib-0.2.0-SNAPSHOT.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/jbse/build/libs/jbse-0.10.0-SNAPSHOT-shaded.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/args4j/args4j/2.32/1ccacebdf8f2db750eb09a402969050f27695fb7/args4j-2.32.jar:/usr/lib/jvm/java-8-openjdk-amd64/lib/tools.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/com.opencsv/opencsv/5.0/6aa7ff327f0ad7e3e9dabd6fe29ee19122b382c3/opencsv-5.0.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/com.github.javaparser/javaparser-core/3.15.9/998ab964f295e6cecd4467a76d4a6369a8193e5a/javaparser-core-3.15.9.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/jbse/libs/javassist.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/org.jacoco/org.jacoco.core/0.7.5.201505241946/1ea906dc5201d2a1bc0604f8650534d4bcaf4c95/org.jacoco.core-0.7.5.201505241946.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/org.ow2.asm/asm-debug-all/5.0.1/f69b5f7d96cec0d448acf1c1a266584170c9643b/asm-debug-all-5.0.1.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/junit/junit/4.12/2973d150c0dc1fefe998f834810d68f278ea58ec/junit-4.12.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/org.hamcrest/hamcrest-core/1.3/42a25dc3219429f0e5d060061f71acb49bf010a0/hamcrest-core-1.3.jar:/home/ubuntu/tardisFolder/tardisExperiments/bin/TARDISBenchmarks-junitcontest/la4j-0.6.0/dependencies/* settings.RunLa4j |& tee /home/ubuntu/tardisFolder/tardisExperiments/$dt/tardisLog$BENCHMARK.txt
	done
fi

#Okhttp
if [ $input == "13" ] || [ $input == "1" ]; then
	sed -i "s/\(setNumOfThreads(\).*\();\)/\1$thread\2/g
			s/\(setNumMOSATargets(\).*\();\)/\1$mosa\2/g
			s/\(setEvosuiteTimeBudgetDuration(\).*\();\)/\1$evosuiteTime\2/g
			s/\(setGlobalTimeBudgetDuration(\).*\();\)/\1$globalTime\2/g" RunFiles/RunOkhttp.java
	for BENCHMARK in TARGET_CLASS_1 TARGET_CLASS_2 TARGET_CLASS_3 TARGET_CLASS_4 TARGET_CLASS_5 TARGET_CLASS_6 TARGET_CLASS_7 TARGET_CLASS_8
	do
		echo "[TARDIS LAUNCHER] Run benchmark OKHTTP -- Target class: $BENCHMARK"
		sed -i "s/\(setTargetClass(\).*\();\)/\1$BENCHMARK\2/g" RunFiles/RunOkhttp.java
		bash CompileAndMove.sh
		java -Xms16G -Xmx16G -cp /home/ubuntu/tardisFolder/tardisExperiments/bin/TARDISBenchmarks-junitcontest/okhttp/okhttp/target/classes:/home/ubuntu/tardisFolder/tardisProva/tardis/master/build/libs/tardis-master-0.2.0-SNAPSHOT.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/runtime/build/libs/sushi-lib-0.2.0-SNAPSHOT.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/jbse/build/libs/jbse-0.10.0-SNAPSHOT-shaded.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/args4j/args4j/2.32/1ccacebdf8f2db750eb09a402969050f27695fb7/args4j-2.32.jar:/usr/lib/jvm/java-8-openjdk-amd64/lib/tools.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/com.opencsv/opencsv/5.0/6aa7ff327f0ad7e3e9dabd6fe29ee19122b382c3/opencsv-5.0.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/com.github.javaparser/javaparser-core/3.15.9/998ab964f295e6cecd4467a76d4a6369a8193e5a/javaparser-core-3.15.9.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/jbse/libs/javassist.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/org.jacoco/org.jacoco.core/0.7.5.201505241946/1ea906dc5201d2a1bc0604f8650534d4bcaf4c95/org.jacoco.core-0.7.5.201505241946.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/org.ow2.asm/asm-debug-all/5.0.1/f69b5f7d96cec0d448acf1c1a266584170c9643b/asm-debug-all-5.0.1.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/junit/junit/4.12/2973d150c0dc1fefe998f834810d68f278ea58ec/junit-4.12.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/org.hamcrest/hamcrest-core/1.3/42a25dc3219429f0e5d060061f71acb49bf010a0/hamcrest-core-1.3.jar:/home/ubuntu/tardisFolder/tardisExperiments/bin/TARDISBenchmarks-junitcontest/okhttp/dependencies/* settings.RunOkhttp |& tee /home/ubuntu/tardisFolder/tardisExperiments/$dt/tardisLog$BENCHMARK.txt
	done
fi

#Okio
if [ $input == "14" ] || [ $input == "1" ]; then
	sed -i "s/\(setNumOfThreads(\).*\();\)/\1$thread\2/g
			s/\(setNumMOSATargets(\).*\();\)/\1$mosa\2/g
			s/\(setEvosuiteTimeBudgetDuration(\).*\();\)/\1$evosuiteTime\2/g
			s/\(setGlobalTimeBudgetDuration(\).*\();\)/\1$globalTime\2/g" RunFiles/RunOkio.java
	for BENCHMARK in TARGET_CLASS_1 TARGET_CLASS_2 TARGET_CLASS_3 TARGET_CLASS_4 TARGET_CLASS_5 TARGET_CLASS_6 TARGET_CLASS_7 TARGET_CLASS_8 TARGET_CLASS_9 TARGET_CLASS_10
	do
		echo "[TARDIS LAUNCHER] Run benchmark OKIO -- Target class: $BENCHMARK"
		sed -i "s/\(setTargetClass(\).*\();\)/\1$BENCHMARK\2/g" RunFiles/RunOkio.java
		bash CompileAndMove.sh
		java -Xms16G -Xmx16G -cp /home/ubuntu/tardisFolder/tardisExperiments/bin/TARDISBenchmarks-junitcontest/okio/okio/target/classes:/home/ubuntu/tardisFolder/tardisProva/tardis/master/build/libs/tardis-master-0.2.0-SNAPSHOT.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/runtime/build/libs/sushi-lib-0.2.0-SNAPSHOT.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/jbse/build/libs/jbse-0.10.0-SNAPSHOT-shaded.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/args4j/args4j/2.32/1ccacebdf8f2db750eb09a402969050f27695fb7/args4j-2.32.jar:/usr/lib/jvm/java-8-openjdk-amd64/lib/tools.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/com.opencsv/opencsv/5.0/6aa7ff327f0ad7e3e9dabd6fe29ee19122b382c3/opencsv-5.0.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/com.github.javaparser/javaparser-core/3.15.9/998ab964f295e6cecd4467a76d4a6369a8193e5a/javaparser-core-3.15.9.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/jbse/libs/javassist.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/org.jacoco/org.jacoco.core/0.7.5.201505241946/1ea906dc5201d2a1bc0604f8650534d4bcaf4c95/org.jacoco.core-0.7.5.201505241946.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/org.ow2.asm/asm-debug-all/5.0.1/f69b5f7d96cec0d448acf1c1a266584170c9643b/asm-debug-all-5.0.1.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/junit/junit/4.12/2973d150c0dc1fefe998f834810d68f278ea58ec/junit-4.12.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/org.hamcrest/hamcrest-core/1.3/42a25dc3219429f0e5d060061f71acb49bf010a0/hamcrest-core-1.3.jar:/home/ubuntu/tardisFolder/tardisExperiments/bin/TARDISBenchmarks-junitcontest/okio/dependencies/* settings.RunOkio |& tee /home/ubuntu/tardisFolder/tardisExperiments/$dt/tardisLog$BENCHMARK.txt
	done
fi

#Pdfbox
if [ $input == "15" ] || [ $input == "1" ]; then
	sed -i "s/\(setNumOfThreads(\).*\();\)/\1$thread\2/g
			s/\(setNumMOSATargets(\).*\();\)/\1$mosa\2/g
			s/\(setEvosuiteTimeBudgetDuration(\).*\();\)/\1$evosuiteTime\2/g
			s/\(setGlobalTimeBudgetDuration(\).*\();\)/\1$globalTime\2/g" RunFiles/RunPdfbox.java
	for BENCHMARK in TARGET_CLASS_8 TARGET_CLASS_22 TARGET_CLASS_26 TARGET_CLASS_40 TARGET_CLASS_62 TARGET_CLASS_83 TARGET_CLASS_91 TARGET_CLASS_117 TARGET_CLASS_127 TARGET_CLASS_130 TARGET_CLASS_157 TARGET_CLASS_198 TARGET_CLASS_214 TARGET_CLASS_220 TARGET_CLASS_229 TARGET_CLASS_234 TARGET_CLASS_235 TARGET_CLASS_265 TARGET_CLASS_278 TARGET_CLASS_285
	do
		echo "[TARDIS LAUNCHER] Run benchmark PDFBOX -- Target class: $BENCHMARK"
		sed -i "s/\(setTargetClass(\).*\();\)/\1$BENCHMARK\2/g" RunFiles/RunPdfbox.java
		bash CompileAndMove.sh
		java -Xms16G -Xmx16G -cp /home/ubuntu/tardisFolder/tardisExperiments/bin/TARDISBenchmarks-junitcontest/pdfbox/pdfbox/target/classes:/home/ubuntu/tardisFolder/tardisProva/tardis/master/build/libs/tardis-master-0.2.0-SNAPSHOT.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/runtime/build/libs/sushi-lib-0.2.0-SNAPSHOT.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/jbse/build/libs/jbse-0.10.0-SNAPSHOT-shaded.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/args4j/args4j/2.32/1ccacebdf8f2db750eb09a402969050f27695fb7/args4j-2.32.jar:/usr/lib/jvm/java-8-openjdk-amd64/lib/tools.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/com.opencsv/opencsv/5.0/6aa7ff327f0ad7e3e9dabd6fe29ee19122b382c3/opencsv-5.0.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/com.github.javaparser/javaparser-core/3.15.9/998ab964f295e6cecd4467a76d4a6369a8193e5a/javaparser-core-3.15.9.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/jbse/libs/javassist.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/org.jacoco/org.jacoco.core/0.7.5.201505241946/1ea906dc5201d2a1bc0604f8650534d4bcaf4c95/org.jacoco.core-0.7.5.201505241946.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/org.ow2.asm/asm-debug-all/5.0.1/f69b5f7d96cec0d448acf1c1a266584170c9643b/asm-debug-all-5.0.1.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/junit/junit/4.12/2973d150c0dc1fefe998f834810d68f278ea58ec/junit-4.12.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/org.hamcrest/hamcrest-core/1.3/42a25dc3219429f0e5d060061f71acb49bf010a0/hamcrest-core-1.3.jar:/home/ubuntu/tardisFolder/tardisExperiments/bin/TARDISBenchmarks-junitcontest/pdfbox/dependencies/* settings.RunPdfbox |& tee /home/ubuntu/tardisFolder/tardisExperiments/$dt/tardisLog$BENCHMARK.txt
	done
fi

#Re2j
if [ $input == "16" ] || [ $input == "1" ]; then
	sed -i "s/\(setNumOfThreads(\).*\();\)/\1$thread\2/g
			s/\(setNumMOSATargets(\).*\();\)/\1$mosa\2/g
			s/\(setEvosuiteTimeBudgetDuration(\).*\();\)/\1$evosuiteTime\2/g
			s/\(setGlobalTimeBudgetDuration(\).*\();\)/\1$globalTime\2/g" RunFiles/RunRe2j.java
	for BENCHMARK in TARGET_CLASS_1 TARGET_CLASS_2 TARGET_CLASS_3 TARGET_CLASS_4 TARGET_CLASS_5 TARGET_CLASS_6 TARGET_CLASS_7 TARGET_CLASS_8
	do
		echo "[TARDIS LAUNCHER] Run benchmark RE2J -- Target class: $BENCHMARK"
		sed -i "s/\(setTargetClass(\).*\();\)/\1$BENCHMARK\2/g" RunFiles/RunRe2j.java
		bash CompileAndMove.sh
		java -Xms16G -Xmx16G -cp /home/ubuntu/tardisFolder/tardisExperiments/bin/TARDISBenchmarks-junitcontest/re2j/target/classes:/home/ubuntu/tardisFolder/tardisProva/tardis/master/build/libs/tardis-master-0.2.0-SNAPSHOT.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/runtime/build/libs/sushi-lib-0.2.0-SNAPSHOT.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/jbse/build/libs/jbse-0.10.0-SNAPSHOT-shaded.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/args4j/args4j/2.32/1ccacebdf8f2db750eb09a402969050f27695fb7/args4j-2.32.jar:/usr/lib/jvm/java-8-openjdk-amd64/lib/tools.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/com.opencsv/opencsv/5.0/6aa7ff327f0ad7e3e9dabd6fe29ee19122b382c3/opencsv-5.0.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/com.github.javaparser/javaparser-core/3.15.9/998ab964f295e6cecd4467a76d4a6369a8193e5a/javaparser-core-3.15.9.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/jbse/libs/javassist.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/org.jacoco/org.jacoco.core/0.7.5.201505241946/1ea906dc5201d2a1bc0604f8650534d4bcaf4c95/org.jacoco.core-0.7.5.201505241946.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/org.ow2.asm/asm-debug-all/5.0.1/f69b5f7d96cec0d448acf1c1a266584170c9643b/asm-debug-all-5.0.1.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/junit/junit/4.12/2973d150c0dc1fefe998f834810d68f278ea58ec/junit-4.12.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/org.hamcrest/hamcrest-core/1.3/42a25dc3219429f0e5d060061f71acb49bf010a0/hamcrest-core-1.3.jar:/home/ubuntu/tardisFolder/tardisExperiments/bin/TARDISBenchmarks-junitcontest/re2j/dependencies/* settings.RunRe2j |& tee /home/ubuntu/tardisFolder/tardisExperiments/$dt/tardisLog$BENCHMARK.txt
	done
fi

#Spoon
if [ $input == "17" ] || [ $input == "1" ]; then
	sed -i "s/\(setNumOfThreads(\).*\();\)/\1$thread\2/g
			s/\(setNumMOSATargets(\).*\();\)/\1$mosa\2/g
			s/\(setEvosuiteTimeBudgetDuration(\).*\();\)/\1$evosuiteTime\2/g
			s/\(setGlobalTimeBudgetDuration(\).*\();\)/\1$globalTime\2/g" RunFiles/RunSpoon.java
	for BENCHMARK in TARGET_CLASS_105 TARGET_CLASS_155 TARGET_CLASS_16 TARGET_CLASS_169 TARGET_CLASS_20 TARGET_CLASS_211 TARGET_CLASS_25 TARGET_CLASS_253 TARGET_CLASS_32 TARGET_CLASS_65
	do
		echo "[TARDIS LAUNCHER] Run benchmark SPOON -- Target class: $BENCHMARK"
		sed -i "s/\(setTargetClass(\).*\();\)/\1$BENCHMARK\2/g" RunFiles/RunSpoon.java
		bash CompileAndMove.sh
		java -Xms16G -Xmx16G -cp /home/ubuntu/tardisFolder/tardisExperiments/bin/TARDISBenchmarks-junitcontest/spoon/target/classes:/home/ubuntu/tardisFolder/tardisProva/tardis/master/build/libs/tardis-master-0.2.0-SNAPSHOT.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/runtime/build/libs/sushi-lib-0.2.0-SNAPSHOT.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/jbse/build/libs/jbse-0.10.0-SNAPSHOT-shaded.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/args4j/args4j/2.32/1ccacebdf8f2db750eb09a402969050f27695fb7/args4j-2.32.jar:/usr/lib/jvm/java-8-openjdk-amd64/lib/tools.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/com.opencsv/opencsv/5.0/6aa7ff327f0ad7e3e9dabd6fe29ee19122b382c3/opencsv-5.0.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/com.github.javaparser/javaparser-core/3.15.9/998ab964f295e6cecd4467a76d4a6369a8193e5a/javaparser-core-3.15.9.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/jbse/libs/javassist.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/org.jacoco/org.jacoco.core/0.7.5.201505241946/1ea906dc5201d2a1bc0604f8650534d4bcaf4c95/org.jacoco.core-0.7.5.201505241946.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/org.ow2.asm/asm-debug-all/5.0.1/f69b5f7d96cec0d448acf1c1a266584170c9643b/asm-debug-all-5.0.1.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/junit/junit/4.12/2973d150c0dc1fefe998f834810d68f278ea58ec/junit-4.12.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/org.hamcrest/hamcrest-core/1.3/42a25dc3219429f0e5d060061f71acb49bf010a0/hamcrest-core-1.3.jar:/home/ubuntu/tardisFolder/tardisExperiments/bin/TARDISBenchmarks-junitcontest/spoon/dependencies/* settings.RunSpoon |& tee /home/ubuntu/tardisFolder/tardisExperiments/$dt/tardisLog$BENCHMARK.txt
	done
fi

#Webmagic
if [ $input == "18" ] || [ $input == "1" ]; then
	sed -i "s/\(setNumOfThreads(\).*\();\)/\1$thread\2/g
			s/\(setNumMOSATargets(\).*\();\)/\1$mosa\2/g
			s/\(setEvosuiteTimeBudgetDuration(\).*\();\)/\1$evosuiteTime\2/g
			s/\(setGlobalTimeBudgetDuration(\).*\();\)/\1$globalTime\2/g" RunFiles/RunWebmagic1_5.java
	sed -i "s/\(setNumOfThreads(\).*\();\)/\1$thread\2/g
			s/\(setNumMOSATargets(\).*\();\)/\1$mosa\2/g
			s/\(setEvosuiteTimeBudgetDuration(\).*\();\)/\1$evosuiteTime\2/g
			s/\(setGlobalTimeBudgetDuration(\).*\();\)/\1$globalTime\2/g" RunFiles/RunWebmagic2_3_4.java
	for BENCHMARK in TARGET_CLASS_1 TARGET_CLASS_5
	do
		echo "[TARDIS LAUNCHER] Run benchmark WEBMAGIC -- Target class: $BENCHMARK"
		sed -i "s/\(setTargetClass(\).*\();\)/\1$BENCHMARK\2/g" RunFiles/RunWebmagic1_5.java
		bash CompileAndMove.sh
		java -Xms16G -Xmx16G -cp /home/ubuntu/tardisFolder/tardisExperiments/bin/TARDISBenchmarks-junitcontest/webmagic/webmagic-extension/target/classes:/home/ubuntu/tardisFolder/tardisExperiments/bin/TARDISBenchmarks-junitcontest/webmagic/webmagic-core/target/classes:/home/ubuntu/tardisFolder/tardisProva/tardis/master/build/libs/tardis-master-0.2.0-SNAPSHOT.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/runtime/build/libs/sushi-lib-0.2.0-SNAPSHOT.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/jbse/build/libs/jbse-0.10.0-SNAPSHOT-shaded.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/args4j/args4j/2.32/1ccacebdf8f2db750eb09a402969050f27695fb7/args4j-2.32.jar:/usr/lib/jvm/java-8-openjdk-amd64/lib/tools.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/com.opencsv/opencsv/5.0/6aa7ff327f0ad7e3e9dabd6fe29ee19122b382c3/opencsv-5.0.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/com.github.javaparser/javaparser-core/3.15.9/998ab964f295e6cecd4467a76d4a6369a8193e5a/javaparser-core-3.15.9.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/jbse/libs/javassist.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/org.jacoco/org.jacoco.core/0.7.5.201505241946/1ea906dc5201d2a1bc0604f8650534d4bcaf4c95/org.jacoco.core-0.7.5.201505241946.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/org.ow2.asm/asm-debug-all/5.0.1/f69b5f7d96cec0d448acf1c1a266584170c9643b/asm-debug-all-5.0.1.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/junit/junit/4.12/2973d150c0dc1fefe998f834810d68f278ea58ec/junit-4.12.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/org.hamcrest/hamcrest-core/1.3/42a25dc3219429f0e5d060061f71acb49bf010a0/hamcrest-core-1.3.jar:/home/ubuntu/tardisFolder/tardisExperiments/bin/TARDISBenchmarks-junitcontest/webmagic/dependencies/* settings.RunWebmagic1_5 |& tee /home/ubuntu/tardisFolder/tardisExperiments/$dt/tardisLog$BENCHMARK.txt
	done
	for BENCHMARK in TARGET_CLASS_2 TARGET_CLASS_3 TARGET_CLASS_4
	do
		echo "[TARDIS LAUNCHER] Run benchmark WEBMAGIC -- Target class: $BENCHMARK"
		sed -i "s/\(setTargetClass(\).*\();\)/\1$BENCHMARK\2/g" RunFiles/RunWebmagic2_3_4.java
		bash CompileAndMove.sh
		java -Xms16G -Xmx16G -cp /home/ubuntu/tardisFolder/tardisExperiments/bin/TARDISBenchmarks-junitcontest/webmagic/webmagic-core/target/classes:/home/ubuntu/tardisFolder/tardisProva/tardis/master/build/libs/tardis-master-0.2.0-SNAPSHOT.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/runtime/build/libs/sushi-lib-0.2.0-SNAPSHOT.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/jbse/build/libs/jbse-0.10.0-SNAPSHOT-shaded.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/args4j/args4j/2.32/1ccacebdf8f2db750eb09a402969050f27695fb7/args4j-2.32.jar:/usr/lib/jvm/java-8-openjdk-amd64/lib/tools.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/com.opencsv/opencsv/5.0/6aa7ff327f0ad7e3e9dabd6fe29ee19122b382c3/opencsv-5.0.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/com.github.javaparser/javaparser-core/3.15.9/998ab964f295e6cecd4467a76d4a6369a8193e5a/javaparser-core-3.15.9.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/jbse/libs/javassist.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/org.jacoco/org.jacoco.core/0.7.5.201505241946/1ea906dc5201d2a1bc0604f8650534d4bcaf4c95/org.jacoco.core-0.7.5.201505241946.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/org.ow2.asm/asm-debug-all/5.0.1/f69b5f7d96cec0d448acf1c1a266584170c9643b/asm-debug-all-5.0.1.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/junit/junit/4.12/2973d150c0dc1fefe998f834810d68f278ea58ec/junit-4.12.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/org.hamcrest/hamcrest-core/1.3/42a25dc3219429f0e5d060061f71acb49bf010a0/hamcrest-core-1.3.jar:/home/ubuntu/tardisFolder/tardisExperiments/bin/TARDISBenchmarks-junitcontest/webmagic/dependencies/* settings.RunWebmagic2_3_4 |& tee /home/ubuntu/tardisFolder/tardisExperiments/$dt/tardisLog$BENCHMARK.txt
	done
fi

#Zxing
if [ $input == "19" ] || [ $input == "1" ]; then
	sed -i "s/\(setNumOfThreads(\).*\();\)/\1$thread\2/g
			s/\(setNumMOSATargets(\).*\();\)/\1$mosa\2/g
			s/\(setEvosuiteTimeBudgetDuration(\).*\();\)/\1$evosuiteTime\2/g
			s/\(setGlobalTimeBudgetDuration(\).*\();\)/\1$globalTime\2/g" RunFiles/RunZxing.java
	for BENCHMARK in TARGET_CLASS_1 TARGET_CLASS_2 TARGET_CLASS_3 TARGET_CLASS_4 TARGET_CLASS_5 TARGET_CLASS_6 TARGET_CLASS_7 TARGET_CLASS_8 TARGET_CLASS_9 TARGET_CLASS_10
	do
		echo "[TARDIS LAUNCHER] Run benchmark ZXING -- Target class: $BENCHMARK"
		sed -i "s/\(setTargetClass(\).*\();\)/\1$BENCHMARK\2/g" RunFiles/RunZxing.java
		bash CompileAndMove.sh
		java -Xms16G -Xmx16G -cp /home/ubuntu/tardisFolder/tardisExperiments/bin/TARDISBenchmarks-junitcontest/zxing/core/target/classes:/home/ubuntu/tardisFolder/tardisProva/tardis/master/build/libs/tardis-master-0.2.0-SNAPSHOT.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/runtime/build/libs/sushi-lib-0.2.0-SNAPSHOT.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/jbse/build/libs/jbse-0.10.0-SNAPSHOT-shaded.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/args4j/args4j/2.32/1ccacebdf8f2db750eb09a402969050f27695fb7/args4j-2.32.jar:/usr/lib/jvm/java-8-openjdk-amd64/lib/tools.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/com.opencsv/opencsv/5.0/6aa7ff327f0ad7e3e9dabd6fe29ee19122b382c3/opencsv-5.0.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/com.github.javaparser/javaparser-core/3.15.9/998ab964f295e6cecd4467a76d4a6369a8193e5a/javaparser-core-3.15.9.jar:/home/ubuntu/tardisFolder/tardisProva/tardis/jbse/libs/javassist.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/org.jacoco/org.jacoco.core/0.7.5.201505241946/1ea906dc5201d2a1bc0604f8650534d4bcaf4c95/org.jacoco.core-0.7.5.201505241946.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/org.ow2.asm/asm-debug-all/5.0.1/f69b5f7d96cec0d448acf1c1a266584170c9643b/asm-debug-all-5.0.1.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/junit/junit/4.12/2973d150c0dc1fefe998f834810d68f278ea58ec/junit-4.12.jar:/home/ubuntu/.gradle/caches/modules-2/files-2.1/org.hamcrest/hamcrest-core/1.3/42a25dc3219429f0e5d060061f71acb49bf010a0/hamcrest-core-1.3.jar:/home/ubuntu/tardisFolder/tardisExperiments/bin/TARDISBenchmarks-junitcontest/zxing/dependencies/* settings.RunZxing |& tee /home/ubuntu/tardisFolder/tardisExperiments/$dt/tardisLog$BENCHMARK.txt
	done
fi

echo "[TARDIS LAUNCHER] ENDING at $(date)"