#!/bin/sh
echo "[TARDIS LAUNCHER] STARTING at $(date)"

# Edit TARDIS_HOME_PATH, Z3_PATH, REPO_HOME_PATH, GRADLE_REPO_PATH, LOG_PATH and TOOLSJAR_PATH to reflect the paths where you installed the code:
# TARDIS_HOME_PATH: Folder where TARDIS is installed
# Z3_PATH: 			Folder where Z3 is installed
# REPO_HOME_PATH: 	Home folder of this repository
# GRADLE_REPO_PATH: Gradle folder
# LOG_PATH: 		Folder where you want to save the TARDIS logs
# TOOLSJAR_PATH: 	tools.jar path
TARDIS_HOME_PATH=/home/ubuntu/tardisFolder/tardisProva/tardis
Z3_PATH=/home/ubuntu/bin/z3
REPO_HOME_PATH=/home/ubuntu/tardisFolder/tardisExperiments/bin/TARDISBenchmarks-junitcontest
GRADLE_REPO_PATH=/home/ubuntu/.gradle
LOG_PATH=/home/ubuntu/tardisFolder/tardisExperiments
TOOLSJAR_PATH=/usr/lib/jvm/java-8-openjdk-amd64/lib

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
mkdir $LOG_PATH/$dt

TARDIS_HOME_PATH_ESC=$(echo $TARDIS_HOME_PATH | sed 's_/_\\/_g')
Z3_PATH_ESC=$(echo $Z3_PATH | sed 's_/_\\/_g')
REPO_HOME_PATH_ESC=$(echo $REPO_HOME_PATH | sed 's_/_\\/_g')

javac CalculateResults.java && echo "[TARDIS LAUNCHER] CalculateResults.java compiled" || echo "[TARDIS LAUNCHER] Failed"

