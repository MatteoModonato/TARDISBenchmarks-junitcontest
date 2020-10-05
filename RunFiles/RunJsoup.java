package settings;

import java.nio.file.Path;
import java.nio.file.Paths;

import java.io.IOException;
import java.util.concurrent.TimeUnit;

import tardis.Main;
import tardis.Options;

public class RunJsoup {

	public static final Path TARDIS_WORKSPACE      = Paths.get("/home", "ubuntu", "tardisFolder", "tardisProva", "tardis");
    public static final Path SUBJECT_ROOT          = Paths.get("/home", "ubuntu", "tardisFolder", "tardisExperiments", "bin", "TARDISBenchmarks-junitcontest", "jsoup");
    public static final Path Z3_PATH               = Paths.get("/home", "ubuntu", "bin", "z3");
    
    public static final Path JBSE_PATH             = TARDIS_WORKSPACE.resolve(Paths.get("jbse", "build", "classes", "java", "main"));
    public static final Path EVOSUITE_PATH         = TARDIS_WORKSPACE.resolve(Paths.get("lib", "evosuite-shaded-1.0.3.jar"));
	public static final Path EVOSUITE_MOSA_PATH    = TARDIS_WORKSPACE.resolve(Paths.get("lib", "evosuite-shaded-1.0.6-SNAPSHOT.jar"));
	public static final Path SUSHI_LIB_PATH        = TARDIS_WORKSPACE.resolve(Paths.get("runtime", "build", "classes", "java", "main"));
    
    public static final Path TMP_BASE_PATH         = SUBJECT_ROOT.resolve(Paths.get("tardis-tmp"));
    public static final Path OUT_PATH              = SUBJECT_ROOT.resolve(Paths.get("tardis-test"));

    public static final Path SUBJECT_PATH          = SUBJECT_ROOT.resolve(Paths.get("target", "classes"));
    public static final Path JETTYSEC_PATH         = SUBJECT_ROOT.resolve(Paths.get("dependencies", "jetty-security-9.2.22.v20170606.jar"));
    public static final Path JETTYSER_PATH         = SUBJECT_ROOT.resolve(Paths.get("dependencies", "jetty-servlet-9.2.22.v20170606.jar"));
    public static final Path JETTYIO_PATH          = SUBJECT_ROOT.resolve(Paths.get("dependencies", "jetty-io-9.2.22.v20170606.jar"));
    public static final Path JETTYUTIL_PATH        = SUBJECT_ROOT.resolve(Paths.get("dependencies", "jetty-util-9.2.22.v20170606.jar"));
    public static final Path JETTYHTTP_PATH        = SUBJECT_ROOT.resolve(Paths.get("dependencies", "jetty-http-9.2.22.v20170606.jar"));
    public static final Path JETTYSERA_PATH        = SUBJECT_ROOT.resolve(Paths.get("dependencies", "javax.servlet-api-3.1.0.jar"));
    public static final Path JETTYSERVER_PATH      = SUBJECT_ROOT.resolve(Paths.get("dependencies", "jetty-server-9.2.22.v20170606.jar"));
    public static final Path GSON_PATH             = SUBJECT_ROOT.resolve(Paths.get("dependencies", "gson-2.7.jar"));
    public static final Path HAMCREST_PATH         = SUBJECT_ROOT.resolve(Paths.get("dependencies", "hamcrest-core-1.3.jar"));
    public static final Path JUNIT_PATH            = SUBJECT_ROOT.resolve(Paths.get("dependencies", "junit-4.12.jar"));
    
    public static final String JSOUP_1      = "org/jsoup/parser/TokenQueue";
    public static final String JSOUP_2      = "org/jsoup/select/QueryParser";
    public static final String JSOUP_3      = "org/jsoup/helper/DataUtil";
    public static final String JSOUP_4      = "org/jsoup/parser/Parser";
    public static final String JSOUP_5      = "org/jsoup/parser/Tokeniser";

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
		o.setClassesPath(SUBJECT_PATH, JETTYSEC_PATH, JETTYSER_PATH, JETTYIO_PATH, JETTYUTIL_PATH, JETTYHTTP_PATH, JETTYSERA_PATH, JETTYSERVER_PATH,
				GSON_PATH, HAMCREST_PATH, JUNIT_PATH);
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
