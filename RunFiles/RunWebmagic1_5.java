package settings;

import java.nio.file.Path;
import java.nio.file.Paths;

import java.io.IOException;
import java.util.concurrent.TimeUnit;

import tardis.Main;
import tardis.Options;

public class RunWebmagic1_5 {

	public static final Path TARDIS_WORKSPACE      = Paths.get("/home", "ubuntu", "tardisFolder", "tardisProva", "tardis");
	public static final Path SUBJECT_ROOT          = Paths.get("/home", "ubuntu", "tardisFolder", "tardisExperiments", "bin", "TARDISBenchmarks-junitcontest", "webmagic");
	public static final Path Z3_PATH               = Paths.get("/home", "ubuntu", "bin", "z3");
	
	public static final Path JBSE_PATH             = TARDIS_WORKSPACE.resolve(Paths.get("jbse", "build", "classes", "java", "main"));
	public static final Path EVOSUITE_PATH         = TARDIS_WORKSPACE.resolve(Paths.get("lib", "evosuite-shaded-1.0.3.jar"));
	public static final Path EVOSUITE_MOSA_PATH    = TARDIS_WORKSPACE.resolve(Paths.get("lib", "evosuite-shaded-1.0.6-SNAPSHOT.jar"));
	public static final Path SUSHI_LIB_PATH        = TARDIS_WORKSPACE.resolve(Paths.get("runtime", "build", "classes", "java", "main"));
	
	public static final Path TMP_BASE_PATH         = SUBJECT_ROOT.resolve(Paths.get("tardis-tmp"));
	public static final Path OUT_PATH              = SUBJECT_ROOT.resolve(Paths.get("tardis-test"));

	public static final Path SUBJECT_PATH_1        = SUBJECT_ROOT.resolve(Paths.get("webmagic-extension", "target", "classes"));
	public static final Path SUBJECT_PATH_4        = SUBJECT_ROOT.resolve(Paths.get("webmagic-core", "target", "classes"));
	public static final Path SUBJECT_PATH_5        = SUBJECT_ROOT.resolve(Paths.get("webmagic-samples", "target", "classes"));
	public static final Path SUBJECT_PATH_6        = SUBJECT_ROOT.resolve(Paths.get("webmagic-saxon", "target", "classes"));
	public static final Path SUBJECT_PATH_7        = SUBJECT_ROOT.resolve(Paths.get("webmagic-scripts", "target", "classes"));
	public static final Path SUBJECT_PATH_8        = SUBJECT_ROOT.resolve(Paths.get("webmagic-selenium", "target", "classes"));