#Authzforce
if [ $input == "2" ] || [ $input == "1" ]; then
	mkdir $LOG_PATH/$dt/AUTHZFORCE
	sed -i "14s/\(Paths.get(\"\).*\(\");\)/\1$TARDIS_HOME_PATH_ESC\2/
			15s/\(Paths.get(\"\).*\(\");\)/\1$Z3_PATH_ESC\2/
			16s/\(Paths.get(\"\).*\(\");\)/\1$REPO_HOME_PATH_ESC\/core-release-13.3.0\2/
			s/\(setNumOfThreads(\).*\();\)/\1$thread\2/g
			s/\(setNumMOSATargets(\).*\();\)/\1$mosa\2/g
			s/\(setEvosuiteTimeBudgetDuration(\).*\();\)/\1$evosuiteTime\2/g
			s/\(setGlobalTimeBudgetDuration(\).*\();\)/\1$globalTime\2/g" RunFiles/RunAuthzforce1.java
	for BENCHMARK in TARGET_CLASS_1 TARGET_CLASS_11 TARGET_CLASS_27 TARGET_CLASS_32 TARGET_CLASS_33 TARGET_CLASS_48 TARGET_CLASS_5 TARGET_CLASS_52 TARGET_CLASS_63 TARGET_CLASS_65
	do
		echo "[TARDIS LAUNCHER] Run benchmark AUTHZFORCE -- Target class: $BENCHMARK"
		sed -i "s/\(setTargetClass(\).*\();\)/\1$BENCHMARK\2/g" RunFiles/RunAuthzforce1.java
		bash CompileAndMove.sh
		timeout -s 9 21m java -Xms16G -Xmx16G -cp $REPO_HOME_PATH/core-release-13.3.0/pdp-engine/target/classes:$TARDIS_HOME_PATH/master/build/libs/tardis-master-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/runtime/build/libs/sushi-lib-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/jbse/build/libs/jbse-0.10.0-SNAPSHOT-shaded.jar:$TARDIS_HOME_PATH/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/args4j/args4j/2.32/1ccacebdf8f2db750eb09a402969050f27695fb7/args4j-2.32.jar:$TOOLSJAR_PATH/tools.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/com.opencsv/opencsv/5.0/6aa7ff327f0ad7e3e9dabd6fe29ee19122b382c3/opencsv-5.0.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/com.github.javaparser/javaparser-core/3.15.9/998ab964f295e6cecd4467a76d4a6369a8193e5a/javaparser-core-3.15.9.jar:$TARDIS_HOME_PATH/jbse/libs/javassist.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.jacoco/org.jacoco.core/0.7.5.201505241946/1ea906dc5201d2a1bc0604f8650534d4bcaf4c95/org.jacoco.core-0.7.5.201505241946.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.ow2.asm/asm-debug-all/5.0.1/f69b5f7d96cec0d448acf1c1a266584170c9643b/asm-debug-all-5.0.1.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/junit/junit/4.12/2973d150c0dc1fefe998f834810d68f278ea58ec/junit-4.12.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.hamcrest/hamcrest-core/1.3/42a25dc3219429f0e5d060061f71acb49bf010a0/hamcrest-core-1.3.jar:$REPO_HOME_PATH/core-release-13.3.0/dependencies/* settings.RunAuthzforce1 |& tee $LOG_PATH/$dt/AUTHZFORCE/tardisLog$BENCHMARK.txt
		echo "[TARDIS LAUNCHER] Tardis execution finished. Calculate results"
		java CalculateResults $LOG_PATH/$dt/AUTHZFORCE/tardisLog$BENCHMARK.txt $LOG_PATH/$dt/Results.csv Authzforce$BENCHMARK
	done
fi

#Bcel
if [ $input == "3" ] || [ $input == "1" ]; then
	mkdir $LOG_PATH/$dt/BCEL
	sed -i "14s/\(Paths.get(\"\).*\(\");\)/\1$TARDIS_HOME_PATH_ESC\2/
			15s/\(Paths.get(\"\).*\(\");\)/\1$Z3_PATH_ESC\2/
			16s/\(Paths.get(\"\).*\(\");\)/\1$REPO_HOME_PATH_ESC\/bcel-6.0-src\2/
			s/\(setNumOfThreads(\).*\();\)/\1$thread\2/g
			s/\(setNumMOSATargets(\).*\();\)/\1$mosa\2/g
			s/\(setEvosuiteTimeBudgetDuration(\).*\();\)/\1$evosuiteTime\2/g
			s/\(setGlobalTimeBudgetDuration(\).*\();\)/\1$globalTime\2/g" RunFiles/RunBcel.java
	for BENCHMARK in TARGET_CLASS_1 TARGET_CLASS_2 TARGET_CLASS_3 TARGET_CLASS_4 TARGET_CLASS_5 TARGET_CLASS_6 TARGET_CLASS_7 TARGET_CLASS_8 TARGET_CLASS_9 TARGET_CLASS_10
	do
		echo "[TARDIS LAUNCHER] Run benchmark BCEL -- Target class: $BENCHMARK"
		sed -i "s/\(setTargetClass(\).*\();\)/\1$BENCHMARK\2/g" RunFiles/RunBcel.java
		bash CompileAndMove.sh
		timeout -s 9 21m java -Xms16G -Xmx16G -cp $REPO_HOME_PATH/bcel-6.0-src/target/classes:$TARDIS_HOME_PATH/master/build/libs/tardis-master-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/runtime/build/libs/sushi-lib-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/jbse/build/libs/jbse-0.10.0-SNAPSHOT-shaded.jar:$TARDIS_HOME_PATH/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/args4j/args4j/2.32/1ccacebdf8f2db750eb09a402969050f27695fb7/args4j-2.32.jar:$TOOLSJAR_PATH/tools.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/com.opencsv/opencsv/5.0/6aa7ff327f0ad7e3e9dabd6fe29ee19122b382c3/opencsv-5.0.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/com.github.javaparser/javaparser-core/3.15.9/998ab964f295e6cecd4467a76d4a6369a8193e5a/javaparser-core-3.15.9.jar:$TARDIS_HOME_PATH/jbse/libs/javassist.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.jacoco/org.jacoco.core/0.7.5.201505241946/1ea906dc5201d2a1bc0604f8650534d4bcaf4c95/org.jacoco.core-0.7.5.201505241946.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.ow2.asm/asm-debug-all/5.0.1/f69b5f7d96cec0d448acf1c1a266584170c9643b/asm-debug-all-5.0.1.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/junit/junit/4.12/2973d150c0dc1fefe998f834810d68f278ea58ec/junit-4.12.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.hamcrest/hamcrest-core/1.3/42a25dc3219429f0e5d060061f71acb49bf010a0/hamcrest-core-1.3.jar:$REPO_HOME_PATH/bcel-6.0-src/dependencies/* settings.RunBcel |& tee $LOG_PATH/$dt/BCEL/tardisLog$BENCHMARK.txt
		echo "[TARDIS LAUNCHER] Tardis execution finished. Calculate results"
		java CalculateResults $LOG_PATH/$dt/BCEL/tardisLog$BENCHMARK.txt $LOG_PATH/$dt/Results.csv Bcel$BENCHMARK
	done
fi

#Dubbo
if [ $input == "4" ] || [ $input == "1" ]; then
	mkdir $LOG_PATH/$dt/DUBBO
	sed -i "14s/\(Paths.get(\"\).*\(\");\)/\1$TARDIS_HOME_PATH_ESC\2/
			15s/\(Paths.get(\"\).*\(\");\)/\1$Z3_PATH_ESC\2/
			16s/\(Paths.get(\"\).*\(\");\)/\1$REPO_HOME_PATH_ESC\/dubbo\2/
			s/\(setNumOfThreads(\).*\();\)/\1$thread\2/g
			s/\(setNumMOSATargets(\).*\();\)/\1$mosa\2/g
			s/\(setEvosuiteTimeBudgetDuration(\).*\();\)/\1$evosuiteTime\2/g
			s/\(setGlobalTimeBudgetDuration(\).*\();\)/\1$globalTime\2/g" RunFiles/RunDubbo.java
	for BENCHMARK in TARGET_CLASS_2 TARGET_CLASS_3 TARGET_CLASS_4 TARGET_CLASS_5 TARGET_CLASS_6 TARGET_CLASS_7 TARGET_CLASS_8 TARGET_CLASS_9 TARGET_CLASS_10
	do
		echo "[TARDIS LAUNCHER] Run benchmark DUBBO -- Target class: $BENCHMARK"
		sed -i "s/\(setTargetClass(\).*\();\)/\1$BENCHMARK\2/g" RunFiles/RunDubbo.java
		bash CompileAndMove.sh
		timeout -s 9 21m java -Xms16G -Xmx16G -cp $REPO_HOME_PATH/dubbo/dubbo-common/target/classes:$TARDIS_HOME_PATH/master/build/libs/tardis-master-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/runtime/build/libs/sushi-lib-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/jbse/build/libs/jbse-0.10.0-SNAPSHOT-shaded.jar:$TARDIS_HOME_PATH/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/args4j/args4j/2.32/1ccacebdf8f2db750eb09a402969050f27695fb7/args4j-2.32.jar:$TOOLSJAR_PATH/tools.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/com.opencsv/opencsv/5.0/6aa7ff327f0ad7e3e9dabd6fe29ee19122b382c3/opencsv-5.0.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/com.github.javaparser/javaparser-core/3.15.9/998ab964f295e6cecd4467a76d4a6369a8193e5a/javaparser-core-3.15.9.jar:$TARDIS_HOME_PATH/jbse/libs/javassist.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.jacoco/org.jacoco.core/0.7.5.201505241946/1ea906dc5201d2a1bc0604f8650534d4bcaf4c95/org.jacoco.core-0.7.5.201505241946.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.ow2.asm/asm-debug-all/5.0.1/f69b5f7d96cec0d448acf1c1a266584170c9643b/asm-debug-all-5.0.1.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/junit/junit/4.12/2973d150c0dc1fefe998f834810d68f278ea58ec/junit-4.12.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.hamcrest/hamcrest-core/1.3/42a25dc3219429f0e5d060061f71acb49bf010a0/hamcrest-core-1.3.jar:$REPO_HOME_PATH/dubbo/dependencies/* settings.RunDubbo |& tee $LOG_PATH/$dt/DUBBO/tardisLog$BENCHMARK.txt
		echo "[TARDIS LAUNCHER] Tardis execution finished. Calculate results"
		java CalculateResults $LOG_PATH/$dt/DUBBO/tardisLog$BENCHMARK.txt $LOG_PATH/$dt/Results.csv Dubbo$BENCHMARK
	done
fi

#Fastjson
if [ $input == "5" ] || [ $input == "1" ]; then
	mkdir $LOG_PATH/$dt/FASTJSON
	sed -i "14s/\(Paths.get(\"\).*\(\");\)/\1$TARDIS_HOME_PATH_ESC\2/
			15s/\(Paths.get(\"\).*\(\");\)/\1$Z3_PATH_ESC\2/
			16s/\(Paths.get(\"\).*\(\");\)/\1$REPO_HOME_PATH_ESC\/fastjson\2/
			s/\(setNumOfThreads(\).*\();\)/\1$thread\2/g
			s/\(setNumMOSATargets(\).*\();\)/\1$mosa\2/g
			s/\(setEvosuiteTimeBudgetDuration(\).*\();\)/\1$evosuiteTime\2/g
			s/\(setGlobalTimeBudgetDuration(\).*\();\)/\1$globalTime\2/g" RunFiles/RunFastjson.java
	for BENCHMARK in TARGET_CLASS_1 TARGET_CLASS_2 TARGET_CLASS_3 TARGET_CLASS_4 TARGET_CLASS_5 TARGET_CLASS_6 TARGET_CLASS_7 TARGET_CLASS_8 TARGET_CLASS_9 TARGET_CLASS_10
	do
		echo "[TARDIS LAUNCHER] Run benchmark FASTJSON -- Target class: $BENCHMARK"
		sed -i "s/\(setTargetClass(\).*\();\)/\1$BENCHMARK\2/g" RunFiles/RunFastjson.java
		bash CompileAndMove.sh
		timeout -s 9 21m java -Xms16G -Xmx16G -cp $REPO_HOME_PATH/fastjson/target/classes:$TARDIS_HOME_PATH/master/build/libs/tardis-master-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/runtime/build/libs/sushi-lib-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/jbse/build/libs/jbse-0.10.0-SNAPSHOT-shaded.jar:$TARDIS_HOME_PATH/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/args4j/args4j/2.32/1ccacebdf8f2db750eb09a402969050f27695fb7/args4j-2.32.jar:$TOOLSJAR_PATH/tools.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/com.opencsv/opencsv/5.0/6aa7ff327f0ad7e3e9dabd6fe29ee19122b382c3/opencsv-5.0.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/com.github.javaparser/javaparser-core/3.15.9/998ab964f295e6cecd4467a76d4a6369a8193e5a/javaparser-core-3.15.9.jar:$TARDIS_HOME_PATH/jbse/libs/javassist.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.jacoco/org.jacoco.core/0.7.5.201505241946/1ea906dc5201d2a1bc0604f8650534d4bcaf4c95/org.jacoco.core-0.7.5.201505241946.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.ow2.asm/asm-debug-all/5.0.1/f69b5f7d96cec0d448acf1c1a266584170c9643b/asm-debug-all-5.0.1.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/junit/junit/4.12/2973d150c0dc1fefe998f834810d68f278ea58ec/junit-4.12.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.hamcrest/hamcrest-core/1.3/42a25dc3219429f0e5d060061f71acb49bf010a0/hamcrest-core-1.3.jar:$REPO_HOME_PATH/fastjson/dependencies/* settings.RunFastjson |& tee $LOG_PATH/$dt/FASTJSON/tardisLog$BENCHMARK.txt
		echo "[TARDIS LAUNCHER] Tardis execution finished. Calculate results"
		java CalculateResults $LOG_PATH/$dt/FASTJSON/tardisLog$BENCHMARK.txt $LOG_PATH/$dt/Results.csv Fastjson$BENCHMARK
	done
fi

#Fescar
if [ $input == "6" ] || [ $input == "1" ]; then
	mkdir $LOG_PATH/$dt/FESCAR
	sed -i "14s/\(Paths.get(\"\).*\(\");\)/\1$TARDIS_HOME_PATH_ESC\2/
			15s/\(Paths.get(\"\).*\(\");\)/\1$Z3_PATH_ESC\2/
			16s/\(Paths.get(\"\).*\(\");\)/\1$REPO_HOME_PATH_ESC\/fescar\2/
			s/\(setNumOfThreads(\).*\();\)/\1$thread\2/g
			s/\(setNumMOSATargets(\).*\();\)/\1$mosa\2/g
			s/\(setEvosuiteTimeBudgetDuration(\).*\();\)/\1$evosuiteTime\2/g
			s/\(setGlobalTimeBudgetDuration(\).*\();\)/\1$globalTime\2/g" RunFiles/RunFescar.java
	for BENCHMARK in TARGET_CLASS_1 TARGET_CLASS_12 TARGET_CLASS_18 TARGET_CLASS_23 TARGET_CLASS_25 TARGET_CLASS_36 TARGET_CLASS_37 TARGET_CLASS_41 TARGET_CLASS_42 TARGET_CLASS_7 TARGET_CLASS_2 TARGET_CLASS_5 TARGET_CLASS_6 TARGET_CLASS_8 TARGET_CLASS_9 TARGET_CLASS_10 TARGET_CLASS_13 TARGET_CLASS_15 TARGET_CLASS_17 TARGET_CLASS_28 TARGET_CLASS_32 TARGET_CLASS_33 TARGET_CLASS_34
	do
		echo "[TARDIS LAUNCHER] Run benchmark FESCAR -- Target class: $BENCHMARK"
		sed -i "s/\(setTargetClass(\).*\();\)/\1$BENCHMARK\2/g" RunFiles/RunFescar.java
		bash CompileAndMove.sh
		timeout -s 9 21m java -Xms16G -Xmx16G -cp $REPO_HOME_PATH/fescar/core/target/classes:$TARDIS_HOME_PATH/master/build/libs/tardis-master-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/runtime/build/libs/sushi-lib-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/jbse/build/libs/jbse-0.10.0-SNAPSHOT-shaded.jar:$TARDIS_HOME_PATH/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/args4j/args4j/2.32/1ccacebdf8f2db750eb09a402969050f27695fb7/args4j-2.32.jar:$TOOLSJAR_PATH/tools.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/com.opencsv/opencsv/5.0/6aa7ff327f0ad7e3e9dabd6fe29ee19122b382c3/opencsv-5.0.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/com.github.javaparser/javaparser-core/3.15.9/998ab964f295e6cecd4467a76d4a6369a8193e5a/javaparser-core-3.15.9.jar:$TARDIS_HOME_PATH/jbse/libs/javassist.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.jacoco/org.jacoco.core/0.7.5.201505241946/1ea906dc5201d2a1bc0604f8650534d4bcaf4c95/org.jacoco.core-0.7.5.201505241946.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.ow2.asm/asm-debug-all/5.0.1/f69b5f7d96cec0d448acf1c1a266584170c9643b/asm-debug-all-5.0.1.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/junit/junit/4.12/2973d150c0dc1fefe998f834810d68f278ea58ec/junit-4.12.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.hamcrest/hamcrest-core/1.3/42a25dc3219429f0e5d060061f71acb49bf010a0/hamcrest-core-1.3.jar:$REPO_HOME_PATH/fescar/dependencies/* settings.RunFescar |& tee $LOG_PATH/$dt/FESCAR/tardisLog$BENCHMARK.txt
		echo "[TARDIS LAUNCHER] Tardis execution finished. Calculate results"
		java CalculateResults $LOG_PATH/$dt/FESCAR/tardisLog$BENCHMARK.txt $LOG_PATH/$dt/Results.csv Fescar$BENCHMARK
	done
fi

#Gson
if [ $input == "7" ] || [ $input == "1" ]; then
	mkdir $LOG_PATH/$dt/GSON
	sed -i "14s/\(Paths.get(\"\).*\(\");\)/\1$TARDIS_HOME_PATH_ESC\2/
			15s/\(Paths.get(\"\).*\(\");\)/\1$Z3_PATH_ESC\2/
			16s/\(Paths.get(\"\).*\(\");\)/\1$REPO_HOME_PATH_ESC\/gson\2/
			s/\(setNumOfThreads(\).*\();\)/\1$thread\2/g
			s/\(setNumMOSATargets(\).*\();\)/\1$mosa\2/g
			s/\(setEvosuiteTimeBudgetDuration(\).*\();\)/\1$evosuiteTime\2/g
			s/\(setGlobalTimeBudgetDuration(\).*\();\)/\1$globalTime\2/g" RunFiles/RunGson.java
	for BENCHMARK in TARGET_CLASS_1 TARGET_CLASS_2 TARGET_CLASS_3 TARGET_CLASS_4 TARGET_CLASS_5 TARGET_CLASS_6 TARGET_CLASS_7 TARGET_CLASS_8 TARGET_CLASS_9 TARGET_CLASS_10
	do
		echo "[TARDIS LAUNCHER] Run benchmark GSON -- Target class: $BENCHMARK"
		sed -i "s/\(setTargetClass(\).*\();\)/\1$BENCHMARK\2/g" RunFiles/RunGson.java
		bash CompileAndMove.sh
		timeout -s 9 21m java -Xms16G -Xmx16G -cp $REPO_HOME_PATH/gson/gson/target/classes:$TARDIS_HOME_PATH/master/build/libs/tardis-master-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/runtime/build/libs/sushi-lib-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/jbse/build/libs/jbse-0.10.0-SNAPSHOT-shaded.jar:$TARDIS_HOME_PATH/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/args4j/args4j/2.32/1ccacebdf8f2db750eb09a402969050f27695fb7/args4j-2.32.jar:$TOOLSJAR_PATH/tools.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/com.opencsv/opencsv/5.0/6aa7ff327f0ad7e3e9dabd6fe29ee19122b382c3/opencsv-5.0.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/com.github.javaparser/javaparser-core/3.15.9/998ab964f295e6cecd4467a76d4a6369a8193e5a/javaparser-core-3.15.9.jar:$TARDIS_HOME_PATH/jbse/libs/javassist.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.jacoco/org.jacoco.core/0.7.5.201505241946/1ea906dc5201d2a1bc0604f8650534d4bcaf4c95/org.jacoco.core-0.7.5.201505241946.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.ow2.asm/asm-debug-all/5.0.1/f69b5f7d96cec0d448acf1c1a266584170c9643b/asm-debug-all-5.0.1.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/junit/junit/4.12/2973d150c0dc1fefe998f834810d68f278ea58ec/junit-4.12.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.hamcrest/hamcrest-core/1.3/42a25dc3219429f0e5d060061f71acb49bf010a0/hamcrest-core-1.3.jar:$REPO_HOME_PATH/gson/dependencies/* settings.RunGson |& tee $LOG_PATH/$dt/GSON/tardisLog$BENCHMARK.txt
		echo "[TARDIS LAUNCHER] Tardis execution finished. Calculate results"
		java CalculateResults $LOG_PATH/$dt/GSON/tardisLog$BENCHMARK.txt $LOG_PATH/$dt/Results.csv Gson$BENCHMARK
	done
fi

#Guava
if [ $input == "8" ] || [ $input == "1" ]; then
	mkdir $LOG_PATH/$dt/GUAVA
	sed -i "14s/\(Paths.get(\"\).*\(\");\)/\1$TARDIS_HOME_PATH_ESC\2/
			15s/\(Paths.get(\"\).*\(\");\)/\1$Z3_PATH_ESC\2/
			16s/\(Paths.get(\"\).*\(\");\)/\1$REPO_HOME_PATH_ESC\/guava\2/
			s/\(setNumOfThreads(\).*\();\)/\1$thread\2/g
			s/\(setNumMOSATargets(\).*\();\)/\1$mosa\2/g
			s/\(setEvosuiteTimeBudgetDuration(\).*\();\)/\1$evosuiteTime\2/g
			s/\(setGlobalTimeBudgetDuration(\).*\();\)/\1$globalTime\2/g" RunFiles/RunGuava.java
	for BENCHMARK in TARGET_CLASS_2 TARGET_CLASS_22 TARGET_CLASS_39 TARGET_CLASS_47 TARGET_CLASS_90 TARGET_CLASS_95 TARGET_CLASS_102 TARGET_CLASS_110 TARGET_CLASS_128 TARGET_CLASS_129 TARGET_CLASS_159 TARGET_CLASS_169 TARGET_CLASS_177 TARGET_CLASS_181 TARGET_CLASS_184 TARGET_CLASS_196 TARGET_CLASS_206 TARGET_CLASS_212 TARGET_CLASS_224 TARGET_CLASS_240
	do
		echo "[TARDIS LAUNCHER] Run benchmark GUAVA -- Target class: $BENCHMARK"
		sed -i "s/\(setTargetClass(\).*\();\)/\1$BENCHMARK\2/g" RunFiles/RunGuava.java
		bash CompileAndMove.sh
		timeout -s 9 21m java -Xms16G -Xmx16G -cp $REPO_HOME_PATH/guava/guava/target/classes:$TARDIS_HOME_PATH/master/build/libs/tardis-master-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/runtime/build/libs/sushi-lib-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/jbse/build/libs/jbse-0.10.0-SNAPSHOT-shaded.jar:$TARDIS_HOME_PATH/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/args4j/args4j/2.32/1ccacebdf8f2db750eb09a402969050f27695fb7/args4j-2.32.jar:$TOOLSJAR_PATH/tools.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/com.opencsv/opencsv/5.0/6aa7ff327f0ad7e3e9dabd6fe29ee19122b382c3/opencsv-5.0.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/com.github.javaparser/javaparser-core/3.15.9/998ab964f295e6cecd4467a76d4a6369a8193e5a/javaparser-core-3.15.9.jar:$TARDIS_HOME_PATH/jbse/libs/javassist.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.jacoco/org.jacoco.core/0.7.5.201505241946/1ea906dc5201d2a1bc0604f8650534d4bcaf4c95/org.jacoco.core-0.7.5.201505241946.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.ow2.asm/asm-debug-all/5.0.1/f69b5f7d96cec0d448acf1c1a266584170c9643b/asm-debug-all-5.0.1.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/junit/junit/4.12/2973d150c0dc1fefe998f834810d68f278ea58ec/junit-4.12.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.hamcrest/hamcrest-core/1.3/42a25dc3219429f0e5d060061f71acb49bf010a0/hamcrest-core-1.3.jar:$REPO_HOME_PATH/guava/dependencies/* settings.RunGuava |& tee $LOG_PATH/$dt/GUAVA/tardisLog$BENCHMARK.txt
		echo "[TARDIS LAUNCHER] Tardis execution finished. Calculate results"
		java CalculateResults $LOG_PATH/$dt/GUAVA/tardisLog$BENCHMARK.txt $LOG_PATH/$dt/Results.csv Guava$BENCHMARK
	done
fi

#Image
if [ $input == "9" ] || [ $input == "1" ]; then
	mkdir $LOG_PATH/$dt/IMAGE
	sed -i "14s/\(Paths.get(\"\).*\(\");\)/\1$TARDIS_HOME_PATH_ESC\2/
			15s/\(Paths.get(\"\).*\(\");\)/\1$Z3_PATH_ESC\2/
			16s/\(Paths.get(\"\).*\(\");\)/\1$REPO_HOME_PATH_ESC\/commons-imaging\2/
			s/\(setNumOfThreads(\).*\();\)/\1$thread\2/g
			s/\(setNumMOSATargets(\).*\();\)/\1$mosa\2/g
			s/\(setEvosuiteTimeBudgetDuration(\).*\();\)/\1$evosuiteTime\2/g
			s/\(setGlobalTimeBudgetDuration(\).*\();\)/\1$globalTime\2/g" RunFiles/RunImage.java
	for BENCHMARK in TARGET_CLASS_1 TARGET_CLASS_2 TARGET_CLASS_3 TARGET_CLASS_4
	do
		echo "[TARDIS LAUNCHER] Run benchmark IMAGE -- Target class: $BENCHMARK"
		sed -i "s/\(setTargetClass(\).*\();\)/\1$BENCHMARK\2/g" RunFiles/RunImage.java
		bash CompileAndMove.sh
		timeout -s 9 21m java -Xms16G -Xmx16G -cp $REPO_HOME_PATH/commons-imaging/target/classes:$TARDIS_HOME_PATH/master/build/libs/tardis-master-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/runtime/build/libs/sushi-lib-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/jbse/build/libs/jbse-0.10.0-SNAPSHOT-shaded.jar:$TARDIS_HOME_PATH/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/args4j/args4j/2.32/1ccacebdf8f2db750eb09a402969050f27695fb7/args4j-2.32.jar:$TOOLSJAR_PATH/tools.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/com.opencsv/opencsv/5.0/6aa7ff327f0ad7e3e9dabd6fe29ee19122b382c3/opencsv-5.0.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/com.github.javaparser/javaparser-core/3.15.9/998ab964f295e6cecd4467a76d4a6369a8193e5a/javaparser-core-3.15.9.jar:$TARDIS_HOME_PATH/jbse/libs/javassist.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.jacoco/org.jacoco.core/0.7.5.201505241946/1ea906dc5201d2a1bc0604f8650534d4bcaf4c95/org.jacoco.core-0.7.5.201505241946.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.ow2.asm/asm-debug-all/5.0.1/f69b5f7d96cec0d448acf1c1a266584170c9643b/asm-debug-all-5.0.1.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/junit/junit/4.12/2973d150c0dc1fefe998f834810d68f278ea58ec/junit-4.12.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.hamcrest/hamcrest-core/1.3/42a25dc3219429f0e5d060061f71acb49bf010a0/hamcrest-core-1.3.jar:$REPO_HOME_PATH/commons-imaging/dependencies/* settings.RunImage |& tee $LOG_PATH/$dt/IMAGE/tardisLog$BENCHMARK.txt
		echo "[TARDIS LAUNCHER] Tardis execution finished. Calculate results"
		java CalculateResults $LOG_PATH/$dt/IMAGE/tardisLog$BENCHMARK.txt $LOG_PATH/$dt/Results.csv Image$BENCHMARK
	done
fi

#Jsoup
if [ $input == "10" ] || [ $input == "1" ]; then
	mkdir $LOG_PATH/$dt/JSOUP
	sed -i "14s/\(Paths.get(\"\).*\(\");\)/\1$TARDIS_HOME_PATH_ESC\2/
			15s/\(Paths.get(\"\).*\(\");\)/\1$Z3_PATH_ESC\2/
			16s/\(Paths.get(\"\).*\(\");\)/\1$REPO_HOME_PATH_ESC\/jsoup\2/
			s/\(setNumOfThreads(\).*\();\)/\1$thread\2/g
			s/\(setNumMOSATargets(\).*\();\)/\1$mosa\2/g
			s/\(setEvosuiteTimeBudgetDuration(\).*\();\)/\1$evosuiteTime\2/g
			s/\(setGlobalTimeBudgetDuration(\).*\();\)/\1$globalTime\2/g" RunFiles/RunJsoup.java
	for BENCHMARK in TARGET_CLASS_1 TARGET_CLASS_2 TARGET_CLASS_3 TARGET_CLASS_4 TARGET_CLASS_5
	do
		echo "[TARDIS LAUNCHER] Run benchmark JSOUP -- Target class: $BENCHMARK"
		sed -i "s/\(setTargetClass(\).*\();\)/\1$BENCHMARK\2/g" RunFiles/RunJsoup.java
		bash CompileAndMove.sh
		timeout -s 9 21m java -Xms16G -Xmx16G -cp $REPO_HOME_PATH/jsoup/target/classes:$TARDIS_HOME_PATH/master/build/libs/tardis-master-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/runtime/build/libs/sushi-lib-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/jbse/build/libs/jbse-0.10.0-SNAPSHOT-shaded.jar:$TARDIS_HOME_PATH/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/args4j/args4j/2.32/1ccacebdf8f2db750eb09a402969050f27695fb7/args4j-2.32.jar:$TOOLSJAR_PATH/tools.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/com.opencsv/opencsv/5.0/6aa7ff327f0ad7e3e9dabd6fe29ee19122b382c3/opencsv-5.0.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/com.github.javaparser/javaparser-core/3.15.9/998ab964f295e6cecd4467a76d4a6369a8193e5a/javaparser-core-3.15.9.jar:$TARDIS_HOME_PATH/jbse/libs/javassist.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.jacoco/org.jacoco.core/0.7.5.201505241946/1ea906dc5201d2a1bc0604f8650534d4bcaf4c95/org.jacoco.core-0.7.5.201505241946.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.ow2.asm/asm-debug-all/5.0.1/f69b5f7d96cec0d448acf1c1a266584170c9643b/asm-debug-all-5.0.1.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/junit/junit/4.12/2973d150c0dc1fefe998f834810d68f278ea58ec/junit-4.12.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.hamcrest/hamcrest-core/1.3/42a25dc3219429f0e5d060061f71acb49bf010a0/hamcrest-core-1.3.jar:$REPO_HOME_PATH/jsoup/dependencies/* settings.RunJsoup |& tee $LOG_PATH/$dt/JSOUP/tardisLog$BENCHMARK.txt
		echo "[TARDIS LAUNCHER] Tardis execution finished. Calculate results"
		java CalculateResults $LOG_PATH/$dt/JSOUP/tardisLog$BENCHMARK.txt $LOG_PATH/$dt/Results.csv Jsoup$BENCHMARK
	done
fi

#Jxpath
if [ $input == "11" ] || [ $input == "1" ]; then
	mkdir $LOG_PATH/$dt/JXPATH
	sed -i "14s/\(Paths.get(\"\).*\(\");\)/\1$TARDIS_HOME_PATH_ESC\2/
			15s/\(Paths.get(\"\).*\(\");\)/\1$Z3_PATH_ESC\2/
			16s/\(Paths.get(\"\).*\(\");\)/\1$REPO_HOME_PATH_ESC\/commons-jxpath-1.3-src\2/
			s/\(setNumOfThreads(\).*\();\)/\1$thread\2/g
			s/\(setNumMOSATargets(\).*\();\)/\1$mosa\2/g
			s/\(setEvosuiteTimeBudgetDuration(\).*\();\)/\1$evosuiteTime\2/g
			s/\(setGlobalTimeBudgetDuration(\).*\();\)/\1$globalTime\2/g" RunFiles/RunJxpath.java
	for BENCHMARK in TARGET_CLASS_1 TARGET_CLASS_2 TARGET_CLASS_3 TARGET_CLASS_4 TARGET_CLASS_5 TARGET_CLASS_6 TARGET_CLASS_7 TARGET_CLASS_8 TARGET_CLASS_9 TARGET_CLASS_10
	do
		echo "[TARDIS LAUNCHER] Run benchmark JXPATH -- Target class: $BENCHMARK"
		sed -i "s/\(setTargetClass(\).*\();\)/\1$BENCHMARK\2/g" RunFiles/RunJxpath.java
		bash CompileAndMove.sh
		timeout -s 9 21m java -Xms16G -Xmx16G -cp $REPO_HOME_PATH/commons-jxpath-1.3-src/target/classes:$TARDIS_HOME_PATH/master/build/libs/tardis-master-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/runtime/build/libs/sushi-lib-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/jbse/build/libs/jbse-0.10.0-SNAPSHOT-shaded.jar:$TARDIS_HOME_PATH/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/args4j/args4j/2.32/1ccacebdf8f2db750eb09a402969050f27695fb7/args4j-2.32.jar:$TOOLSJAR_PATH/tools.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/com.opencsv/opencsv/5.0/6aa7ff327f0ad7e3e9dabd6fe29ee19122b382c3/opencsv-5.0.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/com.github.javaparser/javaparser-core/3.15.9/998ab964f295e6cecd4467a76d4a6369a8193e5a/javaparser-core-3.15.9.jar:$TARDIS_HOME_PATH/jbse/libs/javassist.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.jacoco/org.jacoco.core/0.7.5.201505241946/1ea906dc5201d2a1bc0604f8650534d4bcaf4c95/org.jacoco.core-0.7.5.201505241946.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.ow2.asm/asm-debug-all/5.0.1/f69b5f7d96cec0d448acf1c1a266584170c9643b/asm-debug-all-5.0.1.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/junit/junit/4.12/2973d150c0dc1fefe998f834810d68f278ea58ec/junit-4.12.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.hamcrest/hamcrest-core/1.3/42a25dc3219429f0e5d060061f71acb49bf010a0/hamcrest-core-1.3.jar:$REPO_HOME_PATH/commons-jxpath-1.3-src/dependencies/* settings.RunJxpath |& tee $LOG_PATH/$dt/JXPATH/tardisLog$BENCHMARK.txt
		echo "[TARDIS LAUNCHER] Tardis execution finished. Calculate results"
		java CalculateResults $LOG_PATH/$dt/JXPATH/tardisLog$BENCHMARK.txt $LOG_PATH/$dt/Results.csv Jxpath$BENCHMARK
	done
fi

#La4j
if [ $input == "12" ] || [ $input == "1" ]; then
	mkdir $LOG_PATH/$dt/LA4J
	sed -i "14s/\(Paths.get(\"\).*\(\");\)/\1$TARDIS_HOME_PATH_ESC\2/
			15s/\(Paths.get(\"\).*\(\");\)/\1$Z3_PATH_ESC\2/
			16s/\(Paths.get(\"\).*\(\");\)/\1$REPO_HOME_PATH_ESC\/la4j-0.6.0\2/
			s/\(setNumOfThreads(\).*\();\)/\1$thread\2/g
			s/\(setNumMOSATargets(\).*\();\)/\1$mosa\2/g
			s/\(setEvosuiteTimeBudgetDuration(\).*\();\)/\1$evosuiteTime\2/g
			s/\(setGlobalTimeBudgetDuration(\).*\();\)/\1$globalTime\2/g" RunFiles/RunLa4j.java
	for BENCHMARK in TARGET_CLASS_1 TARGET_CLASS_2 TARGET_CLASS_3 TARGET_CLASS_4 TARGET_CLASS_5 TARGET_CLASS_6 TARGET_CLASS_7 TARGET_CLASS_8 TARGET_CLASS_9 TARGET_CLASS_10
	do
		echo "[TARDIS LAUNCHER] Run benchmark LA4J -- Target class: $BENCHMARK"
		sed -i "s/\(setTargetClass(\).*\();\)/\1$BENCHMARK\2/g" RunFiles/RunLa4j.java
		bash CompileAndMove.sh
		timeout -s 9 21m java -Xms16G -Xmx16G -cp $REPO_HOME_PATH/la4j-0.6.0/target/classes:$TARDIS_HOME_PATH/master/build/libs/tardis-master-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/runtime/build/libs/sushi-lib-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/jbse/build/libs/jbse-0.10.0-SNAPSHOT-shaded.jar:$TARDIS_HOME_PATH/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/args4j/args4j/2.32/1ccacebdf8f2db750eb09a402969050f27695fb7/args4j-2.32.jar:$TOOLSJAR_PATH/tools.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/com.opencsv/opencsv/5.0/6aa7ff327f0ad7e3e9dabd6fe29ee19122b382c3/opencsv-5.0.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/com.github.javaparser/javaparser-core/3.15.9/998ab964f295e6cecd4467a76d4a6369a8193e5a/javaparser-core-3.15.9.jar:$TARDIS_HOME_PATH/jbse/libs/javassist.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.jacoco/org.jacoco.core/0.7.5.201505241946/1ea906dc5201d2a1bc0604f8650534d4bcaf4c95/org.jacoco.core-0.7.5.201505241946.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.ow2.asm/asm-debug-all/5.0.1/f69b5f7d96cec0d448acf1c1a266584170c9643b/asm-debug-all-5.0.1.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/junit/junit/4.12/2973d150c0dc1fefe998f834810d68f278ea58ec/junit-4.12.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.hamcrest/hamcrest-core/1.3/42a25dc3219429f0e5d060061f71acb49bf010a0/hamcrest-core-1.3.jar:$REPO_HOME_PATH/la4j-0.6.0/dependencies/* settings.RunLa4j |& tee $LOG_PATH/$dt/LA4J/tardisLog$BENCHMARK.txt
		echo "[TARDIS LAUNCHER] Tardis execution finished. Calculate results"
		java CalculateResults $LOG_PATH/$dt/LA4J/tardisLog$BENCHMARK.txt $LOG_PATH/$dt/Results.csv La4j$BENCHMARK
	done
fi

#Okhttp
if [ $input == "13" ] || [ $input == "1" ]; then
	mkdir $LOG_PATH/$dt/OKHTTP
	sed -i "14s/\(Paths.get(\"\).*\(\");\)/\1$TARDIS_HOME_PATH_ESC\2/
			15s/\(Paths.get(\"\).*\(\");\)/\1$Z3_PATH_ESC\2/
			16s/\(Paths.get(\"\).*\(\");\)/\1$REPO_HOME_PATH_ESC\/okhttp\2/
			s/\(setNumOfThreads(\).*\();\)/\1$thread\2/g
			s/\(setNumMOSATargets(\).*\();\)/\1$mosa\2/g
			s/\(setEvosuiteTimeBudgetDuration(\).*\();\)/\1$evosuiteTime\2/g
			s/\(setGlobalTimeBudgetDuration(\).*\();\)/\1$globalTime\2/g" RunFiles/RunOkhttp.java
	for BENCHMARK in TARGET_CLASS_1 TARGET_CLASS_2 TARGET_CLASS_3 TARGET_CLASS_4 TARGET_CLASS_5 TARGET_CLASS_6 TARGET_CLASS_7 TARGET_CLASS_8
	do
		echo "[TARDIS LAUNCHER] Run benchmark OKHTTP -- Target class: $BENCHMARK"
		sed -i "s/\(setTargetClass(\).*\();\)/\1$BENCHMARK\2/g" RunFiles/RunOkhttp.java
		bash CompileAndMove.sh
		timeout -s 9 21m java -Xms16G -Xmx16G -cp $REPO_HOME_PATH/okhttp/okhttp/target/classes:$TARDIS_HOME_PATH/master/build/libs/tardis-master-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/runtime/build/libs/sushi-lib-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/jbse/build/libs/jbse-0.10.0-SNAPSHOT-shaded.jar:$TARDIS_HOME_PATH/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/args4j/args4j/2.32/1ccacebdf8f2db750eb09a402969050f27695fb7/args4j-2.32.jar:$TOOLSJAR_PATH/tools.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/com.opencsv/opencsv/5.0/6aa7ff327f0ad7e3e9dabd6fe29ee19122b382c3/opencsv-5.0.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/com.github.javaparser/javaparser-core/3.15.9/998ab964f295e6cecd4467a76d4a6369a8193e5a/javaparser-core-3.15.9.jar:$TARDIS_HOME_PATH/jbse/libs/javassist.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.jacoco/org.jacoco.core/0.7.5.201505241946/1ea906dc5201d2a1bc0604f8650534d4bcaf4c95/org.jacoco.core-0.7.5.201505241946.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.ow2.asm/asm-debug-all/5.0.1/f69b5f7d96cec0d448acf1c1a266584170c9643b/asm-debug-all-5.0.1.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/junit/junit/4.12/2973d150c0dc1fefe998f834810d68f278ea58ec/junit-4.12.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.hamcrest/hamcrest-core/1.3/42a25dc3219429f0e5d060061f71acb49bf010a0/hamcrest-core-1.3.jar:$REPO_HOME_PATH/okhttp/dependencies/* settings.RunOkhttp |& tee $LOG_PATH/$dt/OKHTTP/tardisLog$BENCHMARK.txt
		echo "[TARDIS LAUNCHER] Tardis execution finished. Calculate results"
		java CalculateResults $LOG_PATH/$dt/OKHTTP/tardisLog$BENCHMARK.txt $LOG_PATH/$dt/Results.csv Okhttp$BENCHMARK
	done
fi

#Okio
if [ $input == "14" ] || [ $input == "1" ]; then
	mkdir $LOG_PATH/$dt/OKIO
	sed -i "14s/\(Paths.get(\"\).*\(\");\)/\1$TARDIS_HOME_PATH_ESC\2/
			15s/\(Paths.get(\"\).*\(\");\)/\1$Z3_PATH_ESC\2/
			16s/\(Paths.get(\"\).*\(\");\)/\1$REPO_HOME_PATH_ESC\/okio\2/
			s/\(setNumOfThreads(\).*\();\)/\1$thread\2/g
			s/\(setNumMOSATargets(\).*\();\)/\1$mosa\2/g
			s/\(setEvosuiteTimeBudgetDuration(\).*\();\)/\1$evosuiteTime\2/g
			s/\(setGlobalTimeBudgetDuration(\).*\();\)/\1$globalTime\2/g" RunFiles/RunOkio.java
	for BENCHMARK in TARGET_CLASS_1 TARGET_CLASS_2 TARGET_CLASS_3 TARGET_CLASS_4 TARGET_CLASS_5 TARGET_CLASS_6 TARGET_CLASS_7 TARGET_CLASS_8 TARGET_CLASS_9 TARGET_CLASS_10
	do
		echo "[TARDIS LAUNCHER] Run benchmark OKIO -- Target class: $BENCHMARK"
		sed -i "s/\(setTargetClass(\).*\();\)/\1$BENCHMARK\2/g" RunFiles/RunOkio.java
		bash CompileAndMove.sh
		timeout -s 9 21m java -Xms16G -Xmx16G -cp $REPO_HOME_PATH/okio/okio/target/classes:$TARDIS_HOME_PATH/master/build/libs/tardis-master-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/runtime/build/libs/sushi-lib-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/jbse/build/libs/jbse-0.10.0-SNAPSHOT-shaded.jar:$TARDIS_HOME_PATH/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/args4j/args4j/2.32/1ccacebdf8f2db750eb09a402969050f27695fb7/args4j-2.32.jar:$TOOLSJAR_PATH/tools.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/com.opencsv/opencsv/5.0/6aa7ff327f0ad7e3e9dabd6fe29ee19122b382c3/opencsv-5.0.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/com.github.javaparser/javaparser-core/3.15.9/998ab964f295e6cecd4467a76d4a6369a8193e5a/javaparser-core-3.15.9.jar:$TARDIS_HOME_PATH/jbse/libs/javassist.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.jacoco/org.jacoco.core/0.7.5.201505241946/1ea906dc5201d2a1bc0604f8650534d4bcaf4c95/org.jacoco.core-0.7.5.201505241946.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.ow2.asm/asm-debug-all/5.0.1/f69b5f7d96cec0d448acf1c1a266584170c9643b/asm-debug-all-5.0.1.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/junit/junit/4.12/2973d150c0dc1fefe998f834810d68f278ea58ec/junit-4.12.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.hamcrest/hamcrest-core/1.3/42a25dc3219429f0e5d060061f71acb49bf010a0/hamcrest-core-1.3.jar:$REPO_HOME_PATH/okio/dependencies/* settings.RunOkio |& tee $LOG_PATH/$dt/OKIO/tardisLog$BENCHMARK.txt
		echo "[TARDIS LAUNCHER] Tardis execution finished. Calculate results"
		java CalculateResults $LOG_PATH/$dt/OKIO/tardisLog$BENCHMARK.txt $LOG_PATH/$dt/Results.csv Okio$BENCHMARK
	done
fi

#Pdfbox
if [ $input == "15" ] || [ $input == "1" ]; then
	mkdir $LOG_PATH/$dt/PDFBOX
	sed -i "14s/\(Paths.get(\"\).*\(\");\)/\1$TARDIS_HOME_PATH_ESC\2/
			15s/\(Paths.get(\"\).*\(\");\)/\1$Z3_PATH_ESC\2/
			16s/\(Paths.get(\"\).*\(\");\)/\1$REPO_HOME_PATH_ESC\/pdfbox\2/
			s/\(setNumOfThreads(\).*\();\)/\1$thread\2/g
			s/\(setNumMOSATargets(\).*\();\)/\1$mosa\2/g
			s/\(setEvosuiteTimeBudgetDuration(\).*\();\)/\1$evosuiteTime\2/g
			s/\(setGlobalTimeBudgetDuration(\).*\();\)/\1$globalTime\2/g" RunFiles/RunPdfbox.java
	for BENCHMARK in TARGET_CLASS_8 TARGET_CLASS_22 TARGET_CLASS_26 TARGET_CLASS_40 TARGET_CLASS_62 TARGET_CLASS_83 TARGET_CLASS_91 TARGET_CLASS_117 TARGET_CLASS_127 TARGET_CLASS_130 TARGET_CLASS_157 TARGET_CLASS_198 TARGET_CLASS_214 TARGET_CLASS_220 TARGET_CLASS_229 TARGET_CLASS_234 TARGET_CLASS_235 TARGET_CLASS_265 TARGET_CLASS_278 TARGET_CLASS_285
	do
		echo "[TARDIS LAUNCHER] Run benchmark PDFBOX -- Target class: $BENCHMARK"
		sed -i "s/\(setTargetClass(\).*\();\)/\1$BENCHMARK\2/g" RunFiles/RunPdfbox.java
		bash CompileAndMove.sh
		timeout -s 9 21m java -Xms16G -Xmx16G -cp $REPO_HOME_PATH/pdfbox/pdfbox/target/classes:$TARDIS_HOME_PATH/master/build/libs/tardis-master-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/runtime/build/libs/sushi-lib-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/jbse/build/libs/jbse-0.10.0-SNAPSHOT-shaded.jar:$TARDIS_HOME_PATH/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/args4j/args4j/2.32/1ccacebdf8f2db750eb09a402969050f27695fb7/args4j-2.32.jar:$TOOLSJAR_PATH/tools.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/com.opencsv/opencsv/5.0/6aa7ff327f0ad7e3e9dabd6fe29ee19122b382c3/opencsv-5.0.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/com.github.javaparser/javaparser-core/3.15.9/998ab964f295e6cecd4467a76d4a6369a8193e5a/javaparser-core-3.15.9.jar:$TARDIS_HOME_PATH/jbse/libs/javassist.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.jacoco/org.jacoco.core/0.7.5.201505241946/1ea906dc5201d2a1bc0604f8650534d4bcaf4c95/org.jacoco.core-0.7.5.201505241946.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.ow2.asm/asm-debug-all/5.0.1/f69b5f7d96cec0d448acf1c1a266584170c9643b/asm-debug-all-5.0.1.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/junit/junit/4.12/2973d150c0dc1fefe998f834810d68f278ea58ec/junit-4.12.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.hamcrest/hamcrest-core/1.3/42a25dc3219429f0e5d060061f71acb49bf010a0/hamcrest-core-1.3.jar:$REPO_HOME_PATH/pdfbox/dependencies/* settings.RunPdfbox |& tee $LOG_PATH/$dt/PDFBOX/tardisLog$BENCHMARK.txt
		echo "[TARDIS LAUNCHER] Tardis execution finished. Calculate results"
		java CalculateResults $LOG_PATH/$dt/PDFBOX/tardisLog$BENCHMARK.txt $LOG_PATH/$dt/Results.csv Pdfbox$BENCHMARK
	done
fi

#Re2j
if [ $input == "16" ] || [ $input == "1" ]; then
	mkdir $LOG_PATH/$dt/RE2J
	sed -i "14s/\(Paths.get(\"\).*\(\");\)/\1$TARDIS_HOME_PATH_ESC\2/
			15s/\(Paths.get(\"\).*\(\");\)/\1$Z3_PATH_ESC\2/
			16s/\(Paths.get(\"\).*\(\");\)/\1$REPO_HOME_PATH_ESC\/re2j\2/
			s/\(setNumOfThreads(\).*\();\)/\1$thread\2/g
			s/\(setNumMOSATargets(\).*\();\)/\1$mosa\2/g
			s/\(setEvosuiteTimeBudgetDuration(\).*\();\)/\1$evosuiteTime\2/g
			s/\(setGlobalTimeBudgetDuration(\).*\();\)/\1$globalTime\2/g" RunFiles/RunRe2j.java
	for BENCHMARK in TARGET_CLASS_1 TARGET_CLASS_2 TARGET_CLASS_3 TARGET_CLASS_4 TARGET_CLASS_5 TARGET_CLASS_6 TARGET_CLASS_7 TARGET_CLASS_8
	do
		echo "[TARDIS LAUNCHER] Run benchmark RE2J -- Target class: $BENCHMARK"
		sed -i "s/\(setTargetClass(\).*\();\)/\1$BENCHMARK\2/g" RunFiles/RunRe2j.java
		bash CompileAndMove.sh
		timeout -s 9 21m java -Xms16G -Xmx16G -cp $REPO_HOME_PATH/re2j/target/classes:$TARDIS_HOME_PATH/master/build/libs/tardis-master-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/runtime/build/libs/sushi-lib-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/jbse/build/libs/jbse-0.10.0-SNAPSHOT-shaded.jar:$TARDIS_HOME_PATH/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/args4j/args4j/2.32/1ccacebdf8f2db750eb09a402969050f27695fb7/args4j-2.32.jar:$TOOLSJAR_PATH/tools.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/com.opencsv/opencsv/5.0/6aa7ff327f0ad7e3e9dabd6fe29ee19122b382c3/opencsv-5.0.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/com.github.javaparser/javaparser-core/3.15.9/998ab964f295e6cecd4467a76d4a6369a8193e5a/javaparser-core-3.15.9.jar:$TARDIS_HOME_PATH/jbse/libs/javassist.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.jacoco/org.jacoco.core/0.7.5.201505241946/1ea906dc5201d2a1bc0604f8650534d4bcaf4c95/org.jacoco.core-0.7.5.201505241946.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.ow2.asm/asm-debug-all/5.0.1/f69b5f7d96cec0d448acf1c1a266584170c9643b/asm-debug-all-5.0.1.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/junit/junit/4.12/2973d150c0dc1fefe998f834810d68f278ea58ec/junit-4.12.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.hamcrest/hamcrest-core/1.3/42a25dc3219429f0e5d060061f71acb49bf010a0/hamcrest-core-1.3.jar:$REPO_HOME_PATH/re2j/dependencies/* settings.RunRe2j |& tee $LOG_PATH/$dt/RE2J/tardisLog$BENCHMARK.txt
		echo "[TARDIS LAUNCHER] Tardis execution finished. Calculate results"
		java CalculateResults $LOG_PATH/$dt/RE2J/tardisLog$BENCHMARK.txt $LOG_PATH/$dt/Results.csv Re2j$BENCHMARK
	done
fi

#Spoon
if [ $input == "17" ] || [ $input == "1" ]; then
	mkdir $LOG_PATH/$dt/SPOON
	sed -i "14s/\(Paths.get(\"\).*\(\");\)/\1$TARDIS_HOME_PATH_ESC\2/
			15s/\(Paths.get(\"\).*\(\");\)/\1$Z3_PATH_ESC\2/
			16s/\(Paths.get(\"\).*\(\");\)/\1$REPO_HOME_PATH_ESC\/spoon\2/
			s/\(setNumOfThreads(\).*\();\)/\1$thread\2/g
			s/\(setNumMOSATargets(\).*\();\)/\1$mosa\2/g
			s/\(setEvosuiteTimeBudgetDuration(\).*\();\)/\1$evosuiteTime\2/g
			s/\(setGlobalTimeBudgetDuration(\).*\();\)/\1$globalTime\2/g" RunFiles/RunSpoon.java
	for BENCHMARK in TARGET_CLASS_105 TARGET_CLASS_155 TARGET_CLASS_16 TARGET_CLASS_169 TARGET_CLASS_20 TARGET_CLASS_211 TARGET_CLASS_25 TARGET_CLASS_253 TARGET_CLASS_32 TARGET_CLASS_65
	do
		echo "[TARDIS LAUNCHER] Run benchmark SPOON -- Target class: $BENCHMARK"
		sed -i "s/\(setTargetClass(\).*\();\)/\1$BENCHMARK\2/g" RunFiles/RunSpoon.java
		bash CompileAndMove.sh
		timeout -s 9 21m java -Xms16G -Xmx16G -cp $REPO_HOME_PATH/spoon/target/classes:$TARDIS_HOME_PATH/master/build/libs/tardis-master-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/runtime/build/libs/sushi-lib-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/jbse/build/libs/jbse-0.10.0-SNAPSHOT-shaded.jar:$TARDIS_HOME_PATH/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/args4j/args4j/2.32/1ccacebdf8f2db750eb09a402969050f27695fb7/args4j-2.32.jar:$TOOLSJAR_PATH/tools.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/com.opencsv/opencsv/5.0/6aa7ff327f0ad7e3e9dabd6fe29ee19122b382c3/opencsv-5.0.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/com.github.javaparser/javaparser-core/3.15.9/998ab964f295e6cecd4467a76d4a6369a8193e5a/javaparser-core-3.15.9.jar:$TARDIS_HOME_PATH/jbse/libs/javassist.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.jacoco/org.jacoco.core/0.7.5.201505241946/1ea906dc5201d2a1bc0604f8650534d4bcaf4c95/org.jacoco.core-0.7.5.201505241946.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.ow2.asm/asm-debug-all/5.0.1/f69b5f7d96cec0d448acf1c1a266584170c9643b/asm-debug-all-5.0.1.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/junit/junit/4.12/2973d150c0dc1fefe998f834810d68f278ea58ec/junit-4.12.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.hamcrest/hamcrest-core/1.3/42a25dc3219429f0e5d060061f71acb49bf010a0/hamcrest-core-1.3.jar:$REPO_HOME_PATH/spoon/dependencies/* settings.RunSpoon |& tee $LOG_PATH/$dt/SPOON/tardisLog$BENCHMARK.txt
		echo "[TARDIS LAUNCHER] Tardis execution finished. Calculate results"
		java CalculateResults $LOG_PATH/$dt/SPOON/tardisLog$BENCHMARK.txt $LOG_PATH/$dt/Results.csv Spoon$BENCHMARK
	done
fi

#Webmagic
if [ $input == "18" ] || [ $input == "1" ]; then
	mkdir $LOG_PATH/$dt/WEBMAGIC
	sed -i "14s/\(Paths.get(\"\).*\(\");\)/\1$TARDIS_HOME_PATH_ESC\2/
			15s/\(Paths.get(\"\).*\(\");\)/\1$Z3_PATH_ESC\2/
			16s/\(Paths.get(\"\).*\(\");\)/\1$REPO_HOME_PATH_ESC\/webmagic\2/
			s/\(setNumOfThreads(\).*\();\)/\1$thread\2/g
			s/\(setNumMOSATargets(\).*\();\)/\1$mosa\2/g
			s/\(setEvosuiteTimeBudgetDuration(\).*\();\)/\1$evosuiteTime\2/g
			s/\(setGlobalTimeBudgetDuration(\).*\();\)/\1$globalTime\2/g" RunFiles/RunWebmagic1_5.java
	sed -i "14s/\(Paths.get(\"\).*\(\");\)/\1$TARDIS_HOME_PATH_ESC\2/
			15s/\(Paths.get(\"\).*\(\");\)/\1$Z3_PATH_ESC\2/
			16s/\(Paths.get(\"\).*\(\");\)/\1$REPO_HOME_PATH_ESC\/webmagic\2/
			s/\(setNumOfThreads(\).*\();\)/\1$thread\2/g
			s/\(setNumMOSATargets(\).*\();\)/\1$mosa\2/g
			s/\(setEvosuiteTimeBudgetDuration(\).*\();\)/\1$evosuiteTime\2/g
			s/\(setGlobalTimeBudgetDuration(\).*\();\)/\1$globalTime\2/g" RunFiles/RunWebmagic2_3_4.java
	for BENCHMARK in TARGET_CLASS_1 TARGET_CLASS_5
	do
		echo "[TARDIS LAUNCHER] Run benchmark WEBMAGIC -- Target class: $BENCHMARK"
		sed -i "s/\(setTargetClass(\).*\();\)/\1$BENCHMARK\2/g" RunFiles/RunWebmagic1_5.java
		bash CompileAndMove.sh
		timeout -s 9 21m java -Xms16G -Xmx16G -cp $REPO_HOME_PATH/webmagic/webmagic-extension/target/classes:$REPO_HOME_PATH/webmagic/webmagic-core/target/classes:$TARDIS_HOME_PATH/master/build/libs/tardis-master-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/runtime/build/libs/sushi-lib-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/jbse/build/libs/jbse-0.10.0-SNAPSHOT-shaded.jar:$TARDIS_HOME_PATH/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/args4j/args4j/2.32/1ccacebdf8f2db750eb09a402969050f27695fb7/args4j-2.32.jar:$TOOLSJAR_PATH/tools.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/com.opencsv/opencsv/5.0/6aa7ff327f0ad7e3e9dabd6fe29ee19122b382c3/opencsv-5.0.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/com.github.javaparser/javaparser-core/3.15.9/998ab964f295e6cecd4467a76d4a6369a8193e5a/javaparser-core-3.15.9.jar:$TARDIS_HOME_PATH/jbse/libs/javassist.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.jacoco/org.jacoco.core/0.7.5.201505241946/1ea906dc5201d2a1bc0604f8650534d4bcaf4c95/org.jacoco.core-0.7.5.201505241946.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.ow2.asm/asm-debug-all/5.0.1/f69b5f7d96cec0d448acf1c1a266584170c9643b/asm-debug-all-5.0.1.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/junit/junit/4.12/2973d150c0dc1fefe998f834810d68f278ea58ec/junit-4.12.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.hamcrest/hamcrest-core/1.3/42a25dc3219429f0e5d060061f71acb49bf010a0/hamcrest-core-1.3.jar:$REPO_HOME_PATH/webmagic/dependencies/* settings.RunWebmagic1_5 |& tee $LOG_PATH/$dt/WEBMAGIC/tardisLog$BENCHMARK.txt
		echo "[TARDIS LAUNCHER] Tardis execution finished. Calculate results"
		java CalculateResults $LOG_PATH/$dt/WEBMAGIC/tardisLog$BENCHMARK.txt $LOG_PATH/$dt/Results.csv Webmagic$BENCHMARK
	done
	for BENCHMARK in TARGET_CLASS_2 TARGET_CLASS_3 TARGET_CLASS_4
	do
		echo "[TARDIS LAUNCHER] Run benchmark WEBMAGIC -- Target class: $BENCHMARK"
		sed -i "s/\(setTargetClass(\).*\();\)/\1$BENCHMARK\2/g" RunFiles/RunWebmagic2_3_4.java
		bash CompileAndMove.sh
		timeout -s 9 21m java -Xms16G -Xmx16G -cp $REPO_HOME_PATH/webmagic/webmagic-core/target/classes:$TARDIS_HOME_PATH/master/build/libs/tardis-master-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/runtime/build/libs/sushi-lib-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/jbse/build/libs/jbse-0.10.0-SNAPSHOT-shaded.jar:$TARDIS_HOME_PATH/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/args4j/args4j/2.32/1ccacebdf8f2db750eb09a402969050f27695fb7/args4j-2.32.jar:$TOOLSJAR_PATH/tools.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/com.opencsv/opencsv/5.0/6aa7ff327f0ad7e3e9dabd6fe29ee19122b382c3/opencsv-5.0.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/com.github.javaparser/javaparser-core/3.15.9/998ab964f295e6cecd4467a76d4a6369a8193e5a/javaparser-core-3.15.9.jar:$TARDIS_HOME_PATH/jbse/libs/javassist.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.jacoco/org.jacoco.core/0.7.5.201505241946/1ea906dc5201d2a1bc0604f8650534d4bcaf4c95/org.jacoco.core-0.7.5.201505241946.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.ow2.asm/asm-debug-all/5.0.1/f69b5f7d96cec0d448acf1c1a266584170c9643b/asm-debug-all-5.0.1.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/junit/junit/4.12/2973d150c0dc1fefe998f834810d68f278ea58ec/junit-4.12.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.hamcrest/hamcrest-core/1.3/42a25dc3219429f0e5d060061f71acb49bf010a0/hamcrest-core-1.3.jar:$REPO_HOME_PATH/webmagic/dependencies/* settings.RunWebmagic2_3_4 |& tee $LOG_PATH/$dt/WEBMAGIC/tardisLog$BENCHMARK.txt
		echo "[TARDIS LAUNCHER] Tardis execution finished. Calculate results"
		java CalculateResults $LOG_PATH/$dt/WEBMAGIC/tardisLog$BENCHMARK.txt $LOG_PATH/$dt/Results.csv Webmagic$BENCHMARK
	done
fi

#Zxing
if [ $input == "19" ] || [ $input == "1" ]; then
	mkdir $LOG_PATH/$dt/ZXING
	sed -i "14s/\(Paths.get(\"\).*\(\");\)/\1$TARDIS_HOME_PATH_ESC\2/
			15s/\(Paths.get(\"\).*\(\");\)/\1$Z3_PATH_ESC\2/
			16s/\(Paths.get(\"\).*\(\");\)/\1$REPO_HOME_PATH_ESC\/zxing\2/
			s/\(setNumOfThreads(\).*\();\)/\1$thread\2/g
			s/\(setNumMOSATargets(\).*\();\)/\1$mosa\2/g
			s/\(setEvosuiteTimeBudgetDuration(\).*\();\)/\1$evosuiteTime\2/g
			s/\(setGlobalTimeBudgetDuration(\).*\();\)/\1$globalTime\2/g" RunFiles/RunZxing.java
	for BENCHMARK in TARGET_CLASS_1 TARGET_CLASS_2 TARGET_CLASS_3 TARGET_CLASS_4 TARGET_CLASS_5 TARGET_CLASS_6 TARGET_CLASS_7 TARGET_CLASS_8 TARGET_CLASS_9 TARGET_CLASS_10
	do
		echo "[TARDIS LAUNCHER] Run benchmark ZXING -- Target class: $BENCHMARK"
		sed -i "s/\(setTargetClass(\).*\();\)/\1$BENCHMARK\2/g" RunFiles/RunZxing.java
		bash CompileAndMove.sh
		timeout -s 9 21m java -Xms16G -Xmx16G -cp $REPO_HOME_PATH/zxing/core/target/classes:$TARDIS_HOME_PATH/master/build/libs/tardis-master-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/runtime/build/libs/sushi-lib-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/jbse/build/libs/jbse-0.10.0-SNAPSHOT-shaded.jar:$TARDIS_HOME_PATH/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/args4j/args4j/2.32/1ccacebdf8f2db750eb09a402969050f27695fb7/args4j-2.32.jar:$TOOLSJAR_PATH/tools.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/com.opencsv/opencsv/5.0/6aa7ff327f0ad7e3e9dabd6fe29ee19122b382c3/opencsv-5.0.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/com.github.javaparser/javaparser-core/3.15.9/998ab964f295e6cecd4467a76d4a6369a8193e5a/javaparser-core-3.15.9.jar:$TARDIS_HOME_PATH/jbse/libs/javassist.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.jacoco/org.jacoco.core/0.7.5.201505241946/1ea906dc5201d2a1bc0604f8650534d4bcaf4c95/org.jacoco.core-0.7.5.201505241946.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.ow2.asm/asm-debug-all/5.0.1/f69b5f7d96cec0d448acf1c1a266584170c9643b/asm-debug-all-5.0.1.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/junit/junit/4.12/2973d150c0dc1fefe998f834810d68f278ea58ec/junit-4.12.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.hamcrest/hamcrest-core/1.3/42a25dc3219429f0e5d060061f71acb49bf010a0/hamcrest-core-1.3.jar:$REPO_HOME_PATH/zxing/dependencies/* settings.RunZxing |& tee $LOG_PATH/$dt/ZXING/tardisLog$BENCHMARK.txt
		echo "[TARDIS LAUNCHER] Tardis execution finished. Calculate results"
		java CalculateResults $LOG_PATH/$dt/ZXING/tardisLog$BENCHMARK.txt $LOG_PATH/$dt/Results.csv Zxing$BENCHMARK
	done
fi

echo "[TARDIS LAUNCHER] ENDING at $(date)"
