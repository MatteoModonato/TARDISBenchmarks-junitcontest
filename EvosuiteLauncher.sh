#!/bin/sh
echo "[EVOSUITE LAUNCHER] STARTING at $(date)"

# -------------------------------------------------------------------------------
# Edit EVOSUITE_PATH, REPO_HOME_PATH and RESULTS_PATH to 
# reflect the paths where you installed the code:

# EVOSUITE_PATH:  Evosuite.jar path
# REPO_HOME_PATH: Home folder of this repository
# RESULTS_PATH:   Folder where you want to save the Evosuite results
EVOSUITE_PATH=/dev/hd2/evosuiteFolder/evosuite-1.1.0.jar
REPO_HOME_PATH=/dev/hd2/tardisFolder/TARDISBenchmarks-junitcontest
RESULTS_PATH=/dev/hd2/evosuiteFolder/evosuiteLogs
# -------------------------------------------------------------------------------

while getopts s: flag
do
    case "${flag}" in
        s) searchBudget=${OPTARG};;
    esac
done
echo "searchBudget: $searchBudget";

echo "[EVOSUITE LAUNCHER] Choose the benchmarks to run:"
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
echo "|  20) WEKA              |"
echo "|  21) FASTJSON 9th      |"
echo "|  22) GUAVA 9th         |"
echo " ------------------------ "
read input
input_array=($input)

dt=$(date +%Y_%m_%d_%H_%M_%S)
mkdir $RESULTS_PATH/$dt

REPO_HOME_PATH_ESC=$(echo $REPO_HOME_PATH | sed 's_/_\\/_g')

cp -f CovarageTool/benchmarks.list CovarageTool/benchmarksRepoPath.list
sed -i "s/REPOSITORYHOMEPATH/$REPO_HOME_PATH_ESC/g" CovarageTool/benchmarksRepoPath.list

#Authzforce
if [[ " ${input_array[@]} " =~ " 2 " ]] || [[ " ${input_array[@]} " =~ " 1 " ]]; then
	mkdir $RESULTS_PATH/$dt/AUTHZFORCE
	cp -f $REPO_HOME_PATH/CovarageTool/runtool $RESULTS_PATH/$dt/AUTHZFORCE
	for BENCHMARK in AUTHZFORCE-1 AUTHZFORCE-11 AUTHZFORCE-27 AUTHZFORCE-32 AUTHZFORCE-33 AUTHZFORCE-48 AUTHZFORCE-5 AUTHZFORCE-52 AUTHZFORCE-63 AUTHZFORCE-65
	do
		echo "[EVOSUITE LAUNCHER] Run benchmark AUTHZFORCE -- Target class: $BENCHMARK"
		mkdir -p $RESULTS_PATH/$dt/AUTHZFORCE/$BENCHMARK/test
		inputClass=$(awk -v pat="${BENCHMARK/-/_} " '$0~pat{print $NF}' RunFiles/RunAuthzforce1.java | sed 's/\"//g;s/;//g;s/\//./g')
		java -Xmx4G -jar $EVOSUITE_PATH -class $inputClass -mem 2048 -DCP=$REPO_HOME_PATH/core-release-13.3.0/pdp-engine/target/classes:$REPO_HOME_PATH/core-release-13.3.0/dependencies/activation-1.1.jar:$REPO_HOME_PATH/core-release-13.3.0/dependencies/animal-sniffer-annotations-1.14.jar:$REPO_HOME_PATH/core-release-13.3.0/dependencies/authzforce-ce-core-pdp-api-15.3.0.jar:$REPO_HOME_PATH/core-release-13.3.0/dependencies/authzforce-ce-pdp-ext-model-7.5.0.jar:$REPO_HOME_PATH/core-release-13.3.0/dependencies/authzforce-ce-xacml-model-7.5.0.jar:$REPO_HOME_PATH/core-release-13.3.0/dependencies/authzforce-ce-xmlns-model-7.5.0.jar:$REPO_HOME_PATH/core-release-13.3.0/dependencies/checker-compat-qual-2.0.0.jar:$REPO_HOME_PATH/core-release-13.3.0/dependencies/error_prone_annotations-2.1.3.jar:$REPO_HOME_PATH/core-release-13.3.0/dependencies/guava-24.1.1-jre.jar:$REPO_HOME_PATH/core-release-13.3.0/dependencies/hamcrest-core-1.3.jar:$REPO_HOME_PATH/core-release-13.3.0/dependencies/j2objc-annotations-1.1.jar:$REPO_HOME_PATH/core-release-13.3.0/dependencies/javax.mail-1.6.0.jar:$REPO_HOME_PATH/core-release-13.3.0/dependencies/javax.mail-api-1.6.0.jar:$REPO_HOME_PATH/core-release-13.3.0/dependencies/jaxb2-basics-runtime-1.11.1.jar:$REPO_HOME_PATH/core-release-13.3.0/dependencies/jcl-over-slf4j-1.7.25.jar:$REPO_HOME_PATH/core-release-13.3.0/dependencies/jsr305-1.3.9.jar:$REPO_HOME_PATH/core-release-13.3.0/dependencies/junit-4.11.jar:$REPO_HOME_PATH/core-release-13.3.0/dependencies/logback-core-1.2.3.jar:$REPO_HOME_PATH/core-release-13.3.0/dependencies/Saxon-HE-9.8.0-12.jar:$REPO_HOME_PATH/core-release-13.3.0/dependencies/slf4j-api-1.7.25.jar:$REPO_HOME_PATH/core-release-13.3.0/dependencies/spring-core-4.3.18.RELEASE.jar:$REPO_HOME_PATH/core-release-13.3.0/dependencies/xml-resolver-1.2.jar -Dassertions=false -Dreport_dir=$RESULTS_PATH/$dt/AUTHZFORCE/$BENCHMARK -Dsearch_budget=$searchBudget -Dtest_dir=$RESULTS_PATH/$dt/AUTHZFORCE/$BENCHMARK/test -Dvirtual_fs=false -Dcriterion=BRANCH -Dinline=false -Djunit_suffix=_Test -Dno_runtime_dependency |& tee $RESULTS_PATH/$dt/AUTHZFORCE/$BENCHMARK/evosuiteLog$BENCHMARK.txt
		java -ea -Dsbst.benchmark.jacoco="$REPO_HOME_PATH/CovarageTool/jacocoagent.jar" -Dsbst.benchmark.java="java" -Dsbst.benchmark.javac="javac" -Dsbst.benchmark.config="$REPO_HOME_PATH/CovarageTool/benchmarksRepoPath.list" -Dsbst.benchmark.junit="$REPO_HOME_PATH/CovarageTool/junit-4.12.jar" -Dsbst.benchmark.junit.dependency="$REPO_HOME_PATH/CovarageTool/hamcrest-core-1.3.jar" -Dsbst.benchmark.pitest="$REPO_HOME_PATH/CovarageTool/pitest-1.1.11.jar:$REPO_HOME_PATH/CovarageTool/pitest-command-line-1.1.11.jar" -jar "$REPO_HOME_PATH/CovarageTool/benchmarktool-1.0.0-shaded.jar" EVOSUITE $BENCHMARK $RESULTS_PATH/$dt/AUTHZFORCE 1 $searchBudget --only-compute-metrics $RESULTS_PATH/$dt/AUTHZFORCE/$BENCHMARK/test
	done
fi

#Bcel
if [[ " ${input_array[@]} " =~ " 3 " ]] || [[ " ${input_array[@]} " =~ " 1 " ]]; then
	mkdir $RESULTS_PATH/$dt/BCEL
	cp -f $REPO_HOME_PATH/CovarageTool/runtool $RESULTS_PATH/$dt/BCEL
	for BENCHMARK in BCEL-1 BCEL-2 BCEL-3 BCEL-4 BCEL-5 BCEL-6 BCEL-7 BCEL-8 BCEL-9 BCEL-10
	do
		echo "[EVOSUITE LAUNCHER] Run benchmark BCEL -- Target class: $BENCHMARK"
		mkdir -p $RESULTS_PATH/$dt/BCEL/$BENCHMARK/test
		inputClass=$(awk -v pat="${BENCHMARK/-/_} " '$0~pat{print $NF}' RunFiles/RunBcel.java | sed 's/\"//g;s/;//g;s/\//./g')
		java -Xmx4G -jar $EVOSUITE_PATH -class $inputClass -mem 2048 -DCP=$REPO_HOME_PATH/bcel-6.0-src/target/classes -Dassertions=false -Dreport_dir=$RESULTS_PATH/$dt/BCEL/$BENCHMARK -Dsearch_budget=$searchBudget -Dtest_dir=$RESULTS_PATH/$dt/BCEL/$BENCHMARK/test -Dvirtual_fs=false -Dcriterion=BRANCH -Dinline=false -Djunit_suffix=_Test -Dno_runtime_dependency |& tee $RESULTS_PATH/$dt/BCEL/$BENCHMARK/evosuiteLog$BENCHMARK.txt
		java -ea -Dsbst.benchmark.jacoco="$REPO_HOME_PATH/CovarageTool/jacocoagent.jar" -Dsbst.benchmark.java="java" -Dsbst.benchmark.javac="javac" -Dsbst.benchmark.config="$REPO_HOME_PATH/CovarageTool/benchmarksRepoPath.list" -Dsbst.benchmark.junit="$REPO_HOME_PATH/CovarageTool/junit-4.12.jar" -Dsbst.benchmark.junit.dependency="$REPO_HOME_PATH/CovarageTool/hamcrest-core-1.3.jar" -Dsbst.benchmark.pitest="$REPO_HOME_PATH/CovarageTool/pitest-1.1.11.jar:$REPO_HOME_PATH/CovarageTool/pitest-command-line-1.1.11.jar" -jar "$REPO_HOME_PATH/CovarageTool/benchmarktool-1.0.0-shaded.jar" EVOSUITE $BENCHMARK $RESULTS_PATH/$dt/BCEL 1 $searchBudget --only-compute-metrics $RESULTS_PATH/$dt/BCEL/$BENCHMARK/test
	done
