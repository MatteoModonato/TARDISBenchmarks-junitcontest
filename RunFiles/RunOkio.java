package settings;

import java.nio.file.Path;
import java.nio.file.Paths;
import java.io.IOException;
import java.util.Arrays;
import java.util.concurrent.TimeUnit;
import org.apache.logging.log4j.Level;
import tardis.Main;
import tardis.Options;

public class RunOkio {

	public static final Path TARDIS_WORKSPACE      = Paths.get("/home", "ubuntu", "tardisFolder", "tardisProva", "tardis");
	public static final Path SUBJECT_ROOT          = Paths.get("/home", "ubuntu", "tardisFolder", "tardisExperiments", "bin", "TARDISBenchmarks-junitcontest", "okio");
	public static final Path Z3_PATH               = Paths.get("/home", "ubuntu", "bin", "z3");
	
	public static final Path JBSE_PATH             = TARDIS_WORKSPACE.resolve(Paths.get("jbse", "build", "classes", "java", "main"));
	public static final Path EVOSUITE_MOSA_PATH    = TARDIS_WORKSPACE.resolve(Paths.get("lib", "evosuite-shaded-1.0.6-SNAPSHOT.jar"));
	public static final Path SUSHI_LIB_PATH        = TARDIS_WORKSPACE.resolve(Paths.get("runtime", "build", "classes", "java", "main"));
	
	public static final Path TMP_BASE_PATH         = SUBJECT_ROOT.resolve(Paths.get("tardis-tmp"));
	public static final Path OUT_PATH              = SUBJECT_ROOT.resolve(Paths.get("tardis-test"));

	public static final Path SUBJECT_PATH_1          = SUBJECT_ROOT.resolve(Paths.get("okio", "target", "classes"));
	public static final Path SUBJECT_PATH_2          = SUBJECT_ROOT.resolve(Paths.get("samples", "target", "classes"));
	public static final Path HAMCREST_CORE_PATH    = SUBJECT_ROOT.resolve(Paths.get("dependencies", "hamcrest-core-1.3.jar"));
	public static final Path JUNIT_PATH            = SUBJECT_ROOT.resolve(Paths.get("dependencies", "junit-4.11.jar"));
	public static final Path ANIMAL_SNIFFER_PATH   = SUBJECT_ROOT.resolve(Paths.get("dependencies", "animal-sniffer-annotations-1.10.jar"));
	public static final Path JSR_PATH              = SUBJECT_ROOT.resolve(Paths.get("dependencies", "jsr305-3.0.2.jar"));
	
	public static final String OKIO_1      = "okio/Buffer";
	public static final String OKIO_2      = "okio/ByteString";
	public static final String OKIO_3      = "okio/SegmentedByteString";
	public static final String OKIO_4      = "okio/RealBufferedSource";
	public static final String OKIO_5      = "okio/RealBufferedSink";
	public static final String OKIO_6      = "okio/Okio";
	public static final String OKIO_7      = "okio/Segment";
	public static final String OKIO_8      = "okio/AsyncTimeout";
	public static final String OKIO_9      = "okio/Utf8";
	public static final String OKIO_10     = "okio/Timeout";

	public static void main(String[] s) throws IOException {
		final int maxDepth = 1000;
		final long timeBudgetDuration = 10;
		final TimeUnit timeBudgetTimeUnit = TimeUnit.MINUTES;
		
		final Options o = new Options();
		o.setTargetClass(OKIO_1);
		o.setMaxDepth(maxDepth);
		o.setNumOfThreadsJBSE(5);
		o.setNumOfThreadsEvosuite(5);
		o.setMaxTestCaseDepth(25);
		o.setTmpDirectoryBase(TMP_BASE_PATH);
		o.setZ3Path(Z3_PATH);
		o.setJBSELibraryPath(JBSE_PATH);
		o.setClassesPath(SUBJECT_PATH_1, SUBJECT_PATH_2);
		o.setOutDirectory(OUT_PATH);
		o.setSushiLibPath(SUSHI_LIB_PATH);
		o.setEvosuitePath(EVOSUITE_MOSA_PATH);
		o.setNumMOSATargets(2);
		o.setGlobalTimeBudgetDuration(timeBudgetDuration);
		o.setGlobalTimeBudgetUnit(timeBudgetTimeUnit);
		o.setThrottleFactorEvosuite(0.0f);
		o.setEvosuiteTimeBudgetDuration(120);
		o.setVerbosity(Level.ALL);
		o.setEvosuiteNoDependency(true);
		o.setUninterpreted(
				Arrays.asList("java/lang/String", "(Ljava/lang/Object;)Z", "equals"),
				Arrays.asList("java/lang/String", "(Ljava/lang/CharSequence;)Z", "contains"),
				Arrays.asList("java/net/URLDecoder", "(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;", "decode")
				);
	
		final Main m = new Main(o);
		m.start();
	}
}
