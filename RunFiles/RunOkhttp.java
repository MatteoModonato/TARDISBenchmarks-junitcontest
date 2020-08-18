package settings;

import java.nio.file.Path;
import java.nio.file.Paths;

import java.io.IOException;
import java.util.concurrent.TimeUnit;

import tardis.Main;
import tardis.Options;

public class RunOkhttp {

	public static final Path TARDIS_WORKSPACE      = Paths.get("/home", "ubuntu", "tardisFolder", "tardisProva", "tardis");
    public static final Path SUBJECT_ROOT          = Paths.get("/home", "ubuntu", "tardisFolder", "tardisExperiments", "bin", "TARDISBenchmarks-junitcontest", "okhttp");
    public static final Path Z3_PATH               = Paths.get("/home", "ubuntu", "bin", "z3");
    
    public static final Path JBSE_PATH             = TARDIS_WORKSPACE.resolve(Paths.get("jbse", "build", "classes", "java", "main"));
    public static final Path EVOSUITE_PATH         = TARDIS_WORKSPACE.resolve(Paths.get("lib", "evosuite-shaded-1.0.3.jar"));
	public static final Path EVOSUITE_MOSA_PATH    = TARDIS_WORKSPACE.resolve(Paths.get("lib", "evosuite-shaded-1.0.6-SNAPSHOT.jar"));
	public static final Path SUSHI_LIB_PATH        = TARDIS_WORKSPACE.resolve(Paths.get("runtime", "build", "classes", "java", "main"));
    
    public static final Path TMP_BASE_PATH         = SUBJECT_ROOT.resolve(Paths.get("tardis-tmp"));
    public static final Path OUT_PATH              = SUBJECT_ROOT.resolve(Paths.get("tardis-test"));

    public static final Path SUBJECT_PATH          = SUBJECT_ROOT.resolve(Paths.get("okhttp", "target", "classes"));
    public static final Path OKIO_PATH             = SUBJECT_ROOT.resolve(Paths.get("dependencies", "okio-1.11.0.jar"));
    public static final Path ANDROID_PATH          = SUBJECT_ROOT.resolve(Paths.get("dependencies", "android-4.1.1.4.jar"));
    public static final Path COMMONS_LOG_PATH      = SUBJECT_ROOT.resolve(Paths.get("dependencies", "commons-logging-1.1.1.jar"));
    public static final Path HTTPCLIENT_PATH       = SUBJECT_ROOT.resolve(Paths.get("dependencies", "httpclient-4.2.2.jar"));
    public static final Path HTTPCORE_PATH         = SUBJECT_ROOT.resolve(Paths.get("dependencies", "httpcore-4.2.2.jar"));
    public static final Path COMMONS_COD_PATH      = SUBJECT_ROOT.resolve(Paths.get("dependencies", "commons-codec-1.6.jar"));
    public static final Path OPENGL_PATH           = SUBJECT_ROOT.resolve(Paths.get("dependencies", "opengl-api-gl1.1-android-2.1_r1.jar"));
    public static final Path XMLPARSER_PATH        = SUBJECT_ROOT.resolve(Paths.get("dependencies", "xmlParserAPIs-2.6.2.jar"));
    public static final Path XPP3_PATH             = SUBJECT_ROOT.resolve(Paths.get("dependencies", "xpp3-1.1.4c.jar"));
    public static final Path JSON_PATH             = SUBJECT_ROOT.resolve(Paths.get("dependencies", "json-20080701.jar"));

    public static final String TARGET_CLASS_1      = "okhttp3/Cookie";
    public static final String TARGET_CLASS_2      = "okhttp3/internal/platform/AndroidPlatform";
    public static final String TARGET_CLASS_3      = "okhttp3/ConnectionSpec";
    public static final String TARGET_CLASS_4      = "okhttp3/internal/http/HttpHeaders";
    public static final String TARGET_CLASS_5      = "okhttp3/internal/tls/DistinguishedNameParser";
    public static final String TARGET_CLASS_6      = "okhttp3/CacheControl";
    public static final String TARGET_CLASS_7      = "okhttp3/internal/tls/OkHostnameVerifier";
    public static final String TARGET_CLASS_8      = "okhttp3/HttpUrl";

	public static void main(String[] s) throws IOException {
		final int maxDepth = 1000;
		final int numOfThreads = 2;
		final long timeBudgetDuration = 10;
		final TimeUnit timeBudgetTimeUnit = TimeUnit.MINUTES;
		
		final Options o = new Options();
		o.setTargetClass(TARGET_CLASS_1);
		o.setMaxDepth(maxDepth);
		o.setNumOfThreads(numOfThreads);
		o.setTmpDirectoryBase(TMP_BASE_PATH);
		o.setZ3Path(Z3_PATH);
		o.setJBSELibraryPath(JBSE_PATH);
		o.setClassesPath(SUBJECT_PATH, OKIO_PATH, ANDROID_PATH, COMMONS_LOG_PATH, HTTPCLIENT_PATH, HTTPCORE_PATH, COMMONS_COD_PATH, OPENGL_PATH,
				XMLPARSER_PATH, XPP3_PATH, JSON_PATH);
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