fi

#Dubbo
if [[ " ${input_array[@]} " =~ " 4 " ]] || [[ " ${input_array[@]} " =~ " 1 " ]]; then
	mkdir $RESULTS_PATH/$dt/DUBBO
	cp -f $REPO_HOME_PATH/CovarageTool/runtool $RESULTS_PATH/$dt/DUBBO
	for BENCHMARK in DUBBO-2 DUBBO-3 DUBBO-4 DUBBO-5 DUBBO-6 DUBBO-7 DUBBO-8 DUBBO-9 DUBBO-10
	do
		echo "[EVOSUITE LAUNCHER] Run benchmark DUBBO -- Target class: $BENCHMARK"
		mkdir -p $RESULTS_PATH/$dt/DUBBO/$BENCHMARK/test
		inputClass=$(awk -v pat="${BENCHMARK/-/_} " '$0~pat{print $NF}' RunFiles/RunDubbo.java | sed 's/\"//g;s/;//g;s/\//./g')
		java -Xmx4G -jar $EVOSUITE_PATH -class $inputClass -mem 2048 -DCP=$REPO_HOME_PATH/dubbo/dubbo-common/target/classes:$REPO_HOME_PATH/dubbo/dubbo-cluster/target/classes:$REPO_HOME_PATH/dubbo/dubbo-container/dubbo-container-api/target/classes:$REPO_HOME_PATH/dubbo/dubbo-container/dubbo-container-log4j/target/classes:$REPO_HOME_PATH/dubbo/dubbo-container/dubbo-container-logback/target/classes:$REPO_HOME_PATH/dubbo/dubbo-container/dubbo-container-spring/target/classes:$REPO_HOME_PATH/dubbo/dubbo-demo/dubbo-demo-api/target/classes:$REPO_HOME_PATH/dubbo/dubbo-demo/dubbo-demo-consumer/target/classes:$REPO_HOME_PATH/dubbo/dubbo-demo/dubbo-demo-provider/target/classes:$REPO_HOME_PATH/dubbo/dubbo-filter/dubbo-filter-cache/target/classes:$REPO_HOME_PATH/dubbo/dubbo-filter/dubbo-filter-validation/target/classes:$REPO_HOME_PATH/dubbo/dubbo-monitor/dubbo-monitor-api/target/classes:$REPO_HOME_PATH/dubbo/dubbo-monitor/dubbo-monitor-default/target/classes:$REPO_HOME_PATH/dubbo/dubbo-plugin/dubbo-qos/target/classes:$REPO_HOME_PATH/dubbo/dubbo-registry/dubbo-registry-api/target/classes:$REPO_HOME_PATH/dubbo/dubbo-registry/dubbo-registry-default/target/classes:$REPO_HOME_PATH/dubbo/dubbo-registry/dubbo-registry-multicast/target/classes:$REPO_HOME_PATH/dubbo/dubbo-registry/dubbo-registry-redis/target/classes:$REPO_HOME_PATH/dubbo/dubbo-registry/dubbo-registry-zookeeper/target/classes:$REPO_HOME_PATH/dubbo/hessian-lite/target/classes -Dassertions=false -Dreport_dir=$RESULTS_PATH/$dt/DUBBO/$BENCHMARK -Dsearch_budget=$searchBudget -Dtest_dir=$RESULTS_PATH/$dt/DUBBO/$BENCHMARK/test -Dvirtual_fs=false -Dcriterion=BRANCH -Dinline=false -Djunit_suffix=_Test -Dno_runtime_dependency |& tee $RESULTS_PATH/$dt/DUBBO/$BENCHMARK/evosuiteLog$BENCHMARK.txt
		java -ea -Dsbst.benchmark.jacoco="$REPO_HOME_PATH/CovarageTool/jacocoagent.jar" -Dsbst.benchmark.java="java" -Dsbst.benchmark.javac="javac" -Dsbst.benchmark.config="$REPO_HOME_PATH/CovarageTool/benchmarksRepoPath.list" -Dsbst.benchmark.junit="$REPO_HOME_PATH/CovarageTool/junit-4.12.jar" -Dsbst.benchmark.junit.dependency="$REPO_HOME_PATH/CovarageTool/hamcrest-core-1.3.jar" -Dsbst.benchmark.pitest="$REPO_HOME_PATH/CovarageTool/pitest-1.1.11.jar:$REPO_HOME_PATH/CovarageTool/pitest-command-line-1.1.11.jar" -jar "$REPO_HOME_PATH/CovarageTool/benchmarktool-1.0.0-shaded.jar" EVOSUITE $BENCHMARK $RESULTS_PATH/$dt/DUBBO 1 $searchBudget --only-compute-metrics $RESULTS_PATH/$dt/DUBBO/$BENCHMARK/test
	done
fi

#Fastjson
if [[ " ${input_array[@]} " =~ " 5 " ]] || [[ " ${input_array[@]} " =~ " 1 " ]]; then
	mkdir $RESULTS_PATH/$dt/FASTJSON
	cp -f $REPO_HOME_PATH/CovarageTool/runtool $RESULTS_PATH/$dt/FASTJSON
	for BENCHMARK in FASTJSON-1 FASTJSON-2 FASTJSON-3 FASTJSON-4 FASTJSON-5 FASTJSON-6 FASTJSON-7 FASTJSON-8 FASTJSON-9 FASTJSON-10
	do
		echo "[EVOSUITE LAUNCHER] Run benchmark FASTJSON -- Target class: $BENCHMARK"
		mkdir -p $RESULTS_PATH/$dt/FASTJSON/$BENCHMARK/test
		inputClass=$(awk -v pat="${BENCHMARK/-/_} " '$0~pat{print $NF}' RunFiles/RunFastjson.java | sed 's/\"//g;s/;//g;s/\//./g')
		java -Xmx4G -jar $EVOSUITE_PATH -class $inputClass -mem 2048 -DCP=$REPO_HOME_PATH/fastjson/target/classes -Dassertions=false -Dreport_dir=$RESULTS_PATH/$dt/FASTJSON/$BENCHMARK -Dsearch_budget=$searchBudget -Dtest_dir=$RESULTS_PATH/$dt/FASTJSON/$BENCHMARK/test -Dvirtual_fs=false -Dcriterion=BRANCH -Dinline=false -Djunit_suffix=_Test -Dno_runtime_dependency |& tee $RESULTS_PATH/$dt/FASTJSON/$BENCHMARK/evosuiteLog$BENCHMARK.txt
		java -ea -Dsbst.benchmark.jacoco="$REPO_HOME_PATH/CovarageTool/jacocoagent.jar" -Dsbst.benchmark.java="java" -Dsbst.benchmark.javac="javac" -Dsbst.benchmark.config="$REPO_HOME_PATH/CovarageTool/benchmarksRepoPath.list" -Dsbst.benchmark.junit="$REPO_HOME_PATH/CovarageTool/junit-4.12.jar" -Dsbst.benchmark.junit.dependency="$REPO_HOME_PATH/CovarageTool/hamcrest-core-1.3.jar" -Dsbst.benchmark.pitest="$REPO_HOME_PATH/CovarageTool/pitest-1.1.11.jar:$REPO_HOME_PATH/CovarageTool/pitest-command-line-1.1.11.jar" -jar "$REPO_HOME_PATH/CovarageTool/benchmarktool-1.0.0-shaded.jar" EVOSUITE $BENCHMARK $RESULTS_PATH/$dt/FASTJSON 1 $searchBudget --only-compute-metrics $RESULTS_PATH/$dt/FASTJSON/$BENCHMARK/test
	done
fi

