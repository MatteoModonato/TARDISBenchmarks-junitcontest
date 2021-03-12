package settings;

import java.nio.file.Path;
import java.nio.file.Paths;
import java.io.IOException;
import java.util.Arrays;
import java.util.concurrent.TimeUnit;
import org.apache.logging.log4j.Level;
import tardis.Main;
import tardis.Options;

public class RunBcel {

	public static final Path TARDIS_WORKSPACE      = Paths.get("/home", "ubuntu", "tardisFolder", "tardisProva", "tardis");
	public static final Path SUBJECT_ROOT          = Paths.get("/home", "ubuntu", "tardisFolder", "tardisExperiments", "bin", "TARDISBenchmarks-junitcontest", "bcel-6.0-src");
	public static final Path Z3_PATH               = Paths.get("/home", "ubuntu", "bin", "z3");
	
	public static final Path JBSE_PATH             = TARDIS_WORKSPACE.resolve(Paths.get("jbse", "build", "classes", "java", "main"));
	public static final Path EVOSUITE_MOSA_PATH    = TARDIS_WORKSPACE.resolve(Paths.get("lib", "evosuite-shaded-1.0.6-SNAPSHOT.jar"));
	public static final Path SUSHI_LIB_PATH        = TARDIS_WORKSPACE.resolve(Paths.get("runtime", "build", "classes", "java", "main"));
	
	public static final Path TMP_BASE_PATH         = SUBJECT_ROOT.resolve(Paths.get("tardis-tmp"));
	public static final Path OUT_PATH              = SUBJECT_ROOT.resolve(Paths.get("tardis-test"));

	public static final Path SUBJECT_PATH          = SUBJECT_ROOT.resolve(Paths.get("target", "classes"));
	public static final Path HAMCREST_CORE_PATH    = SUBJECT_ROOT.resolve(Paths.get("dependencies", "hamcrest-core-1.3.jar"));
	public static final Path JUNIT_PATH            = SUBJECT_ROOT.resolve(Paths.get("dependencies", "junit-4.12.jar"));
	public static final Path JNA_PATH              = SUBJECT_ROOT.resolve(Paths.get("dependencies", "jna-4.2.2.jar"));
	public static final Path JNAP_PATH             = SUBJECT_ROOT.resolve(Paths.get("dependencies", "jna-platform-4.2.2.jar"));
	public static final Path CLANG_PATH            = SUBJECT_ROOT.resolve(Paths.get("dependencies", "commons-lang3-3.4.jar"));
	
	public static final String BCEL_1      = "org/apache/bcel/classfile/Utility";
	public static final String BCEL_2      = "org/apache/bcel/verifier/structurals/InstConstraintVisitor";
	public static final String BCEL_3      = "org/apache/bcel/generic/ConstantPoolGen";
	public static final String BCEL_4      = "org/apache/bcel/generic/InstructionList";
	public static final String BCEL_5      = "org/apache/bcel/verifier/statics/Pass3aVerifier";
	public static final String BCEL_6      = "org/apache/bcel/verifier/structurals/LocalVariables";
	public static final String BCEL_7      = "org/apache/bcel/util/Class2HTML";
	public static final String BCEL_8      = "org/apache/bcel/generic/BranchInstruction";
	public static final String BCEL_9      = "org/apache/bcel/classfile/StackMapEntry";
	public static final String BCEL_10     = "org/apache/bcel/verifier/structurals/Subroutines";

	public static void main(String[] s) throws IOException {
		final int maxDepth = 1000;
		final long timeBudgetDuration = 10;
		final TimeUnit timeBudgetTimeUnit = TimeUnit.MINUTES;
		
		final Options o = new Options();
		o.setTargetClass(BCEL_1);
		o.setMaxDepth(maxDepth);
		o.setNumOfThreadsJBSE(5);
		o.setNumOfThreadsEvosuite(5);
		o.setMaxTestCaseDepth(25);
		o.setTmpDirectoryBase(TMP_BASE_PATH);
		o.setZ3Path(Z3_PATH);
		o.setJBSELibraryPath(JBSE_PATH);
		o.setClassesPath(SUBJECT_PATH);
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
