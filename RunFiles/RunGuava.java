package settings;

import java.nio.file.Path;
import java.nio.file.Paths;

import java.io.IOException;
import java.util.concurrent.TimeUnit;

import tardis.Main;
import tardis.Options;

public class RunGuava {

	public static final Path TARDIS_WORKSPACE      = Paths.get("/home", "ubuntu", "tardisFolder", "tardisProva", "tardis");
    public static final Path SUBJECT_ROOT          = Paths.get("/home", "ubuntu", "tardisFolder", "tardisExperiments", "bin", "TARDISBenchmarks-junitcontest", "guava");
    public static final Path Z3_PATH               = Paths.get("/home", "ubuntu", "bin", "z3");
    
    public static final Path JBSE_PATH             = TARDIS_WORKSPACE.resolve(Paths.get("jbse", "build", "classes", "java", "main"));
    public static final Path EVOSUITE_PATH         = TARDIS_WORKSPACE.resolve(Paths.get("lib", "evosuite-shaded-1.0.3.jar"));
	public static final Path EVOSUITE_MOSA_PATH    = TARDIS_WORKSPACE.resolve(Paths.get("lib", "evosuite-shaded-1.0.6-SNAPSHOT.jar"));
	public static final Path SUSHI_LIB_PATH        = TARDIS_WORKSPACE.resolve(Paths.get("runtime", "build", "classes", "java", "main"));
    
    public static final Path TMP_BASE_PATH         = SUBJECT_ROOT.resolve(Paths.get("tardis-tmp"));
    public static final Path OUT_PATH              = SUBJECT_ROOT.resolve(Paths.get("tardis-test"));

    public static final Path SUBJECT_PATH          = SUBJECT_ROOT.resolve(Paths.get("guava", "target", "classes"));
    public static final Path ACTIVATION_PATH       = SUBJECT_ROOT.resolve(Paths.get("dependencies", "j2objc-annotations-1.3.jar"));
    public static final Path J2OBJC_PATH           = SUBJECT_ROOT.resolve(Paths.get("dependencies", "error_prone_annotations-2.3.4.jar"));
    public static final Path CHECKER_PATH          = SUBJECT_ROOT.resolve(Paths.get("dependencies", "checker-qual-2.10.0.jar"));
    public static final Path JSR305_PATH           = SUBJECT_ROOT.resolve(Paths.get("dependencies", "jsr305-3.0.2.jar"));
    public static final Path LIST_PATH             = SUBJECT_ROOT.resolve(Paths.get("dependencies", "listenablefuture-9999.0-empty-to-avoid-conflict-with-guava.jar"));
    public static final Path FAILUREACCESS_PATH    = SUBJECT_ROOT.resolve(Paths.get("dependencies", "failureaccess-1.0.1.jar"));

    public static final String TARGET_CLASS_2      = "com/google/common/collect/MinMaxPriorityQueue";
    public static final String TARGET_CLASS_22     = "com/google/common/graph/Graphs";
    public static final String TARGET_CLASS_39     = "com/google/common/collect/TreeMultiset";
    public static final String TARGET_CLASS_47     = "com/google/common/collect/FilteredEntryMultimap";
    public static final String TARGET_CLASS_90     = "com/google/common/io/FileBackedOutputStream";
    public static final String TARGET_CLASS_95     = "com/google/common/collect/ComparatorOrdering";
    public static final String TARGET_CLASS_102    = "com/google/common/collect/LinkedListMultimap";
    public static final String TARGET_CLASS_110    = "com/google/common/collect/LexicographicalOrdering";
    public static final String TARGET_CLASS_128    = "com/google/common/base/Throwables";
    public static final String TARGET_CLASS_129    = "com/google/common/collect/SparseImmutableTable";
    public static final String TARGET_CLASS_159    = "com/google/common/primitives/ParseRequest";
    public static final String TARGET_CLASS_169    = "com/google/common/math/LongMath";
    public static final String TARGET_CLASS_177    = "com/google/common/primitives/Doubles";
    public static final String TARGET_CLASS_181    = "com/google/common/primitives/SignedBytes";
    public static final String TARGET_CLASS_184    = "com/google/thirdparty/publicsuffix/PublicSuffixType";
    public static final String TARGET_CLASS_196    = "com/google/common/io/Closeables";
    public static final String TARGET_CLASS_206    = "com/google/common/collect/ImmutableEnumSet";
    public static final String TARGET_CLASS_212    = "com/google/common/net/MediaType";
    public static final String TARGET_CLASS_224    = "com/google/common/primitives/UnsignedLongs";
    public static final String TARGET_CLASS_240    = "com/google/common/collect/FilteredMultimapValues";

	public static void main(String[] s) throws IOException {
		final int maxDepth = 1000;
		final int numOfThreads = 2;
		final long timeBudgetDuration = 10;
		final TimeUnit timeBudgetTimeUnit = TimeUnit.MINUTES;
		
		final Options o = new Options();
		o.setTargetClass(TARGET_CLASS_129);
		o.setMaxDepth(maxDepth);
		o.setNumOfThreads(numOfThreads);
		o.setTmpDirectoryBase(TMP_BASE_PATH);
		o.setZ3Path(Z3_PATH);
		o.setJBSELibraryPath(JBSE_PATH);
		o.setClassesPath(SUBJECT_PATH, ACTIVATION_PATH, J2OBJC_PATH, CHECKER_PATH, JSR305_PATH, LIST_PATH, FAILUREACCESS_PATH);
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