#Fescar
if [[ " ${input_array[@]} " =~ " 6 " ]] || [[ " ${input_array[@]} " =~ " 1 " ]]; then
	mkdir $RESULTS_PATH/$dt/FESCAR
	cp -f $REPO_HOME_PATH/CovarageTool/runtool $RESULTS_PATH/$dt/FESCAR
	for BENCHMARK in FESCAR-1 FESCAR-12 FESCAR-18 FESCAR-23 FESCAR-25 FESCAR-36 FESCAR-37 FESCAR-41 FESCAR-42 FESCAR-7 FESCAR-2 FESCAR-5 FESCAR-6 FESCAR-8 FESCAR-9 FESCAR-10 FESCAR-13 FESCAR-15 FESCAR-17 FESCAR-28 FESCAR-32 FESCAR-33 FESCAR-34
	do
		echo "[EVOSUITE LAUNCHER] Run benchmark FESCAR -- Target class: $BENCHMARK"
		mkdir -p $RESULTS_PATH/$dt/FESCAR/$BENCHMARK/test
		inputClass=$(awk -v pat="${BENCHMARK/-/_} " '$0~pat{print $NF}' RunFiles/RunFescar.java | sed 's/\"//g;s/;//g;s/\//./g')
		java -Xmx4G -jar $EVOSUITE_PATH -class $inputClass -mem 2048 -DCP=$REPO_HOME_PATH/fescar/core/target/classes:$REPO_HOME_PATH/fescar/common/target/classes:$REPO_HOME_PATH/fescar/config/target/classes:$REPO_HOME_PATH/fescar/dependencies/config-1.2.1.jar:$REPO_HOME_PATH/fescar/dependencies/slf4j-api-1.7.22.jar:$REPO_HOME_PATH/fescar/dependencies/logback-classic-1.1.6.jar:$REPO_HOME_PATH/fescar/dependencies/netty-transport-native-unix-common-4.1.24.Final.jar:$REPO_HOME_PATH/fescar/dependencies/netty-resolver-4.1.24.Final.jar:$REPO_HOME_PATH/fescar/dependencies/junit-4.12.jar:$REPO_HOME_PATH/fescar/dependencies/commons-pool-1.6.jar:$REPO_HOME_PATH/fescar/dependencies/netty-buffer-4.1.24.Final.jar:$REPO_HOME_PATH/fescar/dependencies/netty-transport-native-epoll-4.1.24.Final-linux-x86_64.jar:$REPO_HOME_PATH/fescar/dependencies/netty-all-4.1.24.Final.jar:$REPO_HOME_PATH/fescar/dependencies/hamcrest-core-1.3.jar:$REPO_HOME_PATH/fescar/dependencies/fescar-config-0.1.0-SNAPSHOT.jar:$REPO_HOME_PATH/fescar/dependencies/logback-core-1.1.6.jar:$REPO_HOME_PATH/fescar/dependencies/commons-lang-2.6.jar:$REPO_HOME_PATH/fescar/dependencies/fescar-common-0.1.0-SNAPSHOT.jar:$REPO_HOME_PATH/fescar/dependencies/fastjson-1.2.48.jar:$REPO_HOME_PATH/fescar/dependencies/netty-common-4.1.24.Final.jar:$REPO_HOME_PATH/fescar/dependencies/netty-transport-4.1.24.Final.jar:$REPO_HOME_PATH/fescar/dependencies/commons-pool2-2.4.2.jar:$REPO_HOME_PATH/fescar/dependencies/netty-transport-native-kqueue-4.1.24.Final-osx-x86_64.jar -Dassertions=false -Dreport_dir=$RESULTS_PATH/$dt/FESCAR/$BENCHMARK -Dsearch_budget=$searchBudget -Dtest_dir=$RESULTS_PATH/$dt/FESCAR/$BENCHMARK/test -Dvirtual_fs=false -Dcriterion=BRANCH -Dinline=false -Djunit_suffix=_Test -Dno_runtime_dependency |& tee $RESULTS_PATH/$dt/FESCAR/$BENCHMARK/evosuiteLog$BENCHMARK.txt
		java -ea -Dsbst.benchmark.jacoco="$REPO_HOME_PATH/CovarageTool/jacocoagent.jar" -Dsbst.benchmark.java="java" -Dsbst.benchmark.javac="javac" -Dsbst.benchmark.config="$REPO_HOME_PATH/CovarageTool/benchmarksRepoPath.list" -Dsbst.benchmark.junit="$REPO_HOME_PATH/CovarageTool/junit-4.12.jar" -Dsbst.benchmark.junit.dependency="$REPO_HOME_PATH/CovarageTool/hamcrest-core-1.3.jar" -Dsbst.benchmark.pitest="$REPO_HOME_PATH/CovarageTool/pitest-1.1.11.jar:$REPO_HOME_PATH/CovarageTool/pitest-command-line-1.1.11.jar" -jar "$REPO_HOME_PATH/CovarageTool/benchmarktool-1.0.0-shaded.jar" EVOSUITE $BENCHMARK $RESULTS_PATH/$dt/FESCAR 1 $searchBudget --only-compute-metrics $RESULTS_PATH/$dt/FESCAR/$BENCHMARK/test
	done
fi

#Gson
if [[ " ${input_array[@]} " =~ " 7 " ]] || [[ " ${input_array[@]} " =~ " 1 " ]]; then
	mkdir $RESULTS_PATH/$dt/GSON
	cp -f $REPO_HOME_PATH/CovarageTool/runtool $RESULTS_PATH/$dt/GSON
	for BENCHMARK in GSON-1 GSON-2 GSON-3 GSON-4 GSON-5 GSON-6 GSON-7 GSON-8 GSON-9 GSON-10
	do
		echo "[EVOSUITE LAUNCHER] Run benchmark GSON -- Target class: $BENCHMARK"
		mkdir -p $RESULTS_PATH/$dt/GSON/$BENCHMARK/test
		inputClass=$(awk -v pat="${BENCHMARK/-/_} " '$0~pat{print $NF}' RunFiles/RunGson.java | sed 's/\"//g;s/;//g;s/\//./g')
		java -Xmx4G -jar $EVOSUITE_PATH -class $inputClass -mem 2048 -DCP=$REPO_HOME_PATH/gson/gson/target/classes -Dassertions=false -Dreport_dir=$RESULTS_PATH/$dt/GSON/$BENCHMARK -Dsearch_budget=$searchBudget -Dtest_dir=$RESULTS_PATH/$dt/GSON/$BENCHMARK/test -Dvirtual_fs=false -Dcriterion=BRANCH -Dinline=false -Djunit_suffix=_Test -Dno_runtime_dependency |& tee $RESULTS_PATH/$dt/GSON/$BENCHMARK/evosuiteLog$BENCHMARK.txt
		java -ea -Dsbst.benchmark.jacoco="$REPO_HOME_PATH/CovarageTool/jacocoagent.jar" -Dsbst.benchmark.java="java" -Dsbst.benchmark.javac="javac" -Dsbst.benchmark.config="$REPO_HOME_PATH/CovarageTool/benchmarksRepoPath.list" -Dsbst.benchmark.junit="$REPO_HOME_PATH/CovarageTool/junit-4.12.jar" -Dsbst.benchmark.junit.dependency="$REPO_HOME_PATH/CovarageTool/hamcrest-core-1.3.jar" -Dsbst.benchmark.pitest="$REPO_HOME_PATH/CovarageTool/pitest-1.1.11.jar:$REPO_HOME_PATH/CovarageTool/pitest-command-line-1.1.11.jar" -jar "$REPO_HOME_PATH/CovarageTool/benchmarktool-1.0.0-shaded.jar" EVOSUITE $BENCHMARK $RESULTS_PATH/$dt/GSON 1 $searchBudget --only-compute-metrics $RESULTS_PATH/$dt/GSON/$BENCHMARK/test
	done
fi

#Guava
if [[ " ${input_array[@]} " =~ " 8 " ]] || [[ " ${input_array[@]} " =~ " 1 " ]]; then
	mkdir $RESULTS_PATH/$dt/GUAVA
	cp -f $REPO_HOME_PATH/CovarageTool/runtool $RESULTS_PATH/$dt/GUAVA
	for BENCHMARK in GUAVA-2 GUAVA-22 GUAVA-39 GUAVA-47 GUAVA-90 GUAVA-95 GUAVA-102 GUAVA-110 GUAVA-128 GUAVA-129 GUAVA-159 GUAVA-169 GUAVA-177 GUAVA-181 GUAVA-184 GUAVA-196 GUAVA-206 GUAVA-212 GUAVA-224 GUAVA-240
	do
		echo "[EVOSUITE LAUNCHER] Run benchmark GUAVA -- Target class: $BENCHMARK"
		mkdir -p $RESULTS_PATH/$dt/GUAVA/$BENCHMARK/test
		inputClass=$(awk -v pat="${BENCHMARK/-/_} " '$0~pat{print $NF}' RunFiles/RunGuava.java | sed 's/\"//g;s/;//g;s/\//./g')
		java -Xmx4G -jar $EVOSUITE_PATH -class $inputClass -mem 2048 -DCP=$REPO_HOME_PATH/guava/guava/target/guava-28.2-jre.jar -Dassertions=false -Dreport_dir=$RESULTS_PATH/$dt/GUAVA/$BENCHMARK -Dsearch_budget=$searchBudget -Dtest_dir=$RESULTS_PATH/$dt/GUAVA/$BENCHMARK/test -Dvirtual_fs=false -Dcriterion=BRANCH -Dinline=false -Djunit_suffix=_Test -Dno_runtime_dependency |& tee $RESULTS_PATH/$dt/GUAVA/$BENCHMARK/evosuiteLog$BENCHMARK.txt
		java -ea -Dsbst.benchmark.jacoco="$REPO_HOME_PATH/CovarageTool/jacocoagent.jar" -Dsbst.benchmark.java="java" -Dsbst.benchmark.javac="javac" -Dsbst.benchmark.config="$REPO_HOME_PATH/CovarageTool/benchmarksRepoPath.list" -Dsbst.benchmark.junit="$REPO_HOME_PATH/CovarageTool/junit-4.12.jar" -Dsbst.benchmark.junit.dependency="$REPO_HOME_PATH/CovarageTool/hamcrest-core-1.3.jar" -Dsbst.benchmark.pitest="$REPO_HOME_PATH/CovarageTool/pitest-1.1.11.jar:$REPO_HOME_PATH/CovarageTool/pitest-command-line-1.1.11.jar" -jar "$REPO_HOME_PATH/CovarageTool/benchmarktool-1.0.0-shaded.jar" EVOSUITE $BENCHMARK $RESULTS_PATH/$dt/GUAVA 1 $searchBudget --only-compute-metrics $RESULTS_PATH/$dt/GUAVA/$BENCHMARK/test
	done
fi

