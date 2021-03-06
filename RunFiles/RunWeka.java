package settings;

import java.nio.file.Path;
import java.nio.file.Paths;
import java.io.IOException;
import java.util.Arrays;
import java.util.concurrent.TimeUnit;
import org.apache.logging.log4j.Level;
import tardis.Main;
import tardis.Options;

public class RunWeka {

	public static final Path TARDIS_WORKSPACE      = Paths.get("/home", "ubuntu", "tardisFolder", "tardisProva", "tardis");
	public static final Path SUBJECT_ROOT          = Paths.get("/home", "ubuntu", "tardisFolder", "tardisExperiments", "bin", "TARDISBenchmarks-junitcontest", "weka");
	public static final Path Z3_PATH               = Paths.get("/home", "ubuntu", "bin", "z3");
	
	public static final Path JBSE_PATH             = TARDIS_WORKSPACE.resolve(Paths.get("jbse", "build", "classes", "java", "main"));
	public static final Path EVOSUITE_MOSA_PATH    = TARDIS_WORKSPACE.resolve(Paths.get("lib", "evosuite-shaded-1.0.6-SNAPSHOT.jar"));
	public static final Path SUSHI_LIB_PATH        = TARDIS_WORKSPACE.resolve(Paths.get("runtime", "build", "classes", "java", "main"));
	
	public static final Path TMP_BASE_PATH         = SUBJECT_ROOT.resolve(Paths.get("tardis-tmp"));
	public static final Path OUT_PATH              = SUBJECT_ROOT.resolve(Paths.get("tardis-test"));

	public static final Path SUBJECT_PATH          = SUBJECT_ROOT.resolve(Paths.get("dist", "weka-stable-3.8.5-SNAPSHOT.jar"));

	public static final String WEKA_673  = "weka/classifiers/functions/MultilayerPerceptron";
	public static final String WEKA_460  = "weka/classifiers/pmml/consumer/TreeModel";
	public static final String WEKA_983  = "weka/classifiers/bayes/net/EditableBayesNet";
	public static final String WEKA_741  = "weka/classifiers/bayes/net/search/local/HillClimber";
	public static final String WEKA_148  = "weka/classifiers/ParallelMultipleClassifiersCombiner";
	public static final String WEKA_53   = "weka/gui/SetInstancesPanel";
	public static final String WEKA_303  = "weka/classifiers/rules/RuleStats";
	public static final String WEKA_1093 = "weka/classifiers/bayes/net/estimate/MultiNomialBMAEstimator";
	public static final String WEKA_1127 = "weka/clusterers/EM";
	public static final String WEKA_128  = "weka/gui/sql/QueryPanel";
	public static final String WEKA_119  = "weka/gui/graphvisualizer/GraphVisualizer";
	public static final String WEKA_302  = "weka/gui/LogWindow";
	public static final String WEKA_576  = "weka/gui/beans/Classifier";
	public static final String WEKA_631  = "weka/gui/beans/FlowByExpressionCustomizer";
	public static final String WEKA_7    = "weka/gui/beans/ClustererPerformanceEvaluator";
	public static final String WEKA_592  = "weka/gui/beans/SubstringLabelerCustomizer";
	public static final String WEKA_871  = "weka/core/matrix/FloatingPointFormat";
	public static final String WEKA_79   = "weka/core/OptionHandlerJavadoc";
	public static final String WEKA_763  = "weka/classifiers/trees/ht/GaussianConditionalSufficientStats";
	public static final String WEKA_1088 = "weka/gui/beans/Associator";
	public static final String WEKA_1006 = "weka/gui/beans/Saver";
	public static final String WEKA_563  = "weka/associations/FPGrowth";
	public static final String WEKA_151  = "weka/core/neighboursearch/NearestNeighbourSearch";
	public static final String WEKA_143  = "weka/knowledgeflow/FlowRunner";
	public static final String WEKA_577  = "weka/clusterers/SimpleKMeans";

	public static void main(String[] s) throws IOException {
		final int maxDepth = 1000;
		final long timeBudgetDuration = 20;
		final TimeUnit timeBudgetTimeUnit = TimeUnit.MINUTES;
		
		final Options o = new Options();
		o.setTargetClass(WEKA_673);
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
		o.setEvosuiteTimeBudgetDuration(600);
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
