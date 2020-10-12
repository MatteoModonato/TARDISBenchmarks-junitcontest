package settings;

import java.nio.file.Path;
import java.nio.file.Paths;

import java.io.IOException;
import java.util.concurrent.TimeUnit;

import tardis.Main;
import tardis.Options;

public class RunWebmagic2_3_4 {

	public static final Path TARDIS_WORKSPACE      = Paths.get("/home", "ubuntu", "tardisFolder", "tardisProva", "tardis");
    public static final Path SUBJECT_ROOT          = Paths.get("/home", "ubuntu", "tardisFolder", "tardisExperiments", "bin", "TARDISBenchmarks-junitcontest", "webmagic");
    public static final Path Z3_PATH               = Paths.get("/home", "ubuntu", "bin", "z3");
    
    public static final Path JBSE_PATH             = TARDIS_WORKSPACE.resolve(Paths.get("jbse", "build", "classes", "java", "main"));
    public static final Path EVOSUITE_PATH         = TARDIS_WORKSPACE.resolve(Paths.get("lib", "evosuite-shaded-1.0.3.jar"));
	public static final Path EVOSUITE_MOSA_PATH    = TARDIS_WORKSPACE.resolve(Paths.get("lib", "evosuite-shaded-1.0.6-SNAPSHOT.jar"));
	public static final Path SUSHI_LIB_PATH        = TARDIS_WORKSPACE.resolve(Paths.get("runtime", "build", "classes", "java", "main"));
    
    public static final Path TMP_BASE_PATH         = SUBJECT_ROOT.resolve(Paths.get("tardis-tmp"));
    public static final Path OUT_PATH              = SUBJECT_ROOT.resolve(Paths.get("tardis-test"));

    public static final Path SUBJECT_PATH_4    = SUBJECT_ROOT.resolve(Paths.get("webmagic-core", "target", "classes"));
    public static final Path ASM_PATH          = SUBJECT_ROOT.resolve(Paths.get("dependencies", "asm-5.0.4.jar"));
    public static final Path FASTJSON_PATH     = SUBJECT_ROOT.resolve(Paths.get("dependencies", "fastjson-1.2.28.jar"));
    public static final Path ACCESSORS_PATH    = SUBJECT_ROOT.resolve(Paths.get("dependencies", "accessors-smart-1.2.jar"));
    public static final Path JSON_SMART_PATH   = SUBJECT_ROOT.resolve(Paths.get("dependencies", "json-smart-2.3.jar"));
    public static final Path JSON_PATH         = SUBJECT_ROOT.resolve(Paths.get("dependencies", "json-path-2.4.0.jar"));
    public static final Path COMMONS_PATH      = SUBJECT_ROOT.resolve(Paths.get("dependencies", "commons-io-1.3.2.jar"));
    public static final Path JSOUP_PATH        = SUBJECT_ROOT.resolve(Paths.get("dependencies", "jsoup-1.10.3.jar"));
    public static final Path ASSERTJ_PATH      = SUBJECT_ROOT.resolve(Paths.get("dependencies", "assertj-core-1.5.0.jar"));
    public static final Path CCOLLECTIONS_PATH = SUBJECT_ROOT.resolve(Paths.get("dependencies", "commons-collections-3.2.2.jar"));
    public static final Path LOG4J_PATH        = SUBJECT_ROOT.resolve(Paths.get("dependencies", "log4j-1.2.17.jar"));
    public static final Path SLF4J_LOG_PATH    = SUBJECT_ROOT.resolve(Paths.get("dependencies", "slf4j-log4j12-1.7.6.jar"));
    public static final Path MOCKITO_PATH      = SUBJECT_ROOT.resolve(Paths.get("dependencies", "mockito-all-1.10.19.jar"));
    public static final Path SLF4J_PATH        = SUBJECT_ROOT.resolve(Paths.get("dependencies", "slf4j-api-1.7.6.jar"));
    public static final Path JCORE_PATH        = SUBJECT_ROOT.resolve(Paths.get("dependencies", "jackson-core-2.7.4.jar"));
    public static final Path JANNOTATIONS_PATH = SUBJECT_ROOT.resolve(Paths.get("dependencies", "jackson-annotations-2.7.0.jar"));
    public static final Path JDATABIND_PATH    = SUBJECT_ROOT.resolve(Paths.get("dependencies", "jackson-databind-2.7.4.jar"));
    public static final Path GUAVA_PATH        = SUBJECT_ROOT.resolve(Paths.get("dependencies", "guava-15.0.jar"));
    public static final Path FREEMAKER_PATH    = SUBJECT_ROOT.resolve(Paths.get("dependencies", "freemarker-2.3.23.jar"));
    public static final Path NCOMMON_PATH      = SUBJECT_ROOT.resolve(Paths.get("dependencies", "netty-common-4.0.36.Final.jar"));
    public static final Path NBUFFER_PATH      = SUBJECT_ROOT.resolve(Paths.get("dependencies", "netty-buffer-4.0.36.Final.jar"));
    public static final Path NHANDLER_PATH     = SUBJECT_ROOT.resolve(Paths.get("dependencies", "netty-handler-4.0.36.Final.jar"));
    public static final Path NTRANSPORT_PATH   = SUBJECT_ROOT.resolve(Paths.get("dependencies", "netty-transport-4.0.36.Final.jar"));
    public static final Path NCODEC_PATH       = SUBJECT_ROOT.resolve(Paths.get("dependencies", "netty-codec-4.0.36.Final.jar"));
    public static final Path NCODEC_HTTP_PATH  = SUBJECT_ROOT.resolve(Paths.get("dependencies", "netty-codec-http-4.0.36.Final.jar"));
    public static final Path MOCO_PATH         = SUBJECT_ROOT.resolve(Paths.get("dependencies", "moco-core-0.11.0.jar"));
    public static final Path XSOUP_PATH        = SUBJECT_ROOT.resolve(Paths.get("dependencies", "xsoup-0.3.1.jar"));
    public static final Path CLANG_PATH        = SUBJECT_ROOT.resolve(Paths.get("dependencies", "commons-lang3-3.1.jar"));
    public static final Path HAMCREST_PATH     = SUBJECT_ROOT.resolve(Paths.get("dependencies", "hamcrest-core-1.3.jar"));
    public static final Path JUNIT_PATH        = SUBJECT_ROOT.resolve(Paths.get("dependencies", "junit-4.11.jar"));
    public static final Path CCODEC_PATH       = SUBJECT_ROOT.resolve(Paths.get("dependencies", "commons-codec-1.9.jar"));
    public static final Path CLOGGING_PATH     = SUBJECT_ROOT.resolve(Paths.get("dependencies", "commons-logging-1.2.jar"));
    public static final Path HTTPCORE_PATH     = SUBJECT_ROOT.resolve(Paths.get("dependencies", "httpcore-4.4.4.jar"));
    public static final Path HTTCLIENT_PATH    = SUBJECT_ROOT.resolve(Paths.get("dependencies", "httpclient-4.5.2.jar"));