#Image
if [[ " ${input_array[@]} " =~ " 9 " ]] || [[ " ${input_array[@]} " =~ " 1 " ]]; then
	mkdir $RESULTS_PATH/$dt/IMAGE
	cp -f $REPO_HOME_PATH/CovarageTool/runtool $RESULTS_PATH/$dt/IMAGE
	for BENCHMARK in IMAGE-1 IMAGE-2 IMAGE-3 IMAGE-4
	do
		echo "[EVOSUITE LAUNCHER] Run benchmark IMAGE -- Target class: $BENCHMARK"
		mkdir -p $RESULTS_PATH/$dt/IMAGE/$BENCHMARK/test
		inputClass=$(awk -v pat="${BENCHMARK/-/_} " '$0~pat{print $NF}' RunFiles/RunImage.java | sed 's/\"//g;s/;//g;s/\//./g')
		java -Xmx4G -jar $EVOSUITE_PATH -class $inputClass -mem 2048 -DCP=$REPO_HOME_PATH/commons-imaging/target/classes -Dassertions=false -Dreport_dir=$RESULTS_PATH/$dt/IMAGE/$BENCHMARK -Dsearch_budget=$searchBudget -Dtest_dir=$RESULTS_PATH/$dt/IMAGE/$BENCHMARK/test -Dvirtual_fs=false -Dcriterion=BRANCH -Dinline=false -Djunit_suffix=_Test -Dno_runtime_dependency |& tee $RESULTS_PATH/$dt/IMAGE/$BENCHMARK/evosuiteLog$BENCHMARK.txt
		java -ea -Dsbst.benchmark.jacoco="$REPO_HOME_PATH/CovarageTool/jacocoagent.jar" -Dsbst.benchmark.java="java" -Dsbst.benchmark.javac="javac" -Dsbst.benchmark.config="$REPO_HOME_PATH/CovarageTool/benchmarksRepoPath.list" -Dsbst.benchmark.junit="$REPO_HOME_PATH/CovarageTool/junit-4.12.jar" -Dsbst.benchmark.junit.dependency="$REPO_HOME_PATH/CovarageTool/hamcrest-core-1.3.jar" -Dsbst.benchmark.pitest="$REPO_HOME_PATH/CovarageTool/pitest-1.1.11.jar:$REPO_HOME_PATH/CovarageTool/pitest-command-line-1.1.11.jar" -jar "$REPO_HOME_PATH/CovarageTool/benchmarktool-1.0.0-shaded.jar" EVOSUITE $BENCHMARK $RESULTS_PATH/$dt/IMAGE 1 $searchBudget --only-compute-metrics $RESULTS_PATH/$dt/IMAGE/$BENCHMARK/test
	done
fi

#Jsoup
if [[ " ${input_array[@]} " =~ " 10 " ]] || [[ " ${input_array[@]} " =~ " 1 " ]]; then
	mkdir $RESULTS_PATH/$dt/JSOUP
	cp -f $REPO_HOME_PATH/CovarageTool/runtool $RESULTS_PATH/$dt/JSOUP
	for BENCHMARK in JSOUP-1 JSOUP-2 JSOUP-3 JSOUP-4 JSOUP-5
	do
		echo "[EVOSUITE LAUNCHER] Run benchmark JSOUP -- Target class: $BENCHMARK"
		mkdir -p $RESULTS_PATH/$dt/JSOUP/$BENCHMARK/test
		inputClass=$(awk -v pat="${BENCHMARK/-/_} " '$0~pat{print $NF}' RunFiles/RunJsoup.java | sed 's/\"//g;s/;//g;s/\//./g')
		java -Xmx4G -jar $EVOSUITE_PATH -class $inputClass -mem 2048 -DCP=$REPO_HOME_PATH/jsoup/target/classes -Dassertions=false -Dreport_dir=$RESULTS_PATH/$dt/JSOUP/$BENCHMARK -Dsearch_budget=$searchBudget -Dtest_dir=$RESULTS_PATH/$dt/JSOUP/$BENCHMARK/test -Dvirtual_fs=false -Dcriterion=BRANCH -Dinline=false -Djunit_suffix=_Test -Dno_runtime_dependency |& tee $RESULTS_PATH/$dt/JSOUP/$BENCHMARK/evosuiteLog$BENCHMARK.txt
		java -ea -Dsbst.benchmark.jacoco="$REPO_HOME_PATH/CovarageTool/jacocoagent.jar" -Dsbst.benchmark.java="java" -Dsbst.benchmark.javac="javac" -Dsbst.benchmark.config="$REPO_HOME_PATH/CovarageTool/benchmarksRepoPath.list" -Dsbst.benchmark.junit="$REPO_HOME_PATH/CovarageTool/junit-4.12.jar" -Dsbst.benchmark.junit.dependency="$REPO_HOME_PATH/CovarageTool/hamcrest-core-1.3.jar" -Dsbst.benchmark.pitest="$REPO_HOME_PATH/CovarageTool/pitest-1.1.11.jar:$REPO_HOME_PATH/CovarageTool/pitest-command-line-1.1.11.jar" -jar "$REPO_HOME_PATH/CovarageTool/benchmarktool-1.0.0-shaded.jar" EVOSUITE $BENCHMARK $RESULTS_PATH/$dt/JSOUP 1 $searchBudget --only-compute-metrics $RESULTS_PATH/$dt/JSOUP/$BENCHMARK/test
	done
fi

#Jxpath
if [[ " ${input_array[@]} " =~ " 11 " ]] || [[ " ${input_array[@]} " =~ " 1 " ]]; then
	mkdir $RESULTS_PATH/$dt/JXPATH
	cp -f $REPO_HOME_PATH/CovarageTool/runtool $RESULTS_PATH/$dt/JXPATH
	for BENCHMARK in JXPATH-1 JXPATH-2 JXPATH-3 JXPATH-4 JXPATH-5 JXPATH-6 JXPATH-7 JXPATH-8 JXPATH-9 JXPATH-10
	do
		echo "[EVOSUITE LAUNCHER] Run benchmark JXPATH -- Target class: $BENCHMARK"
		mkdir -p $RESULTS_PATH/$dt/JXPATH/$BENCHMARK/test
		inputClass=$(awk -v pat="${BENCHMARK/-/_} " '$0~pat{print $NF}' RunFiles/RunJxpath.java | sed 's/\"//g;s/;//g;s/\//./g')
		java -Xmx4G -jar $EVOSUITE_PATH -class $inputClass -mem 2048 -DCP=$REPO_HOME_PATH/commons-jxpath-1.3-src/target/classes -Dassertions=false -Dreport_dir=$RESULTS_PATH/$dt/JXPATH/$BENCHMARK -Dsearch_budget=$searchBudget -Dtest_dir=$RESULTS_PATH/$dt/JXPATH/$BENCHMARK/test -Dvirtual_fs=false -Dcriterion=BRANCH -Dinline=false -Djunit_suffix=_Test -Dno_runtime_dependency |& tee $RESULTS_PATH/$dt/JXPATH/$BENCHMARK/evosuiteLog$BENCHMARK.txt
		java -ea -Dsbst.benchmark.jacoco="$REPO_HOME_PATH/CovarageTool/jacocoagent.jar" -Dsbst.benchmark.java="java" -Dsbst.benchmark.javac="javac" -Dsbst.benchmark.config="$REPO_HOME_PATH/CovarageTool/benchmarksRepoPath.list" -Dsbst.benchmark.junit="$REPO_HOME_PATH/CovarageTool/junit-4.12.jar" -Dsbst.benchmark.junit.dependency="$REPO_HOME_PATH/CovarageTool/hamcrest-core-1.3.jar" -Dsbst.benchmark.pitest="$REPO_HOME_PATH/CovarageTool/pitest-1.1.11.jar:$REPO_HOME_PATH/CovarageTool/pitest-command-line-1.1.11.jar" -jar "$REPO_HOME_PATH/CovarageTool/benchmarktool-1.0.0-shaded.jar" EVOSUITE $BENCHMARK $RESULTS_PATH/$dt/JXPATH 1 $searchBudget --only-compute-metrics $RESULTS_PATH/$dt/JXPATH/$BENCHMARK/test
	done
fi

#La4j
if [[ " ${input_array[@]} " =~ " 12 " ]] || [[ " ${input_array[@]} " =~ " 1 " ]]; then
	mkdir $RESULTS_PATH/$dt/LA4J
	cp -f $REPO_HOME_PATH/CovarageTool/runtool $RESULTS_PATH/$dt/LA4J
	for BENCHMARK in LA4J-1 LA4J-2 LA4J-3 LA4J-4 LA4J-5 LA4J-6 LA4J-7 LA4J-8 LA4J-9 LA4J-10
	do
		echo "[EVOSUITE LAUNCHER] Run benchmark LA4J -- Target class: $BENCHMARK"
		mkdir -p $RESULTS_PATH/$dt/LA4J/$BENCHMARK/test
		inputClass=$(awk -v pat="${BENCHMARK/-/_} " '$0~pat{print $NF}' RunFiles/RunLa4j.java | sed 's/\"//g;s/;//g;s/\//./g')
		java -Xmx4G -jar $EVOSUITE_PATH -class $inputClass -mem 2048 -DCP=$REPO_HOME_PATH/la4j-0.6.0/target/classes -Dassertions=false -Dreport_dir=$RESULTS_PATH/$dt/LA4J/$BENCHMARK -Dsearch_budget=$searchBudget -Dtest_dir=$RESULTS_PATH/$dt/LA4J/$BENCHMARK/test -Dvirtual_fs=false -Dcriterion=BRANCH -Dinline=false -Djunit_suffix=_Test -Dno_runtime_dependency |& tee $RESULTS_PATH/$dt/LA4J/$BENCHMARK/evosuiteLog$BENCHMARK.txt
		java -ea -Dsbst.benchmark.jacoco="$REPO_HOME_PATH/CovarageTool/jacocoagent.jar" -Dsbst.benchmark.java="java" -Dsbst.benchmark.javac="javac" -Dsbst.benchmark.config="$REPO_HOME_PATH/CovarageTool/benchmarksRepoPath.list" -Dsbst.benchmark.junit="$REPO_HOME_PATH/CovarageTool/junit-4.12.jar" -Dsbst.benchmark.junit.dependency="$REPO_HOME_PATH/CovarageTool/hamcrest-core-1.3.jar" -Dsbst.benchmark.pitest="$REPO_HOME_PATH/CovarageTool/pitest-1.1.11.jar:$REPO_HOME_PATH/CovarageTool/pitest-command-line-1.1.11.jar" -jar "$REPO_HOME_PATH/CovarageTool/benchmarktool-1.0.0-shaded.jar" EVOSUITE $BENCHMARK $RESULTS_PATH/$dt/LA4J 1 $searchBudget --only-compute-metrics $RESULTS_PATH/$dt/LA4J/$BENCHMARK/test
	done
