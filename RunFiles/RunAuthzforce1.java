package settings;

import java.nio.file.Path;
import java.nio.file.Paths;

import java.io.IOException;
import java.util.concurrent.TimeUnit;

import tardis.Main;
import tardis.Options;

public class RunAuthzforce1 {

	public static final Path TARDIS_WORKSPACE      = Paths.get("/home", "ubuntu", "tardisFolder", "tardisProva", "tardis");
    public static final Path SUBJECT_ROOT          = Paths.get("/home", "ubuntu", "tardisFolder", "tardisExperiments", "bin", "TARDISBenchmarks-junitcontest", "core-release-13.3.0");
    public static final Path Z3_PATH               = Paths.get("/home", "ubuntu", "bin", "z3");
    
    public static final Path JBSE_PATH             = TARDIS_WORKSPACE.resolve(Paths.get("jbse", "build", "classes", "java", "main"));
    public static final Path EVOSUITE_PATH         = TARDIS_WORKSPACE.resolve(Paths.get("lib", "evosuite-shaded-1.0.3.jar"));
	public static final Path EVOSUITE_MOSA_PATH    = TARDIS_WORKSPACE.resolve(Paths.get("lib", "evosuite-shaded-1.0.6-SNAPSHOT.jar"));
	public static final Path SUSHI_LIB_PATH        = TARDIS_WORKSPACE.resolve(Paths.get("runtime", "build", "classes", "java", "main"));
    
    public static final Path TMP_BASE_PATH         = SUBJECT_ROOT.resolve(Paths.get("tardis-tmp"));
    public static final Path OUT_PATH              = SUBJECT_ROOT.resolve(Paths.get("tardis-test"));

    public static final Path SUBJECT_PATH          = SUBJECT_ROOT.resolve(Paths.get("pdp-engine", "target", "classes"));
    public static final Path ACTIVATION_PATH       = SUBJECT_ROOT.resolve(Paths.get("dependencies", "activation-1.1.jar"));
    public static final Path ASNIFFER_ANNO_PATH    = SUBJECT_ROOT.resolve(Paths.get("dependencies", "animal-sniffer-annotations-1.14.jar"));
    public static final Path AUTHZFORCE_API_PATH   = SUBJECT_ROOT.resolve(Paths.get("dependencies", "authzforce-ce-core-pdp-api-15.3.0.jar"));
    public static final Path AUTHZFORCE_EXT_PATH   = SUBJECT_ROOT.resolve(Paths.get("dependencies", "authzforce-ce-pdp-ext-model-7.5.0.jar"));
    public static final Path AUTHZFORCE_XACML_PATH = SUBJECT_ROOT.resolve(Paths.get("dependencies", "authzforce-ce-xacml-model-7.5.0.jar"));
    public static final Path AUTHZFORCE_XMLNS_PATH = SUBJECT_ROOT.resolve(Paths.get("dependencies", "authzforce-ce-xmlns-model-7.5.0.jar"));
    public static final Path CHECKER_PATH          = SUBJECT_ROOT.resolve(Paths.get("dependencies", "checker-compat-qual-2.0.0.jar"));
    public static final Path ERRORPRONE_ANNO_PATH  = SUBJECT_ROOT.resolve(Paths.get("dependencies", "error_prone_annotations-2.1.3.jar"));
    public static final Path GUAVA_PATH            = SUBJECT_ROOT.resolve(Paths.get("dependencies", "guava-24.1.1-jre.jar"));
    public static final Path HAMCREST_CORE_PATH    = SUBJECT_ROOT.resolve(Paths.get("dependencies", "hamcrest-core-1.3.jar"));
    public static final Path J2OBJC_ANNO_PATH      = SUBJECT_ROOT.resolve(Paths.get("dependencies", "j2objc-annotations-1.1.jar"));
    public static final Path JAVAXMAIL_PATH        = SUBJECT_ROOT.resolve(Paths.get("dependencies", "javax.mail-1.6.0.jar"));
    public static final Path JAVAXMAIL_API_PATH    = SUBJECT_ROOT.resolve(Paths.get("dependencies", "javax.mail-api-1.6.0.jar"));
    public static final Path JAXB2_PATH            = SUBJECT_ROOT.resolve(Paths.get("dependencies", "jaxb2-basics-runtime-1.11.1.jar"));
    public static final Path JCLOSLF4J_PATH        = SUBJECT_ROOT.resolve(Paths.get("dependencies", "jcl-over-slf4j-1.7.25.jar"));
    public static final Path JSR305_PATH           = SUBJECT_ROOT.resolve(Paths.get("dependencies", "jsr305-1.3.9.jar"));
    public static final Path JUNIT_PATH            = SUBJECT_ROOT.resolve(Paths.get("dependencies", "junit-4.11.jar"));
    public static final Path LOGBACK_CLASSIC_PATH  = SUBJECT_ROOT.resolve(Paths.get("dependencies", "logback-classic-1.2.3.jar"));
    public static final Path LOGBACK_CORE_PATH     = SUBJECT_ROOT.resolve(Paths.get("dependencies", "logback-core-1.2.3.jar"));
    public static final Path SAXON_PATH            = SUBJECT_ROOT.resolve(Paths.get("dependencies", "Saxon-HE-9.8.0-12.jar"));
    public static final Path SLF4J_API_PATH        = SUBJECT_ROOT.resolve(Paths.get("dependencies", "slf4j-api-1.7.25.jar"));
    public static final Path SPRING_CORE_PATH      = SUBJECT_ROOT.resolve(Paths.get("dependencies", "spring-core-4.3.18.RELEASE.jar"));
    public static final Path XMLRESOLVER_PATH      = SUBJECT_ROOT.resolve(Paths.get("dependencies", "xml-resolver-1.2.jar"));