	public static final Path JEDIS_PATH            = SUBJECT_ROOT.resolve(Paths.get("dependencies", "jedis-2.9.0.jar"));
	public static final Path CPOOL_PATH            = SUBJECT_ROOT.resolve(Paths.get("dependencies", "commons-pool2-2.4.2.jar"));
	public static final Path GUAVA_PATH            = SUBJECT_ROOT.resolve(Paths.get("dependencies", "guava-15.0.jar"));
	public static final Path HTTPCORE_PATH         = SUBJECT_ROOT.resolve(Paths.get("dependencies", "httpcore-4.4.4.jar"));
	public static final Path HTTCLIENT_PATH        = SUBJECT_ROOT.resolve(Paths.get("dependencies", "httpclient-4.5.2.jar"));
	public static final Path CCODEC_PATH           = SUBJECT_ROOT.resolve(Paths.get("dependencies", "commons-codec-1.9.jar"));
	public static final Path CLOGGING_PATH         = SUBJECT_ROOT.resolve(Paths.get("dependencies", "commons-logging-1.2.jar"));
	public static final Path CLANG_PATH            = SUBJECT_ROOT.resolve(Paths.get("dependencies", "commons-lang3-3.1.jar"));
	public static final Path XSOUP_PATH            = SUBJECT_ROOT.resolve(Paths.get("dependencies", "xsoup-0.3.1.jar"));
	public static final Path ASSERTJ_PATH          = SUBJECT_ROOT.resolve(Paths.get("dependencies", "assertj-core-1.5.0.jar"));
	public static final Path SLF4J_PATH            = SUBJECT_ROOT.resolve(Paths.get("dependencies", "slf4j-api-1.7.6.jar"));
	public static final Path SLF4J_LOG_PATH        = SUBJECT_ROOT.resolve(Paths.get("dependencies", "slf4j-log4j12-1.7.6.jar"));
	public static final Path LOG4J_PATH            = SUBJECT_ROOT.resolve(Paths.get("dependencies", "log4j-1.2.17.jar"));
	public static final Path CCOLLECTIONS_PATH     = SUBJECT_ROOT.resolve(Paths.get("dependencies", "commons-collections-3.2.2.jar"));
	public static final Path JSOUP_PATH            = SUBJECT_ROOT.resolve(Paths.get("dependencies", "jsoup-1.10.3.jar"));
	public static final Path COMMONS_PATH          = SUBJECT_ROOT.resolve(Paths.get("dependencies", "commons-io-1.3.2.jar"));
	public static final Path JSON_SMART_PATH       = SUBJECT_ROOT.resolve(Paths.get("dependencies", "json-smart-2.3.jar"));
	public static final Path JSON_PATH             = SUBJECT_ROOT.resolve(Paths.get("dependencies", "json-path-2.4.0.jar"));
	public static final Path ACCESSORS_PATH        = SUBJECT_ROOT.resolve(Paths.get("dependencies", "accessors-smart-1.2.jar"));
	public static final Path ASM_PATH              = SUBJECT_ROOT.resolve(Paths.get("dependencies", "asm-5.0.4.jar"));
	public static final Path FASTJSON_PATH         = SUBJECT_ROOT.resolve(Paths.get("dependencies", "fastjson-1.2.28.jar"));    
	public static final Path HAMCREST_PATH         = SUBJECT_ROOT.resolve(Paths.get("dependencies", "hamcrest-core-1.3.jar"));
	public static final Path JUNIT_PATH            = SUBJECT_ROOT.resolve(Paths.get("dependencies", "junit-4.11.jar"));

	public static final String WEBMAGIC_1      = "us/codecraft/webmagic/model/PageModelExtractor";
	public static final String WEBMAGIC_5      = "us/codecraft/webmagic/utils/DoubleKeyMap";

	public static void main(String[] s) throws IOException {
		final int maxDepth = 1000;
		final long timeBudgetDuration = 10;
		final TimeUnit timeBudgetTimeUnit = TimeUnit.MINUTES;
		
		final Options o = new Options();
		o.setTargetClass(WEBMAGIC_1);
		o.setMaxDepth(maxDepth);
		o.setNumOfThreadsJBSE(5);
		o.setNumOfThreadsEvosuite(5);
		o.setMaxTestCaseDepth(25);
		o.setTmpDirectoryBase(TMP_BASE_PATH);
		o.setZ3Path(Z3_PATH);
		o.setJBSELibraryPath(JBSE_PATH);
		o.setClassesPath(SUBJECT_PATH_1, SUBJECT_PATH_4, JEDIS_PATH, CPOOL_PATH, GUAVA_PATH, HTTPCORE_PATH, HTTCLIENT_PATH, CCODEC_PATH, CLOGGING_PATH, CLANG_PATH,
				XSOUP_PATH, ASSERTJ_PATH, SLF4J_PATH, LOG4J_PATH, CCOLLECTIONS_PATH, JSOUP_PATH, COMMONS_PATH, JSON_SMART_PATH, JSON_PATH,
				ACCESSORS_PATH, ASM_PATH, FASTJSON_PATH, HAMCREST_PATH, JUNIT_PATH);
		o.setOutDirectory(OUT_PATH);
		o.setSushiLibPath(SUSHI_LIB_PATH);
		o.setEvosuitePath(EVOSUITE_MOSA_PATH);
		o.setUseMOSA(true);
		o.setNumMOSATargets(2);
		o.setGlobalTimeBudgetDuration(timeBudgetDuration);
		o.setGlobalTimeBudgetUnit(timeBudgetTimeUnit);
		o.setThrottleFactorEvosuite(0.0f);
		o.setEvosuiteTimeBudgetDuration(120);
	
		final Main m = new Main(o);
		m.start();
	}
}