fi

#Okhttp
if [[ " ${input_array[@]} " =~ " 13 " ]] || [[ " ${input_array[@]} " =~ " 1 " ]]; then
	mkdir $RESULTS_PATH/$dt/OKHTTP
	cp -f $REPO_HOME_PATH/CovarageTool/runtool $RESULTS_PATH/$dt/OKHTTP
	for BENCHMARK in OKHTTP-1 OKHTTP-2 OKHTTP-3 OKHTTP-4 OKHTTP-5 OKHTTP-6 OKHTTP-7 OKHTTP-8
	do
		echo "[EVOSUITE LAUNCHER] Run benchmark OKHTTP -- Target class: $BENCHMARK"
		mkdir -p $RESULTS_PATH/$dt/OKHTTP/$BENCHMARK/test
		inputClass=$(awk -v pat="${BENCHMARK/-/_} " '$0~pat{print $NF}' RunFiles/RunOkhttp.java | sed 's/\"//g;s/;//g;s/\//./g')
		java -Xmx4G -jar $EVOSUITE_PATH -class $inputClass -mem 2048 -DCP=$REPO_HOME_PATH/okhttp/okhttp/target/classes:$REPO_HOME_PATH/okhttp/dependencies/okio-1.11.0.jar -Dassertions=false -Dreport_dir=$RESULTS_PATH/$dt/OKHTTP/$BENCHMARK -Dsearch_budget=$searchBudget -Dtest_dir=$RESULTS_PATH/$dt/OKHTTP/$BENCHMARK/test -Dvirtual_fs=false -Dcriterion=BRANCH -Dinline=false -Djunit_suffix=_Test -Dno_runtime_dependency |& tee $RESULTS_PATH/$dt/OKHTTP/$BENCHMARK/evosuiteLog$BENCHMARK.txt
		java -ea -Dsbst.benchmark.jacoco="$REPO_HOME_PATH/CovarageTool/jacocoagent.jar" -Dsbst.benchmark.java="java" -Dsbst.benchmark.javac="javac" -Dsbst.benchmark.config="$REPO_HOME_PATH/CovarageTool/benchmarksRepoPath.list" -Dsbst.benchmark.junit="$REPO_HOME_PATH/CovarageTool/junit-4.12.jar" -Dsbst.benchmark.junit.dependency="$REPO_HOME_PATH/CovarageTool/hamcrest-core-1.3.jar" -Dsbst.benchmark.pitest="$REPO_HOME_PATH/CovarageTool/pitest-1.1.11.jar:$REPO_HOME_PATH/CovarageTool/pitest-command-line-1.1.11.jar" -jar "$REPO_HOME_PATH/CovarageTool/benchmarktool-1.0.0-shaded.jar" EVOSUITE $BENCHMARK $RESULTS_PATH/$dt/OKHTTP 1 $searchBudget --only-compute-metrics $RESULTS_PATH/$dt/OKHTTP/$BENCHMARK/test
	done
fi

#Okio
if [[ " ${input_array[@]} " =~ " 14 " ]] || [[ " ${input_array[@]} " =~ " 1 " ]]; then
	mkdir $RESULTS_PATH/$dt/OKIO
	cp -f $REPO_HOME_PATH/CovarageTool/runtool $RESULTS_PATH/$dt/OKIO
	for BENCHMARK in OKIO-1 OKIO-2 OKIO-3 OKIO-4 OKIO-5 OKIO-6 OKIO-7 OKIO-8 OKIO-9 OKIO-10
	do
		echo "[EVOSUITE LAUNCHER] Run benchmark OKIO -- Target class: $BENCHMARK"
		mkdir -p $RESULTS_PATH/$dt/OKIO/$BENCHMARK/test
		inputClass=$(awk -v pat="${BENCHMARK/-/_} " '$0~pat{print $NF}' RunFiles/RunOkio.java | sed 's/\"//g;s/;//g;s/\//./g')
		java -Xmx4G -jar $EVOSUITE_PATH -class $inputClass -mem 2048 -DCP=$REPO_HOME_PATH/okio/okio/target/classes:$REPO_HOME_PATH/okio/samples/target/classes -Dassertions=false -Dreport_dir=$RESULTS_PATH/$dt/OKIO/$BENCHMARK -Dsearch_budget=$searchBudget -Dtest_dir=$RESULTS_PATH/$dt/OKIO/$BENCHMARK/test -Dvirtual_fs=false -Dcriterion=BRANCH -Dinline=false -Djunit_suffix=_Test -Dno_runtime_dependency |& tee $RESULTS_PATH/$dt/OKIO/$BENCHMARK/evosuiteLog$BENCHMARK.txt
		java -ea -Dsbst.benchmark.jacoco="$REPO_HOME_PATH/CovarageTool/jacocoagent.jar" -Dsbst.benchmark.java="java" -Dsbst.benchmark.javac="javac" -Dsbst.benchmark.config="$REPO_HOME_PATH/CovarageTool/benchmarksRepoPath.list" -Dsbst.benchmark.junit="$REPO_HOME_PATH/CovarageTool/junit-4.12.jar" -Dsbst.benchmark.junit.dependency="$REPO_HOME_PATH/CovarageTool/hamcrest-core-1.3.jar" -Dsbst.benchmark.pitest="$REPO_HOME_PATH/CovarageTool/pitest-1.1.11.jar:$REPO_HOME_PATH/CovarageTool/pitest-command-line-1.1.11.jar" -jar "$REPO_HOME_PATH/CovarageTool/benchmarktool-1.0.0-shaded.jar" EVOSUITE $BENCHMARK $RESULTS_PATH/$dt/OKIO 1 $searchBudget --only-compute-metrics $RESULTS_PATH/$dt/OKIO/$BENCHMARK/test
	done
fi

#Pdfbox
if [[ " ${input_array[@]} " =~ " 15 " ]] || [[ " ${input_array[@]} " =~ " 1 " ]]; then
	mkdir $RESULTS_PATH/$dt/PDFBOX
	cp -f $REPO_HOME_PATH/CovarageTool/runtool $RESULTS_PATH/$dt/PDFBOX
	for BENCHMARK in PDFBOX-8 PDFBOX-22 PDFBOX-26 PDFBOX-40 PDFBOX-62 PDFBOX-83 PDFBOX-91 PDFBOX-117 PDFBOX-127 PDFBOX-130 PDFBOX-157 PDFBOX-198 PDFBOX-214 PDFBOX-220 PDFBOX-229 PDFBOX-234 PDFBOX-235 PDFBOX-265 PDFBOX-278 PDFBOX-285
	do
		echo "[EVOSUITE LAUNCHER] Run benchmark PDFBOX -- Target class: $BENCHMARK"
		mkdir -p $RESULTS_PATH/$dt/PDFBOX/$BENCHMARK/test
		inputClass=$(awk -v pat="${BENCHMARK/-/_} " '$0~pat{print $NF}' RunFiles/RunPdfbox.java | sed 's/\"//g;s/;//g;s/\//./g')
		java -Xmx4G -jar $EVOSUITE_PATH -class $inputClass -mem 2048 -DCP=$REPO_HOME_PATH/pdfbox/pdfbox/target/pdfbox-2.0.18.jar:$REPO_HOME_PATH/pdfbox/dependencies/bcpkix-jdk15on-1.60.jar:$REPO_HOME_PATH/pdfbox/dependencies/bcprov-jdk15on-1.60.jar:$REPO_HOME_PATH/pdfbox/dependencies/diffutils-1.3.0.jar:$REPO_HOME_PATH/pdfbox/dependencies/hamcrest-core-1.3.jar:$REPO_HOME_PATH/pdfbox/dependencies/jbig2-imageio-3.0.3.jar:$REPO_HOME_PATH/pdfbox/dependencies/jai-imageio-core-1.4.0.jar:$REPO_HOME_PATH/pdfbox/dependencies/jai-imageio-jpeg2000-1.3.0.jar:$REPO_HOME_PATH/pdfbox/dependencies/junit-4.12.jar:$REPO_HOME_PATH/pdfbox/dependencies/fontbox-2.0.18.jar:$REPO_HOME_PATH/pdfbox/dependencies/bcmail-jdk15on-1.60.jar:$REPO_HOME_PATH/pdfbox/dependencies/commons-logging-1.2.jar -Dassertions=false -Dreport_dir=$RESULTS_PATH/$dt/PDFBOX/$BENCHMARK -Dsearch_budget=$searchBudget -Dtest_dir=$RESULTS_PATH/$dt/PDFBOX/$BENCHMARK/test -Dvirtual_fs=false -Dcriterion=BRANCH -Dinline=false -Djunit_suffix=_Test -Dno_runtime_dependency |& tee $RESULTS_PATH/$dt/PDFBOX/$BENCHMARK/evosuiteLog$BENCHMARK.txt
		java -ea -Dsbst.benchmark.jacoco="$REPO_HOME_PATH/CovarageTool/jacocoagent.jar" -Dsbst.benchmark.java="java" -Dsbst.benchmark.javac="javac" -Dsbst.benchmark.config="$REPO_HOME_PATH/CovarageTool/benchmarksRepoPath.list" -Dsbst.benchmark.junit="$REPO_HOME_PATH/CovarageTool/junit-4.12.jar" -Dsbst.benchmark.junit.dependency="$REPO_HOME_PATH/CovarageTool/hamcrest-core-1.3.jar" -Dsbst.benchmark.pitest="$REPO_HOME_PATH/CovarageTool/pitest-1.1.11.jar:$REPO_HOME_PATH/CovarageTool/pitest-command-line-1.1.11.jar" -jar "$REPO_HOME_PATH/CovarageTool/benchmarktool-1.0.0-shaded.jar" EVOSUITE $BENCHMARK $RESULTS_PATH/$dt/PDFBOX 1 $searchBudget --only-compute-metrics $RESULTS_PATH/$dt/PDFBOX/$BENCHMARK/test
	done
