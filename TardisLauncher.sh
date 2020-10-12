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

# Set timeoutThreshold variable to decide after how many minutes kill the execution if still running after $globalTime minutes
timeoutThreshold=1
if [ $timeoutThreshold -lt 0 ]; then
	echo "[ERROR] timeoutThreshold variable must be greater than or equal to 0"
	echo "[TARDIS LAUNCHER] ENDING at $(date)"
	exit 1
fi
timeoutTime="$((timeoutThreshold+globalTime))m"
echo "timeoutTime: $timeoutTime"

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

cp -f CovarageTool/benchmarks.list CovarageTool/benchmarksRepoPath.list
sed -i "s/REPOSITORYHOMEPATH/$REPO_HOME_PATH_ESC/g" CovarageTool/benchmarksRepoPath.list

javac CalculateResults.java && echo "[TARDIS LAUNCHER] CalculateResults.java compiled" || echo "[TARDIS LAUNCHER] Failed"

#Authzforce
if [ $input == "2" ] || [ $input == "1" ]; then
	mkdir $LOG_PATH/$dt/AUTHZFORCE
	cp -f $REPO_HOME_PATH/CovarageTool/runtool $LOG_PATH/$dt/AUTHZFORCE
	sed -i "14s/\(Paths.get(\"\).*\(\");\)/\1$TARDIS_HOME_PATH_ESC\2/
			15s/\(Paths.get(\"\).*\(\");\)/\1$Z3_PATH_ESC\2/
			16s/\(Paths.get(\"\).*\(\");\)/\1$REPO_HOME_PATH_ESC\/core-release-13.3.0\2/
			s/\(setNumOfThreads(\).*\();\)/\1$thread\2/g
			s/\(setNumMOSATargets(\).*\();\)/\1$mosa\2/g
			s/\(setEvosuiteTimeBudgetDuration(\).*\();\)/\1$evosuiteTime\2/g
			s/\(setGlobalTimeBudgetDuration(\).*\();\)/\1$globalTime\2/g" RunFiles/RunAuthzforce1.java
	for BENCHMARK in AUTHZFORCE-1 AUTHZFORCE-11 AUTHZFORCE-27 AUTHZFORCE-32 AUTHZFORCE-33 AUTHZFORCE-48 AUTHZFORCE-5 AUTHZFORCE-52 AUTHZFORCE-63 AUTHZFORCE-65
	do
		echo "[TARDIS LAUNCHER] Run benchmark AUTHZFORCE -- Target class: $BENCHMARK"
		sed -i "s/\(setTargetClass(\).*\();\)/\1${BENCHMARK/-/_}\2/g" RunFiles/RunAuthzforce1.java
		bash CompileAndMove.sh
		timeout -s 9 $timeoutTime java -Xms16G -Xmx16G -cp $REPO_HOME_PATH/core-release-13.3.0/pdp-engine/target/classes:$TARDIS_HOME_PATH/master/build/libs/tardis-master-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/runtime/build/libs/sushi-lib-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/jbse/build/libs/jbse-0.10.0-SNAPSHOT-shaded.jar:$TARDIS_HOME_PATH/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/args4j/args4j/2.32/1ccacebdf8f2db750eb09a402969050f27695fb7/args4j-2.32.jar:$TOOLSJAR_PATH/tools.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/com.github.javaparser/javaparser-core/3.15.9/998ab964f295e6cecd4467a76d4a6369a8193e5a/javaparser-core-3.15.9.jar:$TARDIS_HOME_PATH/jbse/libs/javassist.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.jacoco/org.jacoco.core/0.7.5.201505241946/1ea906dc5201d2a1bc0604f8650534d4bcaf4c95/org.jacoco.core-0.7.5.201505241946.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.ow2.asm/asm-debug-all/5.0.1/f69b5f7d96cec0d448acf1c1a266584170c9643b/asm-debug-all-5.0.1.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/junit/junit/4.12/2973d150c0dc1fefe998f834810d68f278ea58ec/junit-4.12.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.hamcrest/hamcrest-core/1.3/42a25dc3219429f0e5d060061f71acb49bf010a0/hamcrest-core-1.3.jar:$REPO_HOME_PATH/core-release-13.3.0/dependencies/* settings.RunAuthzforce1 |& tee $LOG_PATH/$dt/AUTHZFORCE/tardisLog$BENCHMARK.txt
		echo "[TARDIS LAUNCHER] Tardis execution finished. Calculate results"
		java CalculateResults $LOG_PATH/$dt/AUTHZFORCE/tardisLog$BENCHMARK.txt $LOG_PATH/$dt/Results.csv Authzforce$BENCHMARK
		TMPDIR=$(ls -td $REPO_HOME_PATH/core-release-13.3.0/tardis-tmp/* | head -1)
		java -ea -Dsbst.benchmark.jacoco="$REPO_HOME_PATH/CovarageTool/jacocoagent.jar" -Dsbst.benchmark.java="java" -Dsbst.benchmark.javac="javac" -Dsbst.benchmark.config="$REPO_HOME_PATH/CovarageTool/benchmarksRepoPath.list" -Dsbst.benchmark.junit="$REPO_HOME_PATH/CovarageTool/junit-4.12.jar" -Dsbst.benchmark.junit.dependency="$REPO_HOME_PATH/CovarageTool/hamcrest-core-1.3.jar" -Dsbst.benchmark.pitest="$REPO_HOME_PATH/CovarageTool/pitest-1.1.11.jar:$REPO_HOME_PATH/CovarageTool/pitest-command-line-1.1.11.jar" -Dtardis.evosuite="$TARDIS_HOME_PATH/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar" -jar "$REPO_HOME_PATH/CovarageTool/benchmarktool-1.0.0-shaded.jar" TARDIS $BENCHMARK $LOG_PATH/$dt/AUTHZFORCE 1 $globalTime --only-compute-metrics $TMPDIR/test
	done
fi

#Bcel
if [ $input == "3" ] || [ $input == "1" ]; then
	mkdir $LOG_PATH/$dt/BCEL
	cp -f $REPO_HOME_PATH/CovarageTool/runtool $LOG_PATH/$dt/BCEL
	sed -i "14s/\(Paths.get(\"\).*\(\");\)/\1$TARDIS_HOME_PATH_ESC\2/
			15s/\(Paths.get(\"\).*\(\");\)/\1$Z3_PATH_ESC\2/
			16s/\(Paths.get(\"\).*\(\");\)/\1$REPO_HOME_PATH_ESC\/bcel-6.0-src\2/
			s/\(setNumOfThreads(\).*\();\)/\1$thread\2/g
			s/\(setNumMOSATargets(\).*\();\)/\1$mosa\2/g
			s/\(setEvosuiteTimeBudgetDuration(\).*\();\)/\1$evosuiteTime\2/g
			s/\(setGlobalTimeBudgetDuration(\).*\();\)/\1$globalTime\2/g" RunFiles/RunBcel.java
	for BENCHMARK in BCEL-1 BCEL-2 BCEL-3 BCEL-4 BCEL-5 BCEL-6 BCEL-7 BCEL-8 BCEL-9 BCEL-10
	do
		echo "[TARDIS LAUNCHER] Run benchmark BCEL -- Target class: $BENCHMARK"
		sed -i "s/\(setTargetClass(\).*\();\)/\1${BENCHMARK/-/_}\2/g" RunFiles/RunBcel.java
		bash CompileAndMove.sh
		timeout -s 9 $timeoutTime java -Xms16G -Xmx16G -cp $REPO_HOME_PATH/bcel-6.0-src/target/classes:$TARDIS_HOME_PATH/master/build/libs/tardis-master-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/runtime/build/libs/sushi-lib-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/jbse/build/libs/jbse-0.10.0-SNAPSHOT-shaded.jar:$TARDIS_HOME_PATH/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/args4j/args4j/2.32/1ccacebdf8f2db750eb09a402969050f27695fb7/args4j-2.32.jar:$TOOLSJAR_PATH/tools.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/com.github.javaparser/javaparser-core/3.15.9/998ab964f295e6cecd4467a76d4a6369a8193e5a/javaparser-core-3.15.9.jar:$TARDIS_HOME_PATH/jbse/libs/javassist.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.jacoco/org.jacoco.core/0.7.5.201505241946/1ea906dc5201d2a1bc0604f8650534d4bcaf4c95/org.jacoco.core-0.7.5.201505241946.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.ow2.asm/asm-debug-all/5.0.1/f69b5f7d96cec0d448acf1c1a266584170c9643b/asm-debug-all-5.0.1.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/junit/junit/4.12/2973d150c0dc1fefe998f834810d68f278ea58ec/junit-4.12.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.hamcrest/hamcrest-core/1.3/42a25dc3219429f0e5d060061f71acb49bf010a0/hamcrest-core-1.3.jar:$REPO_HOME_PATH/bcel-6.0-src/dependencies/* settings.RunBcel |& tee $LOG_PATH/$dt/BCEL/tardisLog$BENCHMARK.txt
		echo "[TARDIS LAUNCHER] Tardis execution finished. Calculate results"
		java CalculateResults $LOG_PATH/$dt/BCEL/tardisLog$BENCHMARK.txt $LOG_PATH/$dt/Results.csv Bcel$BENCHMARK
		TMPDIR=$(ls -td $REPO_HOME_PATH/bcel-6.0-src/tardis-tmp/* | head -1)
		java -ea -Dsbst.benchmark.jacoco="$REPO_HOME_PATH/CovarageTool/jacocoagent.jar" -Dsbst.benchmark.java="java" -Dsbst.benchmark.javac="javac" -Dsbst.benchmark.config="$REPO_HOME_PATH/CovarageTool/benchmarksRepoPath.list" -Dsbst.benchmark.junit="$REPO_HOME_PATH/CovarageTool/junit-4.12.jar" -Dsbst.benchmark.junit.dependency="$REPO_HOME_PATH/CovarageTool/hamcrest-core-1.3.jar" -Dsbst.benchmark.pitest="$REPO_HOME_PATH/CovarageTool/pitest-1.1.11.jar:$REPO_HOME_PATH/CovarageTool/pitest-command-line-1.1.11.jar" -Dtardis.evosuite="$TARDIS_HOME_PATH/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar" -jar "$REPO_HOME_PATH/CovarageTool/benchmarktool-1.0.0-shaded.jar" TARDIS $BENCHMARK $LOG_PATH/$dt/BCEL 1 $globalTime --only-compute-metrics $TMPDIR/test
	done
fi

#Dubbo
if [ $input == "4" ] || [ $input == "1" ]; then
	mkdir $LOG_PATH/$dt/DUBBO
	cp -f $REPO_HOME_PATH/CovarageTool/runtool $LOG_PATH/$dt/DUBBO
	sed -i "14s/\(Paths.get(\"\).*\(\");\)/\1$TARDIS_HOME_PATH_ESC\2/
			15s/\(Paths.get(\"\).*\(\");\)/\1$Z3_PATH_ESC\2/
			16s/\(Paths.get(\"\).*\(\");\)/\1$REPO_HOME_PATH_ESC\/dubbo\2/
			s/\(setNumOfThreads(\).*\();\)/\1$thread\2/g
			s/\(setNumMOSATargets(\).*\();\)/\1$mosa\2/g
			s/\(setEvosuiteTimeBudgetDuration(\).*\();\)/\1$evosuiteTime\2/g
			s/\(setGlobalTimeBudgetDuration(\).*\();\)/\1$globalTime\2/g" RunFiles/RunDubbo.java
	for BENCHMARK in DUBBO-2 DUBBO-3 DUBBO-4 DUBBO-5 DUBBO-6 DUBBO-7 DUBBO-8 DUBBO-9 DUBBO-10
	do
		echo "[TARDIS LAUNCHER] Run benchmark DUBBO -- Target class: $BENCHMARK"
		sed -i "s/\(setTargetClass(\).*\();\)/\1${BENCHMARK/-/_}\2/g" RunFiles/RunDubbo.java
		bash CompileAndMove.sh
		timeout -s 9 $timeoutTime java -Xms16G -Xmx16G -cp $REPO_HOME_PATH/dubbo/dubbo-common/target/classes:$TARDIS_HOME_PATH/master/build/libs/tardis-master-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/runtime/build/libs/sushi-lib-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/jbse/build/libs/jbse-0.10.0-SNAPSHOT-shaded.jar:$TARDIS_HOME_PATH/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/args4j/args4j/2.32/1ccacebdf8f2db750eb09a402969050f27695fb7/args4j-2.32.jar:$TOOLSJAR_PATH/tools.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/com.github.javaparser/javaparser-core/3.15.9/998ab964f295e6cecd4467a76d4a6369a8193e5a/javaparser-core-3.15.9.jar:$TARDIS_HOME_PATH/jbse/libs/javassist.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.jacoco/org.jacoco.core/0.7.5.201505241946/1ea906dc5201d2a1bc0604f8650534d4bcaf4c95/org.jacoco.core-0.7.5.201505241946.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.ow2.asm/asm-debug-all/5.0.1/f69b5f7d96cec0d448acf1c1a266584170c9643b/asm-debug-all-5.0.1.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/junit/junit/4.12/2973d150c0dc1fefe998f834810d68f278ea58ec/junit-4.12.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.hamcrest/hamcrest-core/1.3/42a25dc3219429f0e5d060061f71acb49bf010a0/hamcrest-core-1.3.jar:$REPO_HOME_PATH/dubbo/dependencies/* settings.RunDubbo |& tee $LOG_PATH/$dt/DUBBO/tardisLog$BENCHMARK.txt
		echo "[TARDIS LAUNCHER] Tardis execution finished. Calculate results"
		java CalculateResults $LOG_PATH/$dt/DUBBO/tardisLog$BENCHMARK.txt $LOG_PATH/$dt/Results.csv Dubbo$BENCHMARK
		TMPDIR=$(ls -td $REPO_HOME_PATH/dubbo/tardis-tmp/* | head -1)
		java -ea -Dsbst.benchmark.jacoco="$REPO_HOME_PATH/CovarageTool/jacocoagent.jar" -Dsbst.benchmark.java="java" -Dsbst.benchmark.javac="javac" -Dsbst.benchmark.config="$REPO_HOME_PATH/CovarageTool/benchmarksRepoPath.list" -Dsbst.benchmark.junit="$REPO_HOME_PATH/CovarageTool/junit-4.12.jar" -Dsbst.benchmark.junit.dependency="$REPO_HOME_PATH/CovarageTool/hamcrest-core-1.3.jar" -Dsbst.benchmark.pitest="$REPO_HOME_PATH/CovarageTool/pitest-1.1.11.jar:$REPO_HOME_PATH/CovarageTool/pitest-command-line-1.1.11.jar" -Dtardis.evosuite="$TARDIS_HOME_PATH/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar" -jar "$REPO_HOME_PATH/CovarageTool/benchmarktool-1.0.0-shaded.jar" TARDIS $BENCHMARK $LOG_PATH/$dt/DUBBO 1 $globalTime --only-compute-metrics $TMPDIR/test
	done
fi

#Fastjson
if [ $input == "5" ] || [ $input == "1" ]; then
	mkdir $LOG_PATH/$dt/FASTJSON
	cp -f $REPO_HOME_PATH/CovarageTool/runtool $LOG_PATH/$dt/FASTJSON
	sed -i "14s/\(Paths.get(\"\).*\(\");\)/\1$TARDIS_HOME_PATH_ESC\2/
			15s/\(Paths.get(\"\).*\(\");\)/\1$Z3_PATH_ESC\2/
			16s/\(Paths.get(\"\).*\(\");\)/\1$REPO_HOME_PATH_ESC\/fastjson\2/
			s/\(setNumOfThreads(\).*\();\)/\1$thread\2/g
			s/\(setNumMOSATargets(\).*\();\)/\1$mosa\2/g
			s/\(setEvosuiteTimeBudgetDuration(\).*\();\)/\1$evosuiteTime\2/g
			s/\(setGlobalTimeBudgetDuration(\).*\();\)/\1$globalTime\2/g" RunFiles/RunFastjson.java
	for BENCHMARK in FASTJSON-1 FASTJSON-2 FASTJSON-3 FASTJSON-4 FASTJSON-5 FASTJSON-6 FASTJSON-7 FASTJSON-8 FASTJSON-9 FASTJSON-10
	do
		echo "[TARDIS LAUNCHER] Run benchmark FASTJSON -- Target class: $BENCHMARK"
		sed -i "s/\(setTargetClass(\).*\();\)/\1${BENCHMARK/-/_}\2/g" RunFiles/RunFastjson.java
		bash CompileAndMove.sh
		timeout -s 9 $timeoutTime java -Xms16G -Xmx16G -cp $REPO_HOME_PATH/fastjson/target/classes:$TARDIS_HOME_PATH/master/build/libs/tardis-master-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/runtime/build/libs/sushi-lib-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/jbse/build/libs/jbse-0.10.0-SNAPSHOT-shaded.jar:$TARDIS_HOME_PATH/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/args4j/args4j/2.32/1ccacebdf8f2db750eb09a402969050f27695fb7/args4j-2.32.jar:$TOOLSJAR_PATH/tools.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/com.github.javaparser/javaparser-core/3.15.9/998ab964f295e6cecd4467a76d4a6369a8193e5a/javaparser-core-3.15.9.jar:$TARDIS_HOME_PATH/jbse/libs/javassist.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.jacoco/org.jacoco.core/0.7.5.201505241946/1ea906dc5201d2a1bc0604f8650534d4bcaf4c95/org.jacoco.core-0.7.5.201505241946.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.ow2.asm/asm-debug-all/5.0.1/f69b5f7d96cec0d448acf1c1a266584170c9643b/asm-debug-all-5.0.1.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/junit/junit/4.12/2973d150c0dc1fefe998f834810d68f278ea58ec/junit-4.12.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.hamcrest/hamcrest-core/1.3/42a25dc3219429f0e5d060061f71acb49bf010a0/hamcrest-core-1.3.jar:$REPO_HOME_PATH/fastjson/dependencies/* settings.RunFastjson |& tee $LOG_PATH/$dt/FASTJSON/tardisLog$BENCHMARK.txt
		echo "[TARDIS LAUNCHER] Tardis execution finished. Calculate results"
		java CalculateResults $LOG_PATH/$dt/FASTJSON/tardisLog$BENCHMARK.txt $LOG_PATH/$dt/Results.csv Fastjson$BENCHMARK
		TMPDIR=$(ls -td $REPO_HOME_PATH/fastjson/tardis-tmp/* | head -1)
		java -ea -Dsbst.benchmark.jacoco="$REPO_HOME_PATH/CovarageTool/jacocoagent.jar" -Dsbst.benchmark.java="java" -Dsbst.benchmark.javac="javac" -Dsbst.benchmark.config="$REPO_HOME_PATH/CovarageTool/benchmarksRepoPath.list" -Dsbst.benchmark.junit="$REPO_HOME_PATH/CovarageTool/junit-4.12.jar" -Dsbst.benchmark.junit.dependency="$REPO_HOME_PATH/CovarageTool/hamcrest-core-1.3.jar" -Dsbst.benchmark.pitest="$REPO_HOME_PATH/CovarageTool/pitest-1.1.11.jar:$REPO_HOME_PATH/CovarageTool/pitest-command-line-1.1.11.jar" -Dtardis.evosuite="$TARDIS_HOME_PATH/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar" -jar "$REPO_HOME_PATH/CovarageTool/benchmarktool-1.0.0-shaded.jar" TARDIS $BENCHMARK $LOG_PATH/$dt/FASTJSON 1 $globalTime --only-compute-metrics $TMPDIR/test
	done
fi

#Fescar
if [ $input == "6" ] || [ $input == "1" ]; then
	mkdir $LOG_PATH/$dt/FESCAR
	cp -f $REPO_HOME_PATH/CovarageTool/runtool $LOG_PATH/$dt/FESCAR
	sed -i "14s/\(Paths.get(\"\).*\(\");\)/\1$TARDIS_HOME_PATH_ESC\2/
			15s/\(Paths.get(\"\).*\(\");\)/\1$Z3_PATH_ESC\2/
			16s/\(Paths.get(\"\).*\(\");\)/\1$REPO_HOME_PATH_ESC\/fescar\2/
			s/\(setNumOfThreads(\).*\();\)/\1$thread\2/g
			s/\(setNumMOSATargets(\).*\();\)/\1$mosa\2/g
			s/\(setEvosuiteTimeBudgetDuration(\).*\();\)/\1$evosuiteTime\2/g
			s/\(setGlobalTimeBudgetDuration(\).*\();\)/\1$globalTime\2/g" RunFiles/RunFescar.java
	for BENCHMARK in FESCAR-1 FESCAR-12 FESCAR-18 FESCAR-23 FESCAR-25 FESCAR-36 FESCAR-37 FESCAR-41 FESCAR-42 FESCAR-7 FESCAR-2 FESCAR-5 FESCAR-6 FESCAR-8 FESCAR-9 FESCAR-10 FESCAR-13 FESCAR-15 FESCAR-17 FESCAR-28 FESCAR-32 FESCAR-33 FESCAR-34
	do
		echo "[TARDIS LAUNCHER] Run benchmark FESCAR -- Target class: $BENCHMARK"
		sed -i "s/\(setTargetClass(\).*\();\)/\1${BENCHMARK/-/_}\2/g" RunFiles/RunFescar.java
		bash CompileAndMove.sh
		timeout -s 9 $timeoutTime java -Xms16G -Xmx16G -cp $REPO_HOME_PATH/fescar/core/target/classes:$TARDIS_HOME_PATH/master/build/libs/tardis-master-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/runtime/build/libs/sushi-lib-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/jbse/build/libs/jbse-0.10.0-SNAPSHOT-shaded.jar:$TARDIS_HOME_PATH/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/args4j/args4j/2.32/1ccacebdf8f2db750eb09a402969050f27695fb7/args4j-2.32.jar:$TOOLSJAR_PATH/tools.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/com.github.javaparser/javaparser-core/3.15.9/998ab964f295e6cecd4467a76d4a6369a8193e5a/javaparser-core-3.15.9.jar:$TARDIS_HOME_PATH/jbse/libs/javassist.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.jacoco/org.jacoco.core/0.7.5.201505241946/1ea906dc5201d2a1bc0604f8650534d4bcaf4c95/org.jacoco.core-0.7.5.201505241946.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.ow2.asm/asm-debug-all/5.0.1/f69b5f7d96cec0d448acf1c1a266584170c9643b/asm-debug-all-5.0.1.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/junit/junit/4.12/2973d150c0dc1fefe998f834810d68f278ea58ec/junit-4.12.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.hamcrest/hamcrest-core/1.3/42a25dc3219429f0e5d060061f71acb49bf010a0/hamcrest-core-1.3.jar:$REPO_HOME_PATH/fescar/dependencies/* settings.RunFescar |& tee $LOG_PATH/$dt/FESCAR/tardisLog$BENCHMARK.txt
		echo "[TARDIS LAUNCHER] Tardis execution finished. Calculate results"
		java CalculateResults $LOG_PATH/$dt/FESCAR/tardisLog$BENCHMARK.txt $LOG_PATH/$dt/Results.csv Fescar$BENCHMARK
		TMPDIR=$(ls -td $REPO_HOME_PATH/fescar/tardis-tmp/* | head -1)
		java -ea -Dsbst.benchmark.jacoco="$REPO_HOME_PATH/CovarageTool/jacocoagent.jar" -Dsbst.benchmark.java="java" -Dsbst.benchmark.javac="javac" -Dsbst.benchmark.config="$REPO_HOME_PATH/CovarageTool/benchmarksRepoPath.list" -Dsbst.benchmark.junit="$REPO_HOME_PATH/CovarageTool/junit-4.12.jar" -Dsbst.benchmark.junit.dependency="$REPO_HOME_PATH/CovarageTool/hamcrest-core-1.3.jar" -Dsbst.benchmark.pitest="$REPO_HOME_PATH/CovarageTool/pitest-1.1.11.jar:$REPO_HOME_PATH/CovarageTool/pitest-command-line-1.1.11.jar" -Dtardis.evosuite="$TARDIS_HOME_PATH/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar" -jar "$REPO_HOME_PATH/CovarageTool/benchmarktool-1.0.0-shaded.jar" TARDIS $BENCHMARK $LOG_PATH/$dt/FESCAR 1 $globalTime --only-compute-metrics $TMPDIR/test
	done
fi

#Gson
if [ $input == "7" ] || [ $input == "1" ]; then
	mkdir $LOG_PATH/$dt/GSON
	cp -f $REPO_HOME_PATH/CovarageTool/runtool $LOG_PATH/$dt/GSON
	sed -i "14s/\(Paths.get(\"\).*\(\");\)/\1$TARDIS_HOME_PATH_ESC\2/
			15s/\(Paths.get(\"\).*\(\");\)/\1$Z3_PATH_ESC\2/
			16s/\(Paths.get(\"\).*\(\");\)/\1$REPO_HOME_PATH_ESC\/gson\2/
			s/\(setNumOfThreads(\).*\();\)/\1$thread\2/g
			s/\(setNumMOSATargets(\).*\();\)/\1$mosa\2/g
			s/\(setEvosuiteTimeBudgetDuration(\).*\();\)/\1$evosuiteTime\2/g
			s/\(setGlobalTimeBudgetDuration(\).*\();\)/\1$globalTime\2/g" RunFiles/RunGson.java
	for BENCHMARK in GSON-1 GSON-2 GSON-3 GSON-4 GSON-5 GSON-6 GSON-7 GSON-8 GSON-9 GSON-10
	do
		echo "[TARDIS LAUNCHER] Run benchmark GSON -- Target class: $BENCHMARK"
		sed -i "s/\(setTargetClass(\).*\();\)/\1${BENCHMARK/-/_}\2/g" RunFiles/RunGson.java
		bash CompileAndMove.sh
		timeout -s 9 $timeoutTime java -Xms16G -Xmx16G -cp $REPO_HOME_PATH/gson/gson/target/classes:$TARDIS_HOME_PATH/master/build/libs/tardis-master-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/runtime/build/libs/sushi-lib-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/jbse/build/libs/jbse-0.10.0-SNAPSHOT-shaded.jar:$TARDIS_HOME_PATH/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/args4j/args4j/2.32/1ccacebdf8f2db750eb09a402969050f27695fb7/args4j-2.32.jar:$TOOLSJAR_PATH/tools.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/com.github.javaparser/javaparser-core/3.15.9/998ab964f295e6cecd4467a76d4a6369a8193e5a/javaparser-core-3.15.9.jar:$TARDIS_HOME_PATH/jbse/libs/javassist.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.jacoco/org.jacoco.core/0.7.5.201505241946/1ea906dc5201d2a1bc0604f8650534d4bcaf4c95/org.jacoco.core-0.7.5.201505241946.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.ow2.asm/asm-debug-all/5.0.1/f69b5f7d96cec0d448acf1c1a266584170c9643b/asm-debug-all-5.0.1.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/junit/junit/4.12/2973d150c0dc1fefe998f834810d68f278ea58ec/junit-4.12.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.hamcrest/hamcrest-core/1.3/42a25dc3219429f0e5d060061f71acb49bf010a0/hamcrest-core-1.3.jar:$REPO_HOME_PATH/gson/dependencies/* settings.RunGson |& tee $LOG_PATH/$dt/GSON/tardisLog$BENCHMARK.txt
		echo "[TARDIS LAUNCHER] Tardis execution finished. Calculate results"
		java CalculateResults $LOG_PATH/$dt/GSON/tardisLog$BENCHMARK.txt $LOG_PATH/$dt/Results.csv Gson$BENCHMARK
		TMPDIR=$(ls -td $REPO_HOME_PATH/gson/tardis-tmp/* | head -1)
		java -ea -Dsbst.benchmark.jacoco="$REPO_HOME_PATH/CovarageTool/jacocoagent.jar" -Dsbst.benchmark.java="java" -Dsbst.benchmark.javac="javac" -Dsbst.benchmark.config="$REPO_HOME_PATH/CovarageTool/benchmarksRepoPath.list" -Dsbst.benchmark.junit="$REPO_HOME_PATH/CovarageTool/junit-4.12.jar" -Dsbst.benchmark.junit.dependency="$REPO_HOME_PATH/CovarageTool/hamcrest-core-1.3.jar" -Dsbst.benchmark.pitest="$REPO_HOME_PATH/CovarageTool/pitest-1.1.11.jar:$REPO_HOME_PATH/CovarageTool/pitest-command-line-1.1.11.jar" -Dtardis.evosuite="$TARDIS_HOME_PATH/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar" -jar "$REPO_HOME_PATH/CovarageTool/benchmarktool-1.0.0-shaded.jar" TARDIS $BENCHMARK $LOG_PATH/$dt/GSON 1 $globalTime --only-compute-metrics $TMPDIR/test
	done
fi

#Guava
if [ $input == "8" ] || [ $input == "1" ]; then
	mkdir $LOG_PATH/$dt/GUAVA
	cp -f $REPO_HOME_PATH/CovarageTool/runtool $LOG_PATH/$dt/GUAVA
	sed -i "14s/\(Paths.get(\"\).*\(\");\)/\1$TARDIS_HOME_PATH_ESC\2/
			15s/\(Paths.get(\"\).*\(\");\)/\1$Z3_PATH_ESC\2/
			16s/\(Paths.get(\"\).*\(\");\)/\1$REPO_HOME_PATH_ESC\/guava\2/
			s/\(setNumOfThreads(\).*\();\)/\1$thread\2/g
			s/\(setNumMOSATargets(\).*\();\)/\1$mosa\2/g
			s/\(setEvosuiteTimeBudgetDuration(\).*\();\)/\1$evosuiteTime\2/g
			s/\(setGlobalTimeBudgetDuration(\).*\();\)/\1$globalTime\2/g" RunFiles/RunGuava.java
	for BENCHMARK in GUAVA-2 GUAVA-22 GUAVA-39 GUAVA-47 GUAVA-90 GUAVA-95 GUAVA-102 GUAVA-110 GUAVA-128 GUAVA-129 GUAVA-159 GUAVA-169 GUAVA-177 GUAVA-181 GUAVA-184 GUAVA-196 GUAVA-206 GUAVA-212 GUAVA-224 GUAVA-240
	do
		echo "[TARDIS LAUNCHER] Run benchmark GUAVA -- Target class: $BENCHMARK"
		sed -i "s/\(setTargetClass(\).*\();\)/\1${BENCHMARK/-/_}\2/g" RunFiles/RunGuava.java
		bash CompileAndMove.sh
		timeout -s 9 $timeoutTime java -Xms16G -Xmx16G -cp $REPO_HOME_PATH/guava/guava/target/classes:$TARDIS_HOME_PATH/master/build/libs/tardis-master-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/runtime/build/libs/sushi-lib-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/jbse/build/libs/jbse-0.10.0-SNAPSHOT-shaded.jar:$TARDIS_HOME_PATH/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/args4j/args4j/2.32/1ccacebdf8f2db750eb09a402969050f27695fb7/args4j-2.32.jar:$TOOLSJAR_PATH/tools.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/com.github.javaparser/javaparser-core/3.15.9/998ab964f295e6cecd4467a76d4a6369a8193e5a/javaparser-core-3.15.9.jar:$TARDIS_HOME_PATH/jbse/libs/javassist.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.jacoco/org.jacoco.core/0.7.5.201505241946/1ea906dc5201d2a1bc0604f8650534d4bcaf4c95/org.jacoco.core-0.7.5.201505241946.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.ow2.asm/asm-debug-all/5.0.1/f69b5f7d96cec0d448acf1c1a266584170c9643b/asm-debug-all-5.0.1.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/junit/junit/4.12/2973d150c0dc1fefe998f834810d68f278ea58ec/junit-4.12.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.hamcrest/hamcrest-core/1.3/42a25dc3219429f0e5d060061f71acb49bf010a0/hamcrest-core-1.3.jar:$REPO_HOME_PATH/guava/dependencies/* settings.RunGuava |& tee $LOG_PATH/$dt/GUAVA/tardisLog$BENCHMARK.txt
		echo "[TARDIS LAUNCHER] Tardis execution finished. Calculate results"
		java CalculateResults $LOG_PATH/$dt/GUAVA/tardisLog$BENCHMARK.txt $LOG_PATH/$dt/Results.csv Guava$BENCHMARK
		TMPDIR=$(ls -td $REPO_HOME_PATH/guava/tardis-tmp/* | head -1)
		java -ea -Dsbst.benchmark.jacoco="$REPO_HOME_PATH/CovarageTool/jacocoagent.jar" -Dsbst.benchmark.java="java" -Dsbst.benchmark.javac="javac" -Dsbst.benchmark.config="$REPO_HOME_PATH/CovarageTool/benchmarksRepoPath.list" -Dsbst.benchmark.junit="$REPO_HOME_PATH/CovarageTool/junit-4.12.jar" -Dsbst.benchmark.junit.dependency="$REPO_HOME_PATH/CovarageTool/hamcrest-core-1.3.jar" -Dsbst.benchmark.pitest="$REPO_HOME_PATH/CovarageTool/pitest-1.1.11.jar:$REPO_HOME_PATH/CovarageTool/pitest-command-line-1.1.11.jar" -Dtardis.evosuite="$TARDIS_HOME_PATH/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar" -jar "$REPO_HOME_PATH/CovarageTool/benchmarktool-1.0.0-shaded.jar" TARDIS $BENCHMARK $LOG_PATH/$dt/GUAVA 1 $globalTime --only-compute-metrics $TMPDIR/test
	done
fi

#Image
if [ $input == "9" ] || [ $input == "1" ]; then
	mkdir $LOG_PATH/$dt/IMAGE
	cp -f $REPO_HOME_PATH/CovarageTool/runtool $LOG_PATH/$dt/IMAGE
	sed -i "14s/\(Paths.get(\"\).*\(\");\)/\1$TARDIS_HOME_PATH_ESC\2/
			15s/\(Paths.get(\"\).*\(\");\)/\1$Z3_PATH_ESC\2/
			16s/\(Paths.get(\"\).*\(\");\)/\1$REPO_HOME_PATH_ESC\/commons-imaging\2/
			s/\(setNumOfThreads(\).*\();\)/\1$thread\2/g
			s/\(setNumMOSATargets(\).*\();\)/\1$mosa\2/g
			s/\(setEvosuiteTimeBudgetDuration(\).*\();\)/\1$evosuiteTime\2/g
			s/\(setGlobalTimeBudgetDuration(\).*\();\)/\1$globalTime\2/g" RunFiles/RunImage.java
	for BENCHMARK in IMAGE-1 IMAGE-2 IMAGE-3 IMAGE-4
	do
		echo "[TARDIS LAUNCHER] Run benchmark IMAGE -- Target class: $BENCHMARK"
		sed -i "s/\(setTargetClass(\).*\();\)/\1${BENCHMARK/-/_}\2/g" RunFiles/RunImage.java
		bash CompileAndMove.sh
		timeout -s 9 $timeoutTime java -Xms16G -Xmx16G -cp $REPO_HOME_PATH/commons-imaging/target/classes:$TARDIS_HOME_PATH/master/build/libs/tardis-master-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/runtime/build/libs/sushi-lib-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/jbse/build/libs/jbse-0.10.0-SNAPSHOT-shaded.jar:$TARDIS_HOME_PATH/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/args4j/args4j/2.32/1ccacebdf8f2db750eb09a402969050f27695fb7/args4j-2.32.jar:$TOOLSJAR_PATH/tools.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/com.github.javaparser/javaparser-core/3.15.9/998ab964f295e6cecd4467a76d4a6369a8193e5a/javaparser-core-3.15.9.jar:$TARDIS_HOME_PATH/jbse/libs/javassist.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.jacoco/org.jacoco.core/0.7.5.201505241946/1ea906dc5201d2a1bc0604f8650534d4bcaf4c95/org.jacoco.core-0.7.5.201505241946.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.ow2.asm/asm-debug-all/5.0.1/f69b5f7d96cec0d448acf1c1a266584170c9643b/asm-debug-all-5.0.1.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/junit/junit/4.12/2973d150c0dc1fefe998f834810d68f278ea58ec/junit-4.12.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.hamcrest/hamcrest-core/1.3/42a25dc3219429f0e5d060061f71acb49bf010a0/hamcrest-core-1.3.jar:$REPO_HOME_PATH/commons-imaging/dependencies/* settings.RunImage |& tee $LOG_PATH/$dt/IMAGE/tardisLog$BENCHMARK.txt
		echo "[TARDIS LAUNCHER] Tardis execution finished. Calculate results"
		java CalculateResults $LOG_PATH/$dt/IMAGE/tardisLog$BENCHMARK.txt $LOG_PATH/$dt/Results.csv Image$BENCHMARK
		TMPDIR=$(ls -td $REPO_HOME_PATH/commons-imaging/tardis-tmp/* | head -1)
		java -ea -Dsbst.benchmark.jacoco="$REPO_HOME_PATH/CovarageTool/jacocoagent.jar" -Dsbst.benchmark.java="java" -Dsbst.benchmark.javac="javac" -Dsbst.benchmark.config="$REPO_HOME_PATH/CovarageTool/benchmarksRepoPath.list" -Dsbst.benchmark.junit="$REPO_HOME_PATH/CovarageTool/junit-4.12.jar" -Dsbst.benchmark.junit.dependency="$REPO_HOME_PATH/CovarageTool/hamcrest-core-1.3.jar" -Dsbst.benchmark.pitest="$REPO_HOME_PATH/CovarageTool/pitest-1.1.11.jar:$REPO_HOME_PATH/CovarageTool/pitest-command-line-1.1.11.jar" -Dtardis.evosuite="$TARDIS_HOME_PATH/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar" -jar "$REPO_HOME_PATH/CovarageTool/benchmarktool-1.0.0-shaded.jar" TARDIS $BENCHMARK $LOG_PATH/$dt/IMAGE 1 $globalTime --only-compute-metrics $TMPDIR/test
	done
fi

#Jsoup
if [ $input == "10" ] || [ $input == "1" ]; then
	mkdir $LOG_PATH/$dt/JSOUP
	cp -f $REPO_HOME_PATH/CovarageTool/runtool $LOG_PATH/$dt/JSOUP
	sed -i "14s/\(Paths.get(\"\).*\(\");\)/\1$TARDIS_HOME_PATH_ESC\2/
			15s/\(Paths.get(\"\).*\(\");\)/\1$Z3_PATH_ESC\2/
			16s/\(Paths.get(\"\).*\(\");\)/\1$REPO_HOME_PATH_ESC\/jsoup\2/
			s/\(setNumOfThreads(\).*\();\)/\1$thread\2/g
			s/\(setNumMOSATargets(\).*\();\)/\1$mosa\2/g
			s/\(setEvosuiteTimeBudgetDuration(\).*\();\)/\1$evosuiteTime\2/g
			s/\(setGlobalTimeBudgetDuration(\).*\();\)/\1$globalTime\2/g" RunFiles/RunJsoup.java
	for BENCHMARK in JSOUP-1 JSOUP-2 JSOUP-3 JSOUP-4 JSOUP-5
	do
		echo "[TARDIS LAUNCHER] Run benchmark JSOUP -- Target class: $BENCHMARK"
		sed -i "s/\(setTargetClass(\).*\();\)/\1${BENCHMARK/-/_}\2/g" RunFiles/RunJsoup.java
		bash CompileAndMove.sh
		timeout -s 9 $timeoutTime java -Xms16G -Xmx16G -cp $REPO_HOME_PATH/jsoup/target/classes:$TARDIS_HOME_PATH/master/build/libs/tardis-master-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/runtime/build/libs/sushi-lib-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/jbse/build/libs/jbse-0.10.0-SNAPSHOT-shaded.jar:$TARDIS_HOME_PATH/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/args4j/args4j/2.32/1ccacebdf8f2db750eb09a402969050f27695fb7/args4j-2.32.jar:$TOOLSJAR_PATH/tools.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/com.github.javaparser/javaparser-core/3.15.9/998ab964f295e6cecd4467a76d4a6369a8193e5a/javaparser-core-3.15.9.jar:$TARDIS_HOME_PATH/jbse/libs/javassist.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.jacoco/org.jacoco.core/0.7.5.201505241946/1ea906dc5201d2a1bc0604f8650534d4bcaf4c95/org.jacoco.core-0.7.5.201505241946.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.ow2.asm/asm-debug-all/5.0.1/f69b5f7d96cec0d448acf1c1a266584170c9643b/asm-debug-all-5.0.1.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/junit/junit/4.12/2973d150c0dc1fefe998f834810d68f278ea58ec/junit-4.12.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.hamcrest/hamcrest-core/1.3/42a25dc3219429f0e5d060061f71acb49bf010a0/hamcrest-core-1.3.jar:$REPO_HOME_PATH/jsoup/dependencies/* settings.RunJsoup |& tee $LOG_PATH/$dt/JSOUP/tardisLog$BENCHMARK.txt
		echo "[TARDIS LAUNCHER] Tardis execution finished. Calculate results"
		java CalculateResults $LOG_PATH/$dt/JSOUP/tardisLog$BENCHMARK.txt $LOG_PATH/$dt/Results.csv Jsoup$BENCHMARK
		TMPDIR=$(ls -td $REPO_HOME_PATH/jsoup/tardis-tmp/* | head -1)
		java -ea -Dsbst.benchmark.jacoco="$REPO_HOME_PATH/CovarageTool/jacocoagent.jar" -Dsbst.benchmark.java="java" -Dsbst.benchmark.javac="javac" -Dsbst.benchmark.config="$REPO_HOME_PATH/CovarageTool/benchmarksRepoPath.list" -Dsbst.benchmark.junit="$REPO_HOME_PATH/CovarageTool/junit-4.12.jar" -Dsbst.benchmark.junit.dependency="$REPO_HOME_PATH/CovarageTool/hamcrest-core-1.3.jar" -Dsbst.benchmark.pitest="$REPO_HOME_PATH/CovarageTool/pitest-1.1.11.jar:$REPO_HOME_PATH/CovarageTool/pitest-command-line-1.1.11.jar" -Dtardis.evosuite="$TARDIS_HOME_PATH/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar" -jar "$REPO_HOME_PATH/CovarageTool/benchmarktool-1.0.0-shaded.jar" TARDIS $BENCHMARK $LOG_PATH/$dt/JSOUP 1 $globalTime --only-compute-metrics $TMPDIR/test
	done
fi

#Jxpath
if [ $input == "11" ] || [ $input == "1" ]; then
	mkdir $LOG_PATH/$dt/JXPATH
	cp -f $REPO_HOME_PATH/CovarageTool/runtool $LOG_PATH/$dt/JXPATH
	sed -i "14s/\(Paths.get(\"\).*\(\");\)/\1$TARDIS_HOME_PATH_ESC\2/
			15s/\(Paths.get(\"\).*\(\");\)/\1$Z3_PATH_ESC\2/
			16s/\(Paths.get(\"\).*\(\");\)/\1$REPO_HOME_PATH_ESC\/commons-jxpath-1.3-src\2/
			s/\(setNumOfThreads(\).*\();\)/\1$thread\2/g
			s/\(setNumMOSATargets(\).*\();\)/\1$mosa\2/g
			s/\(setEvosuiteTimeBudgetDuration(\).*\();\)/\1$evosuiteTime\2/g
			s/\(setGlobalTimeBudgetDuration(\).*\();\)/\1$globalTime\2/g" RunFiles/RunJxpath.java
	for BENCHMARK in JXPATH-1 JXPATH-2 JXPATH-3 JXPATH-4 JXPATH-5 JXPATH-6 JXPATH-7 JXPATH-8 JXPATH-9 JXPATH-10
	do
		echo "[TARDIS LAUNCHER] Run benchmark JXPATH -- Target class: $BENCHMARK"
		sed -i "s/\(setTargetClass(\).*\();\)/\1${BENCHMARK/-/_}\2/g" RunFiles/RunJxpath.java
		bash CompileAndMove.sh
		timeout -s 9 $timeoutTime java -Xms16G -Xmx16G -cp $REPO_HOME_PATH/commons-jxpath-1.3-src/target/classes:$TARDIS_HOME_PATH/master/build/libs/tardis-master-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/runtime/build/libs/sushi-lib-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/jbse/build/libs/jbse-0.10.0-SNAPSHOT-shaded.jar:$TARDIS_HOME_PATH/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/args4j/args4j/2.32/1ccacebdf8f2db750eb09a402969050f27695fb7/args4j-2.32.jar:$TOOLSJAR_PATH/tools.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/com.github.javaparser/javaparser-core/3.15.9/998ab964f295e6cecd4467a76d4a6369a8193e5a/javaparser-core-3.15.9.jar:$TARDIS_HOME_PATH/jbse/libs/javassist.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.jacoco/org.jacoco.core/0.7.5.201505241946/1ea906dc5201d2a1bc0604f8650534d4bcaf4c95/org.jacoco.core-0.7.5.201505241946.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.ow2.asm/asm-debug-all/5.0.1/f69b5f7d96cec0d448acf1c1a266584170c9643b/asm-debug-all-5.0.1.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/junit/junit/4.12/2973d150c0dc1fefe998f834810d68f278ea58ec/junit-4.12.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.hamcrest/hamcrest-core/1.3/42a25dc3219429f0e5d060061f71acb49bf010a0/hamcrest-core-1.3.jar:$REPO_HOME_PATH/commons-jxpath-1.3-src/dependencies/* settings.RunJxpath |& tee $LOG_PATH/$dt/JXPATH/tardisLog$BENCHMARK.txt
		echo "[TARDIS LAUNCHER] Tardis execution finished. Calculate results"
		java CalculateResults $LOG_PATH/$dt/JXPATH/tardisLog$BENCHMARK.txt $LOG_PATH/$dt/Results.csv Jxpath$BENCHMARK
		TMPDIR=$(ls -td $REPO_HOME_PATH/commons-jxpath-1.3-src/tardis-tmp/* | head -1)
		java -ea -Dsbst.benchmark.jacoco="$REPO_HOME_PATH/CovarageTool/jacocoagent.jar" -Dsbst.benchmark.java="java" -Dsbst.benchmark.javac="javac" -Dsbst.benchmark.config="$REPO_HOME_PATH/CovarageTool/benchmarksRepoPath.list" -Dsbst.benchmark.junit="$REPO_HOME_PATH/CovarageTool/junit-4.12.jar" -Dsbst.benchmark.junit.dependency="$REPO_HOME_PATH/CovarageTool/hamcrest-core-1.3.jar" -Dsbst.benchmark.pitest="$REPO_HOME_PATH/CovarageTool/pitest-1.1.11.jar:$REPO_HOME_PATH/CovarageTool/pitest-command-line-1.1.11.jar" -Dtardis.evosuite="$TARDIS_HOME_PATH/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar" -jar "$REPO_HOME_PATH/CovarageTool/benchmarktool-1.0.0-shaded.jar" TARDIS $BENCHMARK $LOG_PATH/$dt/JXPATH 1 $globalTime --only-compute-metrics $TMPDIR/test
	done
fi

#La4j
if [ $input == "12" ] || [ $input == "1" ]; then
	mkdir $LOG_PATH/$dt/LA4J
	cp -f $REPO_HOME_PATH/CovarageTool/runtool $LOG_PATH/$dt/LA4J
	sed -i "14s/\(Paths.get(\"\).*\(\");\)/\1$TARDIS_HOME_PATH_ESC\2/
			15s/\(Paths.get(\"\).*\(\");\)/\1$Z3_PATH_ESC\2/
			16s/\(Paths.get(\"\).*\(\");\)/\1$REPO_HOME_PATH_ESC\/la4j-0.6.0\2/
			s/\(setNumOfThreads(\).*\();\)/\1$thread\2/g
			s/\(setNumMOSATargets(\).*\();\)/\1$mosa\2/g
			s/\(setEvosuiteTimeBudgetDuration(\).*\();\)/\1$evosuiteTime\2/g
			s/\(setGlobalTimeBudgetDuration(\).*\();\)/\1$globalTime\2/g" RunFiles/RunLa4j.java
	for BENCHMARK in LA4J-1 LA4J-2 LA4J-3 LA4J-4 LA4J-5 LA4J-6 LA4J-7 LA4J-8 LA4J-9 LA4J-10
	do
		echo "[TARDIS LAUNCHER] Run benchmark LA4J -- Target class: $BENCHMARK"
		sed -i "s/\(setTargetClass(\).*\();\)/\1${BENCHMARK/-/_}\2/g" RunFiles/RunLa4j.java
		bash CompileAndMove.sh
		timeout -s 9 $timeoutTime java -Xms16G -Xmx16G -cp $REPO_HOME_PATH/la4j-0.6.0/target/classes:$TARDIS_HOME_PATH/master/build/libs/tardis-master-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/runtime/build/libs/sushi-lib-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/jbse/build/libs/jbse-0.10.0-SNAPSHOT-shaded.jar:$TARDIS_HOME_PATH/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/args4j/args4j/2.32/1ccacebdf8f2db750eb09a402969050f27695fb7/args4j-2.32.jar:$TOOLSJAR_PATH/tools.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/com.github.javaparser/javaparser-core/3.15.9/998ab964f295e6cecd4467a76d4a6369a8193e5a/javaparser-core-3.15.9.jar:$TARDIS_HOME_PATH/jbse/libs/javassist.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.jacoco/org.jacoco.core/0.7.5.201505241946/1ea906dc5201d2a1bc0604f8650534d4bcaf4c95/org.jacoco.core-0.7.5.201505241946.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.ow2.asm/asm-debug-all/5.0.1/f69b5f7d96cec0d448acf1c1a266584170c9643b/asm-debug-all-5.0.1.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/junit/junit/4.12/2973d150c0dc1fefe998f834810d68f278ea58ec/junit-4.12.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.hamcrest/hamcrest-core/1.3/42a25dc3219429f0e5d060061f71acb49bf010a0/hamcrest-core-1.3.jar:$REPO_HOME_PATH/la4j-0.6.0/dependencies/* settings.RunLa4j |& tee $LOG_PATH/$dt/LA4J/tardisLog$BENCHMARK.txt
		echo "[TARDIS LAUNCHER] Tardis execution finished. Calculate results"
		java CalculateResults $LOG_PATH/$dt/LA4J/tardisLog$BENCHMARK.txt $LOG_PATH/$dt/Results.csv La4j$BENCHMARK
		TMPDIR=$(ls -td $REPO_HOME_PATH/la4j-0.6.0/tardis-tmp/* | head -1)
		java -ea -Dsbst.benchmark.jacoco="$REPO_HOME_PATH/CovarageTool/jacocoagent.jar" -Dsbst.benchmark.java="java" -Dsbst.benchmark.javac="javac" -Dsbst.benchmark.config="$REPO_HOME_PATH/CovarageTool/benchmarksRepoPath.list" -Dsbst.benchmark.junit="$REPO_HOME_PATH/CovarageTool/junit-4.12.jar" -Dsbst.benchmark.junit.dependency="$REPO_HOME_PATH/CovarageTool/hamcrest-core-1.3.jar" -Dsbst.benchmark.pitest="$REPO_HOME_PATH/CovarageTool/pitest-1.1.11.jar:$REPO_HOME_PATH/CovarageTool/pitest-command-line-1.1.11.jar" -Dtardis.evosuite="$TARDIS_HOME_PATH/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar" -jar "$REPO_HOME_PATH/CovarageTool/benchmarktool-1.0.0-shaded.jar" TARDIS $BENCHMARK $LOG_PATH/$dt/LA4J 1 $globalTime --only-compute-metrics $TMPDIR/test
	done
fi

#Okhttp
if [ $input == "13" ] || [ $input == "1" ]; then
	mkdir $LOG_PATH/$dt/OKHTTP
	cp -f $REPO_HOME_PATH/CovarageTool/runtool $LOG_PATH/$dt/OKHTTP
	sed -i "14s/\(Paths.get(\"\).*\(\");\)/\1$TARDIS_HOME_PATH_ESC\2/
			15s/\(Paths.get(\"\).*\(\");\)/\1$Z3_PATH_ESC\2/
			16s/\(Paths.get(\"\).*\(\");\)/\1$REPO_HOME_PATH_ESC\/okhttp\2/
			s/\(setNumOfThreads(\).*\();\)/\1$thread\2/g
			s/\(setNumMOSATargets(\).*\();\)/\1$mosa\2/g
			s/\(setEvosuiteTimeBudgetDuration(\).*\();\)/\1$evosuiteTime\2/g
			s/\(setGlobalTimeBudgetDuration(\).*\();\)/\1$globalTime\2/g" RunFiles/RunOkhttp.java
	for BENCHMARK in OKHTTP-1 OKHTTP-2 OKHTTP-3 OKHTTP-4 OKHTTP-5 OKHTTP-6 OKHTTP-7 OKHTTP-8
	do
		echo "[TARDIS LAUNCHER] Run benchmark OKHTTP -- Target class: $BENCHMARK"
		sed -i "s/\(setTargetClass(\).*\();\)/\1${BENCHMARK/-/_}\2/g" RunFiles/RunOkhttp.java
		bash CompileAndMove.sh
		timeout -s 9 $timeoutTime java -Xms16G -Xmx16G -cp $REPO_HOME_PATH/okhttp/okhttp/target/classes:$TARDIS_HOME_PATH/master/build/libs/tardis-master-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/runtime/build/libs/sushi-lib-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/jbse/build/libs/jbse-0.10.0-SNAPSHOT-shaded.jar:$TARDIS_HOME_PATH/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/args4j/args4j/2.32/1ccacebdf8f2db750eb09a402969050f27695fb7/args4j-2.32.jar:$TOOLSJAR_PATH/tools.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/com.github.javaparser/javaparser-core/3.15.9/998ab964f295e6cecd4467a76d4a6369a8193e5a/javaparser-core-3.15.9.jar:$TARDIS_HOME_PATH/jbse/libs/javassist.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.jacoco/org.jacoco.core/0.7.5.201505241946/1ea906dc5201d2a1bc0604f8650534d4bcaf4c95/org.jacoco.core-0.7.5.201505241946.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.ow2.asm/asm-debug-all/5.0.1/f69b5f7d96cec0d448acf1c1a266584170c9643b/asm-debug-all-5.0.1.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/junit/junit/4.12/2973d150c0dc1fefe998f834810d68f278ea58ec/junit-4.12.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.hamcrest/hamcrest-core/1.3/42a25dc3219429f0e5d060061f71acb49bf010a0/hamcrest-core-1.3.jar:$REPO_HOME_PATH/okhttp/dependencies/* settings.RunOkhttp |& tee $LOG_PATH/$dt/OKHTTP/tardisLog$BENCHMARK.txt
		echo "[TARDIS LAUNCHER] Tardis execution finished. Calculate results"
		java CalculateResults $LOG_PATH/$dt/OKHTTP/tardisLog$BENCHMARK.txt $LOG_PATH/$dt/Results.csv Okhttp$BENCHMARK
		TMPDIR=$(ls -td $REPO_HOME_PATH/okhttp/tardis-tmp/* | head -1)
		java -ea -Dsbst.benchmark.jacoco="$REPO_HOME_PATH/CovarageTool/jacocoagent.jar" -Dsbst.benchmark.java="java" -Dsbst.benchmark.javac="javac" -Dsbst.benchmark.config="$REPO_HOME_PATH/CovarageTool/benchmarksRepoPath.list" -Dsbst.benchmark.junit="$REPO_HOME_PATH/CovarageTool/junit-4.12.jar" -Dsbst.benchmark.junit.dependency="$REPO_HOME_PATH/CovarageTool/hamcrest-core-1.3.jar" -Dsbst.benchmark.pitest="$REPO_HOME_PATH/CovarageTool/pitest-1.1.11.jar:$REPO_HOME_PATH/CovarageTool/pitest-command-line-1.1.11.jar" -Dtardis.evosuite="$TARDIS_HOME_PATH/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar" -jar "$REPO_HOME_PATH/CovarageTool/benchmarktool-1.0.0-shaded.jar" TARDIS $BENCHMARK $LOG_PATH/$dt/OKHTTP 1 $globalTime --only-compute-metrics $TMPDIR/test
	done
fi

#Okio
if [ $input == "14" ] || [ $input == "1" ]; then
	mkdir $LOG_PATH/$dt/OKIO
	cp -f $REPO_HOME_PATH/CovarageTool/runtool $LOG_PATH/$dt/OKIO
	sed -i "14s/\(Paths.get(\"\).*\(\");\)/\1$TARDIS_HOME_PATH_ESC\2/
			15s/\(Paths.get(\"\).*\(\");\)/\1$Z3_PATH_ESC\2/
			16s/\(Paths.get(\"\).*\(\");\)/\1$REPO_HOME_PATH_ESC\/okio\2/
			s/\(setNumOfThreads(\).*\();\)/\1$thread\2/g
			s/\(setNumMOSATargets(\).*\();\)/\1$mosa\2/g
			s/\(setEvosuiteTimeBudgetDuration(\).*\();\)/\1$evosuiteTime\2/g
			s/\(setGlobalTimeBudgetDuration(\).*\();\)/\1$globalTime\2/g" RunFiles/RunOkio.java
	for BENCHMARK in OKIO-1 OKIO-2 OKIO-3 OKIO-4 OKIO-5 OKIO-6 OKIO-7 OKIO-8 OKIO-9 OKIO-10
	do
		echo "[TARDIS LAUNCHER] Run benchmark OKIO -- Target class: $BENCHMARK"
		sed -i "s/\(setTargetClass(\).*\();\)/\1${BENCHMARK/-/_}\2/g" RunFiles/RunOkio.java
		bash CompileAndMove.sh
		timeout -s 9 $timeoutTime java -Xms16G -Xmx16G -cp $REPO_HOME_PATH/okio/okio/target/classes:$TARDIS_HOME_PATH/master/build/libs/tardis-master-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/runtime/build/libs/sushi-lib-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/jbse/build/libs/jbse-0.10.0-SNAPSHOT-shaded.jar:$TARDIS_HOME_PATH/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/args4j/args4j/2.32/1ccacebdf8f2db750eb09a402969050f27695fb7/args4j-2.32.jar:$TOOLSJAR_PATH/tools.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/com.github.javaparser/javaparser-core/3.15.9/998ab964f295e6cecd4467a76d4a6369a8193e5a/javaparser-core-3.15.9.jar:$TARDIS_HOME_PATH/jbse/libs/javassist.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.jacoco/org.jacoco.core/0.7.5.201505241946/1ea906dc5201d2a1bc0604f8650534d4bcaf4c95/org.jacoco.core-0.7.5.201505241946.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.ow2.asm/asm-debug-all/5.0.1/f69b5f7d96cec0d448acf1c1a266584170c9643b/asm-debug-all-5.0.1.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/junit/junit/4.12/2973d150c0dc1fefe998f834810d68f278ea58ec/junit-4.12.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.hamcrest/hamcrest-core/1.3/42a25dc3219429f0e5d060061f71acb49bf010a0/hamcrest-core-1.3.jar:$REPO_HOME_PATH/okio/dependencies/* settings.RunOkio |& tee $LOG_PATH/$dt/OKIO/tardisLog$BENCHMARK.txt
		echo "[TARDIS LAUNCHER] Tardis execution finished. Calculate results"
		java CalculateResults $LOG_PATH/$dt/OKIO/tardisLog$BENCHMARK.txt $LOG_PATH/$dt/Results.csv Okio$BENCHMARK
		TMPDIR=$(ls -td $REPO_HOME_PATH/okio/tardis-tmp/* | head -1)
		java -ea -Dsbst.benchmark.jacoco="$REPO_HOME_PATH/CovarageTool/jacocoagent.jar" -Dsbst.benchmark.java="java" -Dsbst.benchmark.javac="javac" -Dsbst.benchmark.config="$REPO_HOME_PATH/CovarageTool/benchmarksRepoPath.list" -Dsbst.benchmark.junit="$REPO_HOME_PATH/CovarageTool/junit-4.12.jar" -Dsbst.benchmark.junit.dependency="$REPO_HOME_PATH/CovarageTool/hamcrest-core-1.3.jar" -Dsbst.benchmark.pitest="$REPO_HOME_PATH/CovarageTool/pitest-1.1.11.jar:$REPO_HOME_PATH/CovarageTool/pitest-command-line-1.1.11.jar" -Dtardis.evosuite="$TARDIS_HOME_PATH/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar" -jar "$REPO_HOME_PATH/CovarageTool/benchmarktool-1.0.0-shaded.jar" TARDIS $BENCHMARK $LOG_PATH/$dt/OKIO 1 $globalTime --only-compute-metrics $TMPDIR/test
	done
fi

#Pdfbox
if [ $input == "15" ] || [ $input == "1" ]; then
	mkdir $LOG_PATH/$dt/PDFBOX
	cp -f $REPO_HOME_PATH/CovarageTool/runtool $LOG_PATH/$dt/PDFBOX
	sed -i "14s/\(Paths.get(\"\).*\(\");\)/\1$TARDIS_HOME_PATH_ESC\2/
			15s/\(Paths.get(\"\).*\(\");\)/\1$Z3_PATH_ESC\2/
			16s/\(Paths.get(\"\).*\(\");\)/\1$REPO_HOME_PATH_ESC\/pdfbox\2/
			s/\(setNumOfThreads(\).*\();\)/\1$thread\2/g
			s/\(setNumMOSATargets(\).*\();\)/\1$mosa\2/g
			s/\(setEvosuiteTimeBudgetDuration(\).*\();\)/\1$evosuiteTime\2/g
			s/\(setGlobalTimeBudgetDuration(\).*\();\)/\1$globalTime\2/g" RunFiles/RunPdfbox.java
	for BENCHMARK in PDFBOX-8 PDFBOX-22 PDFBOX-26 PDFBOX-40 PDFBOX-62 PDFBOX-83 PDFBOX-91 PDFBOX-117 PDFBOX-127 PDFBOX-130 PDFBOX-157 PDFBOX-198 PDFBOX-214 PDFBOX-220 PDFBOX-229 PDFBOX-234 PDFBOX-235 PDFBOX-265 PDFBOX-278 PDFBOX-285
	do
		echo "[TARDIS LAUNCHER] Run benchmark PDFBOX -- Target class: $BENCHMARK"
		sed -i "s/\(setTargetClass(\).*\();\)/\1${BENCHMARK/-/_}\2/g" RunFiles/RunPdfbox.java
		bash CompileAndMove.sh
		timeout -s 9 $timeoutTime java -Xms16G -Xmx16G -cp $REPO_HOME_PATH/pdfbox/pdfbox/target/classes:$TARDIS_HOME_PATH/master/build/libs/tardis-master-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/runtime/build/libs/sushi-lib-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/jbse/build/libs/jbse-0.10.0-SNAPSHOT-shaded.jar:$TARDIS_HOME_PATH/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/args4j/args4j/2.32/1ccacebdf8f2db750eb09a402969050f27695fb7/args4j-2.32.jar:$TOOLSJAR_PATH/tools.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/com.github.javaparser/javaparser-core/3.15.9/998ab964f295e6cecd4467a76d4a6369a8193e5a/javaparser-core-3.15.9.jar:$TARDIS_HOME_PATH/jbse/libs/javassist.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.jacoco/org.jacoco.core/0.7.5.201505241946/1ea906dc5201d2a1bc0604f8650534d4bcaf4c95/org.jacoco.core-0.7.5.201505241946.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.ow2.asm/asm-debug-all/5.0.1/f69b5f7d96cec0d448acf1c1a266584170c9643b/asm-debug-all-5.0.1.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/junit/junit/4.12/2973d150c0dc1fefe998f834810d68f278ea58ec/junit-4.12.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.hamcrest/hamcrest-core/1.3/42a25dc3219429f0e5d060061f71acb49bf010a0/hamcrest-core-1.3.jar:$REPO_HOME_PATH/pdfbox/dependencies/* settings.RunPdfbox |& tee $LOG_PATH/$dt/PDFBOX/tardisLog$BENCHMARK.txt
		echo "[TARDIS LAUNCHER] Tardis execution finished. Calculate results"
		java CalculateResults $LOG_PATH/$dt/PDFBOX/tardisLog$BENCHMARK.txt $LOG_PATH/$dt/Results.csv Pdfbox$BENCHMARK
		TMPDIR=$(ls -td $REPO_HOME_PATH/pdfbox/tardis-tmp/* | head -1)
		java -ea -Dsbst.benchmark.jacoco="$REPO_HOME_PATH/CovarageTool/jacocoagent.jar" -Dsbst.benchmark.java="java" -Dsbst.benchmark.javac="javac" -Dsbst.benchmark.config="$REPO_HOME_PATH/CovarageTool/benchmarksRepoPath.list" -Dsbst.benchmark.junit="$REPO_HOME_PATH/CovarageTool/junit-4.12.jar" -Dsbst.benchmark.junit.dependency="$REPO_HOME_PATH/CovarageTool/hamcrest-core-1.3.jar" -Dsbst.benchmark.pitest="$REPO_HOME_PATH/CovarageTool/pitest-1.1.11.jar:$REPO_HOME_PATH/CovarageTool/pitest-command-line-1.1.11.jar" -Dtardis.evosuite="$TARDIS_HOME_PATH/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar" -jar "$REPO_HOME_PATH/CovarageTool/benchmarktool-1.0.0-shaded.jar" TARDIS $BENCHMARK $LOG_PATH/$dt/PDFBOX 1 $globalTime --only-compute-metrics $TMPDIR/test
	done
fi

#Re2j
if [ $input == "16" ] || [ $input == "1" ]; then
	mkdir $LOG_PATH/$dt/RE2J
	cp -f $REPO_HOME_PATH/CovarageTool/runtool $LOG_PATH/$dt/RE2J
	sed -i "14s/\(Paths.get(\"\).*\(\");\)/\1$TARDIS_HOME_PATH_ESC\2/
			15s/\(Paths.get(\"\).*\(\");\)/\1$Z3_PATH_ESC\2/
			16s/\(Paths.get(\"\).*\(\");\)/\1$REPO_HOME_PATH_ESC\/re2j\2/
			s/\(setNumOfThreads(\).*\();\)/\1$thread\2/g
			s/\(setNumMOSATargets(\).*\();\)/\1$mosa\2/g
			s/\(setEvosuiteTimeBudgetDuration(\).*\();\)/\1$evosuiteTime\2/g
			s/\(setGlobalTimeBudgetDuration(\).*\();\)/\1$globalTime\2/g" RunFiles/RunRe2j.java
	for BENCHMARK in RE2J-1 RE2J-2 RE2J-3 RE2J-4 RE2J-5 RE2J-6 RE2J-7 RE2J-8
	do
		echo "[TARDIS LAUNCHER] Run benchmark RE2J -- Target class: $BENCHMARK"
		sed -i "s/\(setTargetClass(\).*\();\)/\1${BENCHMARK/-/_}\2/g" RunFiles/RunRe2j.java
		bash CompileAndMove.sh
		timeout -s 9 $timeoutTime java -Xms16G -Xmx16G -cp $REPO_HOME_PATH/re2j/target/classes:$TARDIS_HOME_PATH/master/build/libs/tardis-master-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/runtime/build/libs/sushi-lib-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/jbse/build/libs/jbse-0.10.0-SNAPSHOT-shaded.jar:$TARDIS_HOME_PATH/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/args4j/args4j/2.32/1ccacebdf8f2db750eb09a402969050f27695fb7/args4j-2.32.jar:$TOOLSJAR_PATH/tools.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/com.github.javaparser/javaparser-core/3.15.9/998ab964f295e6cecd4467a76d4a6369a8193e5a/javaparser-core-3.15.9.jar:$TARDIS_HOME_PATH/jbse/libs/javassist.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.jacoco/org.jacoco.core/0.7.5.201505241946/1ea906dc5201d2a1bc0604f8650534d4bcaf4c95/org.jacoco.core-0.7.5.201505241946.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.ow2.asm/asm-debug-all/5.0.1/f69b5f7d96cec0d448acf1c1a266584170c9643b/asm-debug-all-5.0.1.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/junit/junit/4.12/2973d150c0dc1fefe998f834810d68f278ea58ec/junit-4.12.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.hamcrest/hamcrest-core/1.3/42a25dc3219429f0e5d060061f71acb49bf010a0/hamcrest-core-1.3.jar:$REPO_HOME_PATH/re2j/dependencies/* settings.RunRe2j |& tee $LOG_PATH/$dt/RE2J/tardisLog$BENCHMARK.txt
		echo "[TARDIS LAUNCHER] Tardis execution finished. Calculate results"
		java CalculateResults $LOG_PATH/$dt/RE2J/tardisLog$BENCHMARK.txt $LOG_PATH/$dt/Results.csv Re2j$BENCHMARK
		TMPDIR=$(ls -td $REPO_HOME_PATH/re2j/tardis-tmp/* | head -1)
		java -ea -Dsbst.benchmark.jacoco="$REPO_HOME_PATH/CovarageTool/jacocoagent.jar" -Dsbst.benchmark.java="java" -Dsbst.benchmark.javac="javac" -Dsbst.benchmark.config="$REPO_HOME_PATH/CovarageTool/benchmarksRepoPath.list" -Dsbst.benchmark.junit="$REPO_HOME_PATH/CovarageTool/junit-4.12.jar" -Dsbst.benchmark.junit.dependency="$REPO_HOME_PATH/CovarageTool/hamcrest-core-1.3.jar" -Dsbst.benchmark.pitest="$REPO_HOME_PATH/CovarageTool/pitest-1.1.11.jar:$REPO_HOME_PATH/CovarageTool/pitest-command-line-1.1.11.jar" -Dtardis.evosuite="$TARDIS_HOME_PATH/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar" -jar "$REPO_HOME_PATH/CovarageTool/benchmarktool-1.0.0-shaded.jar" TARDIS $BENCHMARK $LOG_PATH/$dt/RE2J 1 $globalTime --only-compute-metrics $TMPDIR/test
	done
fi

#Spoon
if [ $input == "17" ] || [ $input == "1" ]; then
	mkdir $LOG_PATH/$dt/SPOON
	cp -f $REPO_HOME_PATH/CovarageTool/runtool $LOG_PATH/$dt/SPOON
	sed -i "14s/\(Paths.get(\"\).*\(\");\)/\1$TARDIS_HOME_PATH_ESC\2/
			15s/\(Paths.get(\"\).*\(\");\)/\1$Z3_PATH_ESC\2/
			16s/\(Paths.get(\"\).*\(\");\)/\1$REPO_HOME_PATH_ESC\/spoon\2/
			s/\(setNumOfThreads(\).*\();\)/\1$thread\2/g
			s/\(setNumMOSATargets(\).*\();\)/\1$mosa\2/g
			s/\(setEvosuiteTimeBudgetDuration(\).*\();\)/\1$evosuiteTime\2/g
			s/\(setGlobalTimeBudgetDuration(\).*\();\)/\1$globalTime\2/g" RunFiles/RunSpoon.java
	for BENCHMARK in SPOON-105 SPOON-155 SPOON-16 SPOON-169 SPOON-20 SPOON-211 SPOON-25 SPOON-253 SPOON-32 SPOON-65
	do
		echo "[TARDIS LAUNCHER] Run benchmark SPOON -- Target class: $BENCHMARK"
		sed -i "s/\(setTargetClass(\).*\();\)/\1${BENCHMARK/-/_}\2/g" RunFiles/RunSpoon.java
		bash CompileAndMove.sh
		timeout -s 9 $timeoutTime java -Xms16G -Xmx16G -cp $REPO_HOME_PATH/spoon/target/classes:$TARDIS_HOME_PATH/master/build/libs/tardis-master-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/runtime/build/libs/sushi-lib-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/jbse/build/libs/jbse-0.10.0-SNAPSHOT-shaded.jar:$TARDIS_HOME_PATH/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/args4j/args4j/2.32/1ccacebdf8f2db750eb09a402969050f27695fb7/args4j-2.32.jar:$TOOLSJAR_PATH/tools.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/com.github.javaparser/javaparser-core/3.15.9/998ab964f295e6cecd4467a76d4a6369a8193e5a/javaparser-core-3.15.9.jar:$TARDIS_HOME_PATH/jbse/libs/javassist.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.jacoco/org.jacoco.core/0.7.5.201505241946/1ea906dc5201d2a1bc0604f8650534d4bcaf4c95/org.jacoco.core-0.7.5.201505241946.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.ow2.asm/asm-debug-all/5.0.1/f69b5f7d96cec0d448acf1c1a266584170c9643b/asm-debug-all-5.0.1.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/junit/junit/4.12/2973d150c0dc1fefe998f834810d68f278ea58ec/junit-4.12.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.hamcrest/hamcrest-core/1.3/42a25dc3219429f0e5d060061f71acb49bf010a0/hamcrest-core-1.3.jar:$REPO_HOME_PATH/spoon/dependencies/* settings.RunSpoon |& tee $LOG_PATH/$dt/SPOON/tardisLog$BENCHMARK.txt
		echo "[TARDIS LAUNCHER] Tardis execution finished. Calculate results"
		java CalculateResults $LOG_PATH/$dt/SPOON/tardisLog$BENCHMARK.txt $LOG_PATH/$dt/Results.csv Spoon$BENCHMARK
		TMPDIR=$(ls -td $REPO_HOME_PATH/spoon/tardis-tmp/* | head -1)
		java -ea -Dsbst.benchmark.jacoco="$REPO_HOME_PATH/CovarageTool/jacocoagent.jar" -Dsbst.benchmark.java="java" -Dsbst.benchmark.javac="javac" -Dsbst.benchmark.config="$REPO_HOME_PATH/CovarageTool/benchmarksRepoPath.list" -Dsbst.benchmark.junit="$REPO_HOME_PATH/CovarageTool/junit-4.12.jar" -Dsbst.benchmark.junit.dependency="$REPO_HOME_PATH/CovarageTool/hamcrest-core-1.3.jar" -Dsbst.benchmark.pitest="$REPO_HOME_PATH/CovarageTool/pitest-1.1.11.jar:$REPO_HOME_PATH/CovarageTool/pitest-command-line-1.1.11.jar" -Dtardis.evosuite="$TARDIS_HOME_PATH/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar" -jar "$REPO_HOME_PATH/CovarageTool/benchmarktool-1.0.0-shaded.jar" TARDIS $BENCHMARK $LOG_PATH/$dt/SPOON 1 $globalTime --only-compute-metrics $TMPDIR/test
	done
fi

#Webmagic
if [ $input == "18" ] || [ $input == "1" ]; then
	mkdir $LOG_PATH/$dt/WEBMAGIC
	cp -f $REPO_HOME_PATH/CovarageTool/runtool $LOG_PATH/$dt/WEBMAGIC
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
	for BENCHMARK in WEBMAGIC-1 WEBMAGIC-5
	do
		echo "[TARDIS LAUNCHER] Run benchmark WEBMAGIC -- Target class: $BENCHMARK"
		sed -i "s/\(setTargetClass(\).*\();\)/\1${BENCHMARK/-/_}\2/g" RunFiles/RunWebmagic1_5.java
		bash CompileAndMove.sh
		timeout -s 9 $timeoutTime java -Xms16G -Xmx16G -cp $REPO_HOME_PATH/webmagic/webmagic-extension/target/classes:$REPO_HOME_PATH/webmagic/webmagic-core/target/classes:$TARDIS_HOME_PATH/master/build/libs/tardis-master-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/runtime/build/libs/sushi-lib-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/jbse/build/libs/jbse-0.10.0-SNAPSHOT-shaded.jar:$TARDIS_HOME_PATH/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/args4j/args4j/2.32/1ccacebdf8f2db750eb09a402969050f27695fb7/args4j-2.32.jar:$TOOLSJAR_PATH/tools.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/com.github.javaparser/javaparser-core/3.15.9/998ab964f295e6cecd4467a76d4a6369a8193e5a/javaparser-core-3.15.9.jar:$TARDIS_HOME_PATH/jbse/libs/javassist.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.jacoco/org.jacoco.core/0.7.5.201505241946/1ea906dc5201d2a1bc0604f8650534d4bcaf4c95/org.jacoco.core-0.7.5.201505241946.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.ow2.asm/asm-debug-all/5.0.1/f69b5f7d96cec0d448acf1c1a266584170c9643b/asm-debug-all-5.0.1.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/junit/junit/4.12/2973d150c0dc1fefe998f834810d68f278ea58ec/junit-4.12.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.hamcrest/hamcrest-core/1.3/42a25dc3219429f0e5d060061f71acb49bf010a0/hamcrest-core-1.3.jar:$REPO_HOME_PATH/webmagic/dependencies/* settings.RunWebmagic1_5 |& tee $LOG_PATH/$dt/WEBMAGIC/tardisLog$BENCHMARK.txt
		echo "[TARDIS LAUNCHER] Tardis execution finished. Calculate results"
		java CalculateResults $LOG_PATH/$dt/WEBMAGIC/tardisLog$BENCHMARK.txt $LOG_PATH/$dt/Results.csv Webmagic$BENCHMARK
		TMPDIR=$(ls -td $REPO_HOME_PATH/webmagic/tardis-tmp/* | head -1)
		java -ea -Dsbst.benchmark.jacoco="$REPO_HOME_PATH/CovarageTool/jacocoagent.jar" -Dsbst.benchmark.java="java" -Dsbst.benchmark.javac="javac" -Dsbst.benchmark.config="$REPO_HOME_PATH/CovarageTool/benchmarksRepoPath.list" -Dsbst.benchmark.junit="$REPO_HOME_PATH/CovarageTool/junit-4.12.jar" -Dsbst.benchmark.junit.dependency="$REPO_HOME_PATH/CovarageTool/hamcrest-core-1.3.jar" -Dsbst.benchmark.pitest="$REPO_HOME_PATH/CovarageTool/pitest-1.1.11.jar:$REPO_HOME_PATH/CovarageTool/pitest-command-line-1.1.11.jar" -Dtardis.evosuite="$TARDIS_HOME_PATH/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar" -jar "$REPO_HOME_PATH/CovarageTool/benchmarktool-1.0.0-shaded.jar" TARDIS $BENCHMARK $LOG_PATH/$dt/WEBMAGIC 1 $globalTime --only-compute-metrics $TMPDIR/test
	done
	for BENCHMARK in WEBMAGIC-2 WEBMAGIC-3 WEBMAGIC-4
	do
		echo "[TARDIS LAUNCHER] Run benchmark WEBMAGIC -- Target class: $BENCHMARK"
		sed -i "s/\(setTargetClass(\).*\();\)/\1${BENCHMARK/-/_}\2/g" RunFiles/RunWebmagic2_3_4.java
		bash CompileAndMove.sh
		timeout -s 9 $timeoutTime java -Xms16G -Xmx16G -cp $REPO_HOME_PATH/webmagic/webmagic-core/target/classes:$TARDIS_HOME_PATH/master/build/libs/tardis-master-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/runtime/build/libs/sushi-lib-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/jbse/build/libs/jbse-0.10.0-SNAPSHOT-shaded.jar:$TARDIS_HOME_PATH/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/args4j/args4j/2.32/1ccacebdf8f2db750eb09a402969050f27695fb7/args4j-2.32.jar:$TOOLSJAR_PATH/tools.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/com.github.javaparser/javaparser-core/3.15.9/998ab964f295e6cecd4467a76d4a6369a8193e5a/javaparser-core-3.15.9.jar:$TARDIS_HOME_PATH/jbse/libs/javassist.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.jacoco/org.jacoco.core/0.7.5.201505241946/1ea906dc5201d2a1bc0604f8650534d4bcaf4c95/org.jacoco.core-0.7.5.201505241946.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.ow2.asm/asm-debug-all/5.0.1/f69b5f7d96cec0d448acf1c1a266584170c9643b/asm-debug-all-5.0.1.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/junit/junit/4.12/2973d150c0dc1fefe998f834810d68f278ea58ec/junit-4.12.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.hamcrest/hamcrest-core/1.3/42a25dc3219429f0e5d060061f71acb49bf010a0/hamcrest-core-1.3.jar:$REPO_HOME_PATH/webmagic/dependencies/* settings.RunWebmagic2_3_4 |& tee $LOG_PATH/$dt/WEBMAGIC/tardisLog$BENCHMARK.txt
		echo "[TARDIS LAUNCHER] Tardis execution finished. Calculate results"
		java CalculateResults $LOG_PATH/$dt/WEBMAGIC/tardisLog$BENCHMARK.txt $LOG_PATH/$dt/Results.csv Webmagic$BENCHMARK
		TMPDIR=$(ls -td $REPO_HOME_PATH/webmagic/tardis-tmp/* | head -1)
		java -ea -Dsbst.benchmark.jacoco="$REPO_HOME_PATH/CovarageTool/jacocoagent.jar" -Dsbst.benchmark.java="java" -Dsbst.benchmark.javac="javac" -Dsbst.benchmark.config="$REPO_HOME_PATH/CovarageTool/benchmarksRepoPath.list" -Dsbst.benchmark.junit="$REPO_HOME_PATH/CovarageTool/junit-4.12.jar" -Dsbst.benchmark.junit.dependency="$REPO_HOME_PATH/CovarageTool/hamcrest-core-1.3.jar" -Dsbst.benchmark.pitest="$REPO_HOME_PATH/CovarageTool/pitest-1.1.11.jar:$REPO_HOME_PATH/CovarageTool/pitest-command-line-1.1.11.jar" -Dtardis.evosuite="$TARDIS_HOME_PATH/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar" -jar "$REPO_HOME_PATH/CovarageTool/benchmarktool-1.0.0-shaded.jar" TARDIS $BENCHMARK $LOG_PATH/$dt/WEBMAGIC 1 $globalTime --only-compute-metrics $TMPDIR/test
	done
fi

#Zxing
if [ $input == "19" ] || [ $input == "1" ]; then
	mkdir $LOG_PATH/$dt/ZXING
	cp -f $REPO_HOME_PATH/CovarageTool/runtool $LOG_PATH/$dt/ZXING
	sed -i "14s/\(Paths.get(\"\).*\(\");\)/\1$TARDIS_HOME_PATH_ESC\2/
			15s/\(Paths.get(\"\).*\(\");\)/\1$Z3_PATH_ESC\2/
			16s/\(Paths.get(\"\).*\(\");\)/\1$REPO_HOME_PATH_ESC\/zxing\2/
			s/\(setNumOfThreads(\).*\();\)/\1$thread\2/g
			s/\(setNumMOSATargets(\).*\();\)/\1$mosa\2/g
			s/\(setEvosuiteTimeBudgetDuration(\).*\();\)/\1$evosuiteTime\2/g
			s/\(setGlobalTimeBudgetDuration(\).*\();\)/\1$globalTime\2/g" RunFiles/RunZxing.java
	for BENCHMARK in ZXING-1 ZXING-2 ZXING-3 ZXING-4 ZXING-5 ZXING-6 ZXING-7 ZXING-8 ZXING-9 ZXING-10
	do
		echo "[TARDIS LAUNCHER] Run benchmark ZXING -- Target class: $BENCHMARK"
		sed -i "s/\(setTargetClass(\).*\();\)/\1${BENCHMARK/-/_}\2/g" RunFiles/RunZxing.java
		bash CompileAndMove.sh
		timeout -s 9 $timeoutTime java -Xms16G -Xmx16G -cp $REPO_HOME_PATH/zxing/core/target/classes:$TARDIS_HOME_PATH/master/build/libs/tardis-master-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/runtime/build/libs/sushi-lib-0.2.0-SNAPSHOT.jar:$TARDIS_HOME_PATH/jbse/build/libs/jbse-0.10.0-SNAPSHOT-shaded.jar:$TARDIS_HOME_PATH/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/args4j/args4j/2.32/1ccacebdf8f2db750eb09a402969050f27695fb7/args4j-2.32.jar:$TOOLSJAR_PATH/tools.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/com.github.javaparser/javaparser-core/3.15.9/998ab964f295e6cecd4467a76d4a6369a8193e5a/javaparser-core-3.15.9.jar:$TARDIS_HOME_PATH/jbse/libs/javassist.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.jacoco/org.jacoco.core/0.7.5.201505241946/1ea906dc5201d2a1bc0604f8650534d4bcaf4c95/org.jacoco.core-0.7.5.201505241946.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.ow2.asm/asm-debug-all/5.0.1/f69b5f7d96cec0d448acf1c1a266584170c9643b/asm-debug-all-5.0.1.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/junit/junit/4.12/2973d150c0dc1fefe998f834810d68f278ea58ec/junit-4.12.jar:$GRADLE_REPO_PATH/caches/modules-2/files-2.1/org.hamcrest/hamcrest-core/1.3/42a25dc3219429f0e5d060061f71acb49bf010a0/hamcrest-core-1.3.jar:$REPO_HOME_PATH/zxing/dependencies/* settings.RunZxing |& tee $LOG_PATH/$dt/ZXING/tardisLog$BENCHMARK.txt
		echo "[TARDIS LAUNCHER] Tardis execution finished. Calculate results"
		java CalculateResults $LOG_PATH/$dt/ZXING/tardisLog$BENCHMARK.txt $LOG_PATH/$dt/Results.csv Zxing$BENCHMARK
		TMPDIR=$(ls -td $REPO_HOME_PATH/zxing/tardis-tmp/* | head -1)
		java -ea -Dsbst.benchmark.jacoco="$REPO_HOME_PATH/CovarageTool/jacocoagent.jar" -Dsbst.benchmark.java="java" -Dsbst.benchmark.javac="javac" -Dsbst.benchmark.config="$REPO_HOME_PATH/CovarageTool/benchmarksRepoPath.list" -Dsbst.benchmark.junit="$REPO_HOME_PATH/CovarageTool/junit-4.12.jar" -Dsbst.benchmark.junit.dependency="$REPO_HOME_PATH/CovarageTool/hamcrest-core-1.3.jar" -Dsbst.benchmark.pitest="$REPO_HOME_PATH/CovarageTool/pitest-1.1.11.jar:$REPO_HOME_PATH/CovarageTool/pitest-command-line-1.1.11.jar" -Dtardis.evosuite="$TARDIS_HOME_PATH/lib/evosuite-shaded-1.0.6-SNAPSHOT.jar" -jar "$REPO_HOME_PATH/CovarageTool/benchmarktool-1.0.0-shaded.jar" TARDIS $BENCHMARK $LOG_PATH/$dt/ZXING 1 $globalTime --only-compute-metrics $TMPDIR/test
	done
fi

echo "[TARDIS LAUNCHER] ENDING at $(date)"