    public static final String TARGET_CLASS_1  = "org/ow2/authzforce/core/pdp/impl/PdpBean";
    public static final String TARGET_CLASS_5  = "org/ow2/authzforce/core/pdp/impl/CloseableAttributeProvider";
    public static final String TARGET_CLASS_11 = "org/ow2/authzforce/core/pdp/impl/func/LogicalNOfFunction";
    public static final String TARGET_CLASS_27 = "org/ow2/authzforce/core/pdp/impl/func/MapFunctionFactory";
    public static final String TARGET_CLASS_32 = "org/ow2/authzforce/core/pdp/impl/func/SubstringFunction";
    public static final String TARGET_CLASS_33 = "org/ow2/authzforce/core/pdp/impl/SchemaHandler";
    public static final String TARGET_CLASS_48 = "org/ow2/authzforce/core/pdp/impl/policy/PolicyVersions";
    public static final String TARGET_CLASS_52 = "org/ow2/authzforce/core/pdp/impl/PepActionExpression";
    public static final String TARGET_CLASS_63 = "org/ow2/authzforce/core/pdp/impl/combining/DPUnlessPDCombiningAlg";
    public static final String TARGET_CLASS_65 = "org/ow2/authzforce/core/pdp/impl/combining/FirstApplicableCombiningAlg";

	public static void main(String[] s) throws IOException {
		final int maxDepth = 1000;
		final int numOfThreads = 5;
		final long timeBudgetDuration = 20;
		final TimeUnit timeBudgetTimeUnit = TimeUnit.MINUTES;
		
		final Options o = new Options();
		o.setTargetClass(TARGET_CLASS_32);
		o.setMaxDepth(maxDepth);
		o.setNumOfThreads(numOfThreads);
		o.setTmpDirectoryBase(TMP_BASE_PATH);
		o.setZ3Path(Z3_PATH);
		o.setJBSELibraryPath(JBSE_PATH);
		o.setClassesPath(SUBJECT_PATH, ACTIVATION_PATH, ASNIFFER_ANNO_PATH, AUTHZFORCE_API_PATH, AUTHZFORCE_EXT_PATH, AUTHZFORCE_XACML_PATH, AUTHZFORCE_XMLNS_PATH,
						 CHECKER_PATH, ERRORPRONE_ANNO_PATH, GUAVA_PATH, HAMCREST_CORE_PATH, J2OBJC_ANNO_PATH, JAVAXMAIL_PATH, JAVAXMAIL_API_PATH, JAXB2_PATH, 
						 JCLOSLF4J_PATH, JSR305_PATH, JUNIT_PATH, LOGBACK_CORE_PATH, SAXON_PATH, SLF4J_API_PATH, SPRING_CORE_PATH, XMLRESOLVER_PATH);
		o.setOutDirectory(OUT_PATH);
		o.setSushiLibPath(SUSHI_LIB_PATH);
		o.setEvosuitePath(EVOSUITE_MOSA_PATH);
		o.setUseMOSA(true);
		o.setNumMOSATargets(2);
		o.setGlobalTimeBudgetDuration(timeBudgetDuration);
		o.setGlobalTimeBudgetUnit(timeBudgetTimeUnit);
		//o.setThrottleFactorEvosuite(1.0f);
		o.setEvosuiteTimeBudgetDuration(600);
	
		final Main m = new Main(o);
		m.start();
	}
}