fi

#Re2j
if [[ " ${input_array[@]} " =~ " 16 " ]] || [[ " ${input_array[@]} " =~ " 1 " ]]; then
	mkdir $RESULTS_PATH/$dt/RE2J
	cp -f $REPO_HOME_PATH/CovarageTool/runtool $RESULTS_PATH/$dt/RE2J
	for BENCHMARK in RE2J-1 RE2J-2 RE2J-3 RE2J-4 RE2J-5 RE2J-6 RE2J-7 RE2J-8
	do
		echo "[EVOSUITE LAUNCHER] Run benchmark RE2J -- Target class: $BENCHMARK"
		mkdir -p $RESULTS_PATH/$dt/RE2J/$BENCHMARK/test
		inputClass=$(awk -v pat="${BENCHMARK/-/_} " '$0~pat{print $NF}' RunFiles/RunRe2j.java | sed 's/\"//g;s/;//g;s/\//./g')
		java -Xmx4G -jar $EVOSUITE_PATH -class $inputClass -mem 2048 -DCP=$REPO_HOME_PATH/re2j/target/classes -Dassertions=false -Dreport_dir=$RESULTS_PATH/$dt/RE2J/$BENCHMARK -Dsearch_budget=$searchBudget -Dtest_dir=$RESULTS_PATH/$dt/RE2J/$BENCHMARK/test -Dvirtual_fs=false -Dcriterion=BRANCH -Dinline=false -Djunit_suffix=_Test -Dno_runtime_dependency |& tee $RESULTS_PATH/$dt/RE2J/$BENCHMARK/evosuiteLog$BENCHMARK.txt
		java -ea -Dsbst.benchmark.jacoco="$REPO_HOME_PATH/CovarageTool/jacocoagent.jar" -Dsbst.benchmark.java="java" -Dsbst.benchmark.javac="javac" -Dsbst.benchmark.config="$REPO_HOME_PATH/CovarageTool/benchmarksRepoPath.list" -Dsbst.benchmark.junit="$REPO_HOME_PATH/CovarageTool/junit-4.12.jar" -Dsbst.benchmark.junit.dependency="$REPO_HOME_PATH/CovarageTool/hamcrest-core-1.3.jar" -Dsbst.benchmark.pitest="$REPO_HOME_PATH/CovarageTool/pitest-1.1.11.jar:$REPO_HOME_PATH/CovarageTool/pitest-command-line-1.1.11.jar" -jar "$REPO_HOME_PATH/CovarageTool/benchmarktool-1.0.0-shaded.jar" EVOSUITE $BENCHMARK $RESULTS_PATH/$dt/RE2J 1 $searchBudget --only-compute-metrics $RESULTS_PATH/$dt/RE2J/$BENCHMARK/test
	done
fi

#Spoon
if [[ " ${input_array[@]} " =~ " 17 " ]] || [[ " ${input_array[@]} " =~ " 1 " ]]; then
	mkdir $RESULTS_PATH/$dt/SPOON
	cp -f $REPO_HOME_PATH/CovarageTool/runtool $RESULTS_PATH/$dt/SPOON
	for BENCHMARK in SPOON-105 SPOON-155 SPOON-16 SPOON-169 SPOON-20 SPOON-211 SPOON-25 SPOON-253 SPOON-32 SPOON-65
	do
		echo "[EVOSUITE LAUNCHER] Run benchmark SPOON -- Target class: $BENCHMARK"
		mkdir -p $RESULTS_PATH/$dt/SPOON/$BENCHMARK/test
		inputClass=$(awk -v pat="${BENCHMARK/-/_} " '$0~pat{print $NF}' RunFiles/RunSpoon.java | sed 's/\"//g;s/;//g;s/\//./g')
		java -Xmx4G -jar $EVOSUITE_PATH -class $inputClass -mem 2048 -DCP=$REPO_HOME_PATH/spoon/target/spoon-core-7.2.0.jar:$REPO_HOME_PATH/spoon/dependencies/org.eclipse.core.commands-3.9.200.jar:$REPO_HOME_PATH/spoon/dependencies/org.eclipse.core.runtime-3.15.100.jar:$REPO_HOME_PATH/spoon/dependencies/plexus-utils-3.0.24.jar:$REPO_HOME_PATH/spoon/dependencies/junit-4.12.jar:$REPO_HOME_PATH/spoon/dependencies/mockito-all-2.0.2-beta.jar:$REPO_HOME_PATH/spoon/dependencies/jsap-2.1.jar:$REPO_HOME_PATH/spoon/dependencies/guava-18.0.jar:$REPO_HOME_PATH/spoon/dependencies/system-rules-1.9.0.jar:$REPO_HOME_PATH/spoon/dependencies/org.eclipse.core.expressions-3.6.200.jar:$REPO_HOME_PATH/spoon/dependencies/log4j-1.2.17.jar:$REPO_HOME_PATH/spoon/dependencies/org.eclipse.osgi-3.13.200.jar:$REPO_HOME_PATH/spoon/dependencies/jackson-annotations-2.9.0.jar:$REPO_HOME_PATH/spoon/dependencies/org.eclipse.core.resources-3.13.200.jar:$REPO_HOME_PATH/spoon/dependencies/plexus-component-annotations-1.7.1.jar:$REPO_HOME_PATH/spoon/dependencies/org.eclipse.equinox.registry-3.8.200.jar:$REPO_HOME_PATH/spoon/dependencies/org.eclipse.equinox.app-1.4.0.jar:$REPO_HOME_PATH/spoon/dependencies/commons-io-2.5.jar:$REPO_HOME_PATH/spoon/dependencies/maven-invoker-3.0.1.jar:$REPO_HOME_PATH/spoon/dependencies/org.eclipse.core.contenttype-3.7.200.jar:$REPO_HOME_PATH/spoon/dependencies/org.eclipse.core.filesystem-1.7.200.jar:$REPO_HOME_PATH/spoon/dependencies/org.eclipse.core.jobs-3.10.200.jar:$REPO_HOME_PATH/spoon/dependencies/hamcrest-core-1.3.jar:$REPO_HOME_PATH/spoon/dependencies/org.eclipse.equinox.common-3.10.200.jar:$REPO_HOME_PATH/spoon/dependencies/commons-compress-1.18.jar:$REPO_HOME_PATH/spoon/dependencies/maven-shared-utils-3.2.1.jar:$REPO_HOME_PATH/spoon/dependencies/org.eclipse.text-3.8.0.jar:$REPO_HOME_PATH/spoon/dependencies/org.eclipse.jdt.core-3.15.0.jar:$REPO_HOME_PATH/spoon/dependencies/querydsl-core-3.6.9.jar:$REPO_HOME_PATH/spoon/dependencies/bridge-method-annotation-1.13.jar:$REPO_HOME_PATH/spoon/dependencies/org.eclipse.equinox.preferences-3.7.200.jar:$REPO_HOME_PATH/spoon/dependencies/jackson-core-2.9.5.jar:$REPO_HOME_PATH/spoon/dependencies/jackson-databind-2.9.5.jar:$REPO_HOME_PATH/spoon/dependencies/commons-lang3-3.5.jar:$REPO_HOME_PATH/spoon/dependencies/maven-model-3.5.0.jar:$REPO_HOME_PATH/spoon/dependencies/xz-1.8.jar -Dassertions=false -Dreport_dir=$RESULTS_PATH/$dt/SPOON/$BENCHMARK -Dsearch_budget=$searchBudget -Dtest_dir=$RESULTS_PATH/$dt/SPOON/$BENCHMARK/test -Dvirtual_fs=false -Dcriterion=BRANCH -Dinline=false -Djunit_suffix=_Test -Dno_runtime_dependency |& tee $RESULTS_PATH/$dt/SPOON/$BENCHMARK/evosuiteLog$BENCHMARK.txt
		java -ea -Dsbst.benchmark.jacoco="$REPO_HOME_PATH/CovarageTool/jacocoagent.jar" -Dsbst.benchmark.java="java" -Dsbst.benchmark.javac="javac" -Dsbst.benchmark.config="$REPO_HOME_PATH/CovarageTool/benchmarksRepoPath.list" -Dsbst.benchmark.junit="$REPO_HOME_PATH/CovarageTool/junit-4.12.jar" -Dsbst.benchmark.junit.dependency="$REPO_HOME_PATH/CovarageTool/hamcrest-core-1.3.jar" -Dsbst.benchmark.pitest="$REPO_HOME_PATH/CovarageTool/pitest-1.1.11.jar:$REPO_HOME_PATH/CovarageTool/pitest-command-line-1.1.11.jar" -jar "$REPO_HOME_PATH/CovarageTool/benchmarktool-1.0.0-shaded.jar" EVOSUITE $BENCHMARK $RESULTS_PATH/$dt/SPOON 1 $searchBudget --only-compute-metrics $RESULTS_PATH/$dt/SPOON/$BENCHMARK/test
	done
