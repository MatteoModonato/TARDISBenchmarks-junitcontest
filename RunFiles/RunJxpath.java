package settings;

import java.nio.file.Path;
import java.nio.file.Paths;

import java.io.IOException;
import java.util.concurrent.TimeUnit;

import tardis.Main;
import tardis.Options;

public class RunJxpath {

	public static final Path TARDIS_WORKSPACE      = Paths.get("/home", "ubuntu", "tardisFolder", "tardisProva", "tardis");
    public static final Path SUBJECT_ROOT          = Paths.get("/home", "ubuntu", "tardisFolder", "tardisExperiments", "bin", "TARDISBenchmarks-junitcontest", "commons-jxpath-1.3-src");
    public static final Path Z3_PATH               = Paths.get("/home", "ubuntu", "bin", "z3");
    
    public static final Path JBSE_PATH             = TARDIS_WORKSPACE.resolve(Paths.get("jbse", "build", "classes", "java", "main"));
    public static final Path EVOSUITE_PATH         = TARDIS_WORKSPACE.resolve(Paths.get("lib", "evosuite-shaded-1.0.3.jar"));
	public static final Path EVOSUITE_MOSA_PATH    = TARDIS_WORKSPACE.resolve(Paths.get("lib", "evosuite-shaded-1.0.6-SNAPSHOT.jar"));
	public static final Path SUSHI_LIB_PATH        = TARDIS_WORKSPACE.resolve(Paths.get("runtime", "build", "classes", "java", "main"));
    
    public static final Path TMP_BASE_PATH         = SUBJECT_ROOT.resolve(Paths.get("tardis-tmp"));
    public static final Path OUT_PATH              = SUBJECT_ROOT.resolve(Paths.get("tardis-test"));

    public static final Path SUBJECT_PATH          = SUBJECT_ROOT.resolve(Paths.get("target", "classes"));
    public static final Path MOCKRUNNER_PATH       = SUBJECT_ROOT.resolve(Paths.get("dependencies", "mockrunner-jdk1.3-j2ee1.3-0.4.jar"));
    public static final Path XERCES_PATH           = SUBJECT_ROOT.resolve(Paths.get("dependencies", "xercesImpl-2.4.0.jar"));
    public static final Path MOCKEJB_PATH          = SUBJECT_ROOT.resolve(Paths.get("dependencies", "mockejb-0.6-beta2.jar"));
    public static final Path BEANUTILS_PATH        = SUBJECT_ROOT.resolve(Paths.get("dependencies", "commons-beanutils-1.7.0.jar"));
    public static final Path SERVLET_API_PATH      = SUBJECT_ROOT.resolve(Paths.get("dependencies", "servlet-api-2.4.jar"));
    public static final Path LOGGING_PATH          = SUBJECT_ROOT.resolve(Paths.get("dependencies", "commons-logging-1.1.1.jar"));
    public static final Path JSP_PATH              = SUBJECT_ROOT.resolve(Paths.get("dependencies", "jsp-api-2.0.jar"));
    public static final Path JUNIT_PATH            = SUBJECT_ROOT.resolve(Paths.get("dependencies", "junit-3.8.1.jar"));
    public static final Path XML_APIS_PATH         = SUBJECT_ROOT.resolve(Paths.get("dependencies", "xml-apis-1.3.04.jar"));
    public static final Path CGLIB_PATH            = SUBJECT_ROOT.resolve(Paths.get("dependencies", "cglib-full-2.0.2.jar"));
    public static final Path JDOM_PATH             = SUBJECT_ROOT.resolve(Paths.get("dependencies", "jdom-1.0.jar"));

    public static final String TARGET_CLASS_1      = "org/apache/commons/jxpath/util/BasicTypeConverter";
    public static final String TARGET_CLASS_2      = "org/apache/commons/jxpath/ri/compiler/Path";
    public static final String TARGET_CLASS_3      = "org/apache/commons/jxpath/ri/compiler/CoreOperationCompare";
    public static final String TARGET_CLASS_4      = "org/apache/commons/jxpath/util/MethodLookupUtils";
    public static final String TARGET_CLASS_5      = "org/apache/commons/jxpath/ri/compiler/Step";
    public static final String TARGET_CLASS_6      = "org/apache/commons/jxpath/JXPathContext";
    public static final String TARGET_CLASS_7      = "org/apache/commons/jxpath/ri/parser/XPathParserTokenManager";
    public static final String TARGET_CLASS_8      = "org/apache/commons/jxpath/util/ValueUtils";
    public static final String TARGET_CLASS_9      = "org/apache/commons/jxpath/ri/model/beans/PropertyIterator";
    public static final String TARGET_CLASS_10     = "org/apache/commons/jxpath/ri/axes/SimplePathInterpreter";

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
		o.setClassesPath(SUBJECT_PATH, MOCKRUNNER_PATH, XERCES_PATH, MOCKEJB_PATH, BEANUTILS_PATH, SERVLET_API_PATH, LOGGING_PATH, JSP_PATH, JUNIT_PATH,
				XML_APIS_PATH, CGLIB_PATH, JDOM_PATH);
		o.setOutDirectory(OUT_PATH);
		o.setSushiLibPath(SUSHI_LIB_PATH);
		o.setEvosuitePath(EVOSUITE_MOSA_PATH);
		o.setUseMOSA(true);
		o.setNumMOSATargets(2);
		o.setGlobalTimeBudgetDuration(timeBudgetDuration);
		o.setGlobalTimeBudgetUnit(timeBudgetTimeUnit);
		//o.setThrottleFactorEvosuite(1.0f);
		o.setEvosuiteTimeBudgetDuration(15);
	
		final Main m = new Main(o);
		m.start();
	}
}