    public static final String WEBMAGIC_2  = "us/codecraft/webmagic/Spider";
    public static final String WEBMAGIC_3  = "us/codecraft/webmagic/Site";
    public static final String WEBMAGIC_4  = "us/codecraft/webmagic/Page";

	public static void main(String[] s) throws IOException {
		final int maxDepth = 1000;
		final int numOfThreads = 2;
		final long timeBudgetDuration = 10;
		final TimeUnit timeBudgetTimeUnit = TimeUnit.MINUTES;
		
		final Options o = new Options();
		o.setTargetClass(WEBMAGIC_2);
		o.setMaxDepth(maxDepth);
		o.setNumOfThreads(numOfThreads);
		o.setTmpDirectoryBase(TMP_BASE_PATH);
		o.setZ3Path(Z3_PATH);
		o.setJBSELibraryPath(JBSE_PATH);
		o.setClassesPath(SUBJECT_PATH_4, ASM_PATH, FASTJSON_PATH, ACCESSORS_PATH, JSON_SMART_PATH, JSON_PATH, COMMONS_PATH, JSOUP_PATH, ASSERTJ_PATH, CCOLLECTIONS_PATH,
				SLF4J_LOG_PATH, MOCKITO_PATH, SLF4J_PATH, JCORE_PATH, JANNOTATIONS_PATH, JDATABIND_PATH, GUAVA_PATH, FREEMAKER_PATH, NCOMMON_PATH, NBUFFER_PATH,
				NHANDLER_PATH, NTRANSPORT_PATH, NCODEC_PATH, NCODEC_HTTP_PATH, MOCO_PATH, XSOUP_PATH, CLANG_PATH, HAMCREST_PATH, JUNIT_PATH, CCODEC_PATH, CLOGGING_PATH,
				HTTPCORE_PATH, HTTCLIENT_PATH);
		o.setOutDirectory(OUT_PATH);
		o.setSushiLibPath(SUSHI_LIB_PATH);
		o.setEvosuitePath(EVOSUITE_MOSA_PATH);
		o.setUseMOSA(true);
		o.setNumMOSATargets(2);
		o.setGlobalTimeBudgetDuration(timeBudgetDuration);
		o.setGlobalTimeBudgetUnit(timeBudgetTimeUnit);
		//o.setThrottleFactorEvosuite(1.0f);
		o.setEvosuiteTimeBudgetDuration(120);
	
		final Main m = new Main(o);
		m.start();
	}
}