fi

#Webmagic
if [[ " ${input_array[@]} " =~ " 18 " ]] || [[ " ${input_array[@]} " =~ " 1 " ]]; then
	mkdir $RESULTS_PATH/$dt/WEBMAGIC
	cp -f $REPO_HOME_PATH/CovarageTool/runtool $RESULTS_PATH/$dt/WEBMAGIC
	for BENCHMARK in WEBMAGIC-1 WEBMAGIC-5
	do
		echo "[EVOSUITE LAUNCHER] Run benchmark WEBMAGIC -- Target class: $BENCHMARK"
		mkdir -p $RESULTS_PATH/$dt/WEBMAGIC/$BENCHMARK/test
		inputClass=$(awk -v pat="${BENCHMARK/-/_} " '$0~pat{print $NF}' RunFiles/RunWebmagic1_5.java | sed 's/\"//g;s/;//g;s/\//./g')
		java -Xmx4G -jar $EVOSUITE_PATH -class $inputClass -mem 2048 -DCP=$REPO_HOME_PATH/webmagic/webmagic-extension/target/classes:$REPO_HOME_PATH/webmagic/webmagic-core/target/classes:$REPO_HOME_PATH/webmagic/webmagic-samples/target/classes:$REPO_HOME_PATH/webmagic/webmagic-saxon/target/classes:$REPO_HOME_PATH/webmagic/webmagic-scripts/target/classes:$REPO_HOME_PATH/webmagic/webmagic-selenium/target/classes -Dassertions=false -Dreport_dir=$RESULTS_PATH/$dt/WEBMAGIC/$BENCHMARK -Dsearch_budget=$searchBudget -Dtest_dir=$RESULTS_PATH/$dt/WEBMAGIC/$BENCHMARK/test -Dvirtual_fs=false -Dcriterion=BRANCH -Dinline=false -Djunit_suffix=_Test -Dno_runtime_dependency |& tee $RESULTS_PATH/$dt/WEBMAGIC/$BENCHMARK/evosuiteLog$BENCHMARK.txt
		java -ea -Dsbst.benchmark.jacoco="$REPO_HOME_PATH/CovarageTool/jacocoagent.jar" -Dsbst.benchmark.java="java" -Dsbst.benchmark.javac="javac" -Dsbst.benchmark.config="$REPO_HOME_PATH/CovarageTool/benchmarksRepoPath.list" -Dsbst.benchmark.junit="$REPO_HOME_PATH/CovarageTool/junit-4.12.jar" -Dsbst.benchmark.junit.dependency="$REPO_HOME_PATH/CovarageTool/hamcrest-core-1.3.jar" -Dsbst.benchmark.pitest="$REPO_HOME_PATH/CovarageTool/pitest-1.1.11.jar:$REPO_HOME_PATH/CovarageTool/pitest-command-line-1.1.11.jar" -jar "$REPO_HOME_PATH/CovarageTool/benchmarktool-1.0.0-shaded.jar" EVOSUITE $BENCHMARK $RESULTS_PATH/$dt/WEBMAGIC 1 $searchBudget --only-compute-metrics $RESULTS_PATH/$dt/WEBMAGIC/$BENCHMARK/test
	done
	for BENCHMARK in WEBMAGIC-2 WEBMAGIC-3 WEBMAGIC-4
	do
		echo "[EVOSUITE LAUNCHER] Run benchmark WEBMAGIC -- Target class: $BENCHMARK"
		mkdir -p $RESULTS_PATH/$dt/WEBMAGIC/$BENCHMARK/test
		inputClass=$(awk -v pat="${BENCHMARK/-/_} " '$0~pat{print $NF}' RunFiles/RunWebmagic2_3_4.java | sed 's/\"//g;s/;//g;s/\//./g')
		java -Xmx4G -jar $EVOSUITE_PATH -class $inputClass -mem 2048 -DCP=$REPO_HOME_PATH/webmagic/webmagic-extension/target/classes:$REPO_HOME_PATH/webmagic/webmagic-core/target/classes:$REPO_HOME_PATH/webmagic/webmagic-samples/target/classes:$REPO_HOME_PATH/webmagic/webmagic-saxon/target/classes:$REPO_HOME_PATH/webmagic/webmagic-scripts/target/classes:$REPO_HOME_PATH/webmagic/webmagic-selenium/target/classes:$REPO_HOME_PATH/webmagic/dependencies/jsoup-1.10.3.jar -Dassertions=false -Dreport_dir=$RESULTS_PATH/$dt/WEBMAGIC/$BENCHMARK -Dsearch_budget=$searchBudget -Dtest_dir=$RESULTS_PATH/$dt/WEBMAGIC/$BENCHMARK/test -Dvirtual_fs=false -Dcriterion=BRANCH -Dinline=false -Djunit_suffix=_Test -Dno_runtime_dependency |& tee $RESULTS_PATH/$dt/WEBMAGIC/$BENCHMARK/evosuiteLog$BENCHMARK.txt
		java -ea -Dsbst.benchmark.jacoco="$REPO_HOME_PATH/CovarageTool/jacocoagent.jar" -Dsbst.benchmark.java="java" -Dsbst.benchmark.javac="javac" -Dsbst.benchmark.config="$REPO_HOME_PATH/CovarageTool/benchmarksRepoPath.list" -Dsbst.benchmark.junit="$REPO_HOME_PATH/CovarageTool/junit-4.12.jar" -Dsbst.benchmark.junit.dependency="$REPO_HOME_PATH/CovarageTool/hamcrest-core-1.3.jar" -Dsbst.benchmark.pitest="$REPO_HOME_PATH/CovarageTool/pitest-1.1.11.jar:$REPO_HOME_PATH/CovarageTool/pitest-command-line-1.1.11.jar" -jar "$REPO_HOME_PATH/CovarageTool/benchmarktool-1.0.0-shaded.jar" EVOSUITE $BENCHMARK $RESULTS_PATH/$dt/WEBMAGIC 1 $searchBudget --only-compute-metrics $RESULTS_PATH/$dt/WEBMAGIC/$BENCHMARK/test
	done
fi

#Zxing
if [[ " ${input_array[@]} " =~ " 19 " ]] || [[ " ${input_array[@]} " =~ " 1 " ]]; then
	mkdir $RESULTS_PATH/$dt/ZXING
	cp -f $REPO_HOME_PATH/CovarageTool/runtool $RESULTS_PATH/$dt/ZXING
	for BENCHMARK in ZXING-1 ZXING-2 ZXING-3 ZXING-4 ZXING-5 ZXING-6 ZXING-7 ZXING-8 ZXING-9 ZXING-10
	do
		echo "[EVOSUITE LAUNCHER] Run benchmark ZXING -- Target class: $BENCHMARK"
		mkdir -p $RESULTS_PATH/$dt/ZXING/$BENCHMARK/test
		inputClass=$(awk -v pat="${BENCHMARK/-/_} " '$0~pat{print $NF}' RunFiles/RunZxing.java | sed 's/\"//g;s/;//g;s/\//./g')
		java -Xmx4G -jar $EVOSUITE_PATH -class $inputClass -mem 2048 -DCP=$REPO_HOME_PATH/zxing/core/target/classes -Dassertions=false -Dreport_dir=$RESULTS_PATH/$dt/ZXING/$BENCHMARK -Dsearch_budget=$searchBudget -Dtest_dir=$RESULTS_PATH/$dt/ZXING/$BENCHMARK/test -Dvirtual_fs=false -Dcriterion=BRANCH -Dinline=false -Djunit_suffix=_Test -Dno_runtime_dependency |& tee $RESULTS_PATH/$dt/ZXING/$BENCHMARK/evosuiteLog$BENCHMARK.txt
		java -ea -Dsbst.benchmark.jacoco="$REPO_HOME_PATH/CovarageTool/jacocoagent.jar" -Dsbst.benchmark.java="java" -Dsbst.benchmark.javac="javac" -Dsbst.benchmark.config="$REPO_HOME_PATH/CovarageTool/benchmarksRepoPath.list" -Dsbst.benchmark.junit="$REPO_HOME_PATH/CovarageTool/junit-4.12.jar" -Dsbst.benchmark.junit.dependency="$REPO_HOME_PATH/CovarageTool/hamcrest-core-1.3.jar" -Dsbst.benchmark.pitest="$REPO_HOME_PATH/CovarageTool/pitest-1.1.11.jar:$REPO_HOME_PATH/CovarageTool/pitest-command-line-1.1.11.jar" -jar "$REPO_HOME_PATH/CovarageTool/benchmarktool-1.0.0-shaded.jar" EVOSUITE $BENCHMARK $RESULTS_PATH/$dt/ZXING 1 $searchBudget --only-compute-metrics $RESULTS_PATH/$dt/ZXING/$BENCHMARK/test
	done
fi

#Weka
if [[ " ${input_array[@]} " =~ " 20 " ]] || [[ " ${input_array[@]} " =~ " 1 " ]]; then
	mkdir $RESULTS_PATH/$dt/WEKA
	cp -f $REPO_HOME_PATH/CovarageTool/runtool $RESULTS_PATH/$dt/WEKA
	for BENCHMARK in WEKA-673 WEKA-460 WEKA-983 WEKA-741 WEKA-148 WEKA-53 WEKA-303 WEKA-1093 WEKA-1127 WEKA-128 WEKA-119 WEKA-302 WEKA-576 WEKA-631 WEKA-7 WEKA-592 WEKA-871 WEKA-79 WEKA-763 WEKA-1088 WEKA-1006 WEKA-563 WEKA-151 WEKA-143 WEKA-577
	do
		echo "[EVOSUITE LAUNCHER] Run benchmark WEKA -- Target class: $BENCHMARK"
		mkdir -p $RESULTS_PATH/$dt/WEKA/$BENCHMARK/test
		inputClass=$(awk -v pat="${BENCHMARK/-/_} " '$0~pat{print $NF}' RunFiles/RunWeka.java | sed 's/\"//g;s/;//g;s/\//./g')
		java -Xmx4G -jar $EVOSUITE_PATH -class $inputClass -mem 2048 -DCP=$REPO_HOME_PATH/weka/dist/weka-stable-3.8.5-SNAPSHOT.jar -Dassertions=false -Dreport_dir=$RESULTS_PATH/$dt/WEKA/$BENCHMARK -Dsearch_budget=$searchBudget -Dtest_dir=$RESULTS_PATH/$dt/WEKA/$BENCHMARK/test -Dvirtual_fs=false -Dcriterion=BRANCH -Dinline=false -Djunit_suffix=_Test -Dno_runtime_dependency |& tee $RESULTS_PATH/$dt/WEKA/$BENCHMARK/evosuiteLog$BENCHMARK.txt
		java -ea -Dsbst.benchmark.jacoco="$REPO_HOME_PATH/CovarageTool/jacocoagent.jar" -Dsbst.benchmark.java="java" -Dsbst.benchmark.javac="javac" -Dsbst.benchmark.config="$REPO_HOME_PATH/CovarageTool/benchmarksRepoPath.list" -Dsbst.benchmark.junit="$REPO_HOME_PATH/CovarageTool/junit-4.12.jar" -Dsbst.benchmark.junit.dependency="$REPO_HOME_PATH/CovarageTool/hamcrest-core-1.3.jar" -Dsbst.benchmark.pitest="$REPO_HOME_PATH/CovarageTool/pitest-1.1.11.jar:$REPO_HOME_PATH/CovarageTool/pitest-command-line-1.1.11.jar" -jar "$REPO_HOME_PATH/CovarageTool/benchmarktool-1.0.0-shaded.jar" EVOSUITE $BENCHMARK $RESULTS_PATH/$dt/WEKA 1 $searchBudget --only-compute-metrics $RESULTS_PATH/$dt/WEKA/$BENCHMARK/test
	done
fi

#Fastjson9th
if [[ " ${input_array[@]} " =~ " 21 " ]] || [[ " ${input_array[@]} " =~ " 1 " ]]; then
	mkdir $RESULTS_PATH/$dt/FASTJSON9TH
	cp -f $REPO_HOME_PATH/CovarageTool/runtool $RESULTS_PATH/$dt/FASTJSON9TH
	for BENCHMARK in FASTJSON-999 FASTJSON-11 FASTJSON-17 FASTJSON-29 FASTJSON-36 FASTJSON-45 FASTJSON-49 FASTJSON-57 FASTJSON-61 FASTJSON-65 FASTJSON-72 FASTJSON-78 FASTJSON-79 FASTJSON-86 FASTJSON-94 FASTJSON-99 FASTJSON-100 FASTJSON-108 FASTJSON-113 FASTJSON-120
	do
		echo "[EVOSUITE LAUNCHER] Run benchmark FASTJSON9TH -- Target class: $BENCHMARK"
		mkdir -p $RESULTS_PATH/$dt/FASTJSON9TH/$BENCHMARK/test
		inputClass=$(awk -v pat="${BENCHMARK/-/_} " '$0~pat{print $NF}' RunFiles/RunFastjson9th.java | sed 's/\"//g;s/;//g;s/\//./g')
		java -Xmx4G -jar $EVOSUITE_PATH -class $inputClass -mem 2048 -DCP=$REPO_HOME_PATH/fastjson9th/target/fastjson-1.2.63_preview_01.jar -Dassertions=false -Dreport_dir=$RESULTS_PATH/$dt/FASTJSON9TH/$BENCHMARK -Dsearch_budget=$searchBudget -Dtest_dir=$RESULTS_PATH/$dt/FASTJSON9TH/$BENCHMARK/test -Dvirtual_fs=false -Dcriterion=BRANCH -Dinline=false -Djunit_suffix=_Test -Dno_runtime_dependency |& tee $RESULTS_PATH/$dt/FASTJSON9TH/$BENCHMARK/evosuiteLog$BENCHMARK.txt
		java -ea -Dsbst.benchmark.jacoco="$REPO_HOME_PATH/CovarageTool/jacocoagent.jar" -Dsbst.benchmark.java="java" -Dsbst.benchmark.javac="javac" -Dsbst.benchmark.config="$REPO_HOME_PATH/CovarageTool/benchmarksRepoPath.list" -Dsbst.benchmark.junit="$REPO_HOME_PATH/CovarageTool/junit-4.12.jar" -Dsbst.benchmark.junit.dependency="$REPO_HOME_PATH/CovarageTool/hamcrest-core-1.3.jar" -Dsbst.benchmark.pitest="$REPO_HOME_PATH/CovarageTool/pitest-1.1.11.jar:$REPO_HOME_PATH/CovarageTool/pitest-command-line-1.1.11.jar" -jar "$REPO_HOME_PATH/CovarageTool/benchmarktool-1.0.0-shaded.jar" EVOSUITE $BENCHMARK $RESULTS_PATH/$dt/FASTJSON9TH 1 $searchBudget --only-compute-metrics $RESULTS_PATH/$dt/FASTJSON9TH/$BENCHMARK/test
	done
fi

#Guava9th
if [[ " ${input_array[@]} " =~ " 22 " ]] || [[ " ${input_array[@]} " =~ " 1 " ]]; then
	mkdir $RESULTS_PATH/$dt/GUAVA9TH
	cp -f $REPO_HOME_PATH/CovarageTool/runtool $RESULTS_PATH/$dt/GUAVA9TH
	for BENCHMARK in GUAVA-108 GUAVA-134 GUAVA-71 GUAVA-273 GUAVA-46 GUAVA-11 GUAVA-999 GUAVA-998 GUAVA-200 GUAVA-237 GUAVA-254 GUAVA-192 GUAVA-231 GUAVA-96 GUAVA-267 GUAVA-232 GUAVA-227 GUAVA-156 GUAVA-82 GUAVA-118 GUAVA-61 GUAVA-199 GUAVA-226 GUAVA-213 GUAVA-148
	do
		echo "[EVOSUITE LAUNCHER] Run benchmark GUAVA9TH -- Target class: $BENCHMARK"
		mkdir -p $RESULTS_PATH/$dt/GUAVA9TH/$BENCHMARK/test
		inputClass=$(awk -v pat="${BENCHMARK/-/_} " '$0~pat{print $NF}' RunFiles/RunGuava9th.java | sed 's/\"//g;s/;//g;s/\//./g')
		java -Xmx4G -jar $EVOSUITE_PATH -class $inputClass -mem 2048 -DCP=$REPO_HOME_PATH/guava9th/guava/target/guava-29.0-jre.jar:$REPO_HOME_PATH/guava9th/guava/target/dependency/failureaccess-1.0.1.jar:$REPO_HOME_PATH/guava9th/guava/target/dependency/checker-qual-2.11.1.jar:$REPO_HOME_PATH/guava9th/guava/target/dependency/error_prone_annotations-2.3.4.jar:$REPO_HOME_PATH/guava9th/guava/target/dependency/listenablefuture-9999.0-empty-to-avoid-conflict-with-guava.jar:$REPO_HOME_PATH/guava9th/guava/target/dependency/srczip-999.jar:$REPO_HOME_PATH/guava9th/guava/target/dependency/j2objc-annotations-1.3.jar:$REPO_HOME_PATH/guava9th/guava/target/dependency/jsr305-3.0.2.jar -Dassertions=false -Dreport_dir=$RESULTS_PATH/$dt/GUAVA9TH/$BENCHMARK -Dsearch_budget=$searchBudget -Dtest_dir=$RESULTS_PATH/$dt/GUAVA9TH/$BENCHMARK/test -Dvirtual_fs=false -Dcriterion=BRANCH -Dinline=false -Djunit_suffix=_Test -Dno_runtime_dependency |& tee $RESULTS_PATH/$dt/GUAVA9TH/$BENCHMARK/evosuiteLog$BENCHMARK.txt
		java -ea -Dsbst.benchmark.jacoco="$REPO_HOME_PATH/CovarageTool/jacocoagent.jar" -Dsbst.benchmark.java="java" -Dsbst.benchmark.javac="javac" -Dsbst.benchmark.config="$REPO_HOME_PATH/CovarageTool/benchmarksRepoPath.list" -Dsbst.benchmark.junit="$REPO_HOME_PATH/CovarageTool/junit-4.12.jar" -Dsbst.benchmark.junit.dependency="$REPO_HOME_PATH/CovarageTool/hamcrest-core-1.3.jar" -Dsbst.benchmark.pitest="$REPO_HOME_PATH/CovarageTool/pitest-1.1.11.jar:$REPO_HOME_PATH/CovarageTool/pitest-command-line-1.1.11.jar" -jar "$REPO_HOME_PATH/CovarageTool/benchmarktool-1.0.0-shaded.jar" EVOSUITE $BENCHMARK $RESULTS_PATH/$dt/GUAVA9TH 1 $searchBudget --only-compute-metrics $RESULTS_PATH/$dt/GUAVA9TH/$BENCHMARK/test
	done
fi

echo "[EVOSUITE LAUNCHER] ENDING at $(date)"
