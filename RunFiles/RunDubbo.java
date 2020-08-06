package settings;

import java.nio.file.Path;
import java.nio.file.Paths;

import java.io.IOException;
import java.util.concurrent.TimeUnit;

import tardis.Main;
import tardis.Options;

public class RunDubbo {

	public static final Path TARDIS_WORKSPACE      = Paths.get("/home", "ubuntu", "tardisFolder", "tardisProva", "tardis");
    public static final Path SUBJECT_ROOT          = Paths.get("/home", "ubuntu", "tardisFolder", "tardisExperiments", "bin", "TARDISBenchmarks-junitcontest", "dubbo");
    public static final Path Z3_PATH               = Paths.get("/home", "ubuntu", "bin", "z3");
    
    public static final Path JBSE_PATH             = TARDIS_WORKSPACE.resolve(Paths.get("jbse", "build", "classes", "java", "main"));
    public static final Path EVOSUITE_PATH         = TARDIS_WORKSPACE.resolve(Paths.get("lib", "evosuite-shaded-1.0.3.jar"));
	public static final Path EVOSUITE_MOSA_PATH    = TARDIS_WORKSPACE.resolve(Paths.get("lib", "evosuite-shaded-1.0.6-SNAPSHOT.jar"));
	public static final Path SUSHI_LIB_PATH        = TARDIS_WORKSPACE.resolve(Paths.get("runtime", "build", "classes", "java", "main"));
    
    public static final Path TMP_BASE_PATH         = SUBJECT_ROOT.resolve(Paths.get("tardis-tmp"));
    public static final Path OUT_PATH              = SUBJECT_ROOT.resolve(Paths.get("tardis-test"));

    public static final Path SUBJECT_PATH_1        = SUBJECT_ROOT.resolve(Paths.get("dubbo-common", "target", "classes"));
    public static final Path SUBJECT_PATH_2        = SUBJECT_ROOT.resolve(Paths.get("hessian-lite", "target", "classes"));
    public static final Path CGLIB_CORE_PATH       = SUBJECT_ROOT.resolve(Paths.get("dependencies", "cglib-nodep-2.2.jar"));
    public static final Path JMOCKIT_CORE_PATH     = SUBJECT_ROOT.resolve(Paths.get("dependencies", "jmockit-1.33.jar"));
    public static final Path EASYMOCK_CORE_PATH    = SUBJECT_ROOT.resolve(Paths.get("dependencies", "easymock-3.4.jar"));
    public static final Path HAMCREST_CORE_PATH    = SUBJECT_ROOT.resolve(Paths.get("dependencies", "hamcrest-core-1.3.jar"));
    public static final Path JSON_IO_PATH          = SUBJECT_ROOT.resolve(Paths.get("dependencies", "json-io-2.5.1.jar"));
    public static final Path JAVA_UTIL_PATH        = SUBJECT_ROOT.resolve(Paths.get("dependencies", "java-util-1.9.0.jar"));
    public static final Path JACKSON_PATH          = SUBJECT_ROOT.resolve(Paths.get("dependencies", "jackson-core-2.8.6.jar"));
    public static final Path FST_PATH              = SUBJECT_ROOT.resolve(Paths.get("dependencies", "fst-2.48-jdk-6.jar"));
    public static final Path KRYO_PATH             = SUBJECT_ROOT.resolve(Paths.get("dependencies", "kryo-serializers-0.42.jar"));
    public static final Path OBJENESIS_PATH        = SUBJECT_ROOT.resolve(Paths.get("dependencies", "objenesis-2.5.1.jar"));
    public static final Path MINLOG_PATH           = SUBJECT_ROOT.resolve(Paths.get("dependencies", "minlog-1.3.0.jar"));
    public static final Path ASM_PATH              = SUBJECT_ROOT.resolve(Paths.get("dependencies", "asm-5.0.4.jar"));
    public static final Path REFLECTASM_PATH       = SUBJECT_ROOT.resolve(Paths.get("dependencies", "reflectasm-1.11.3.jar"));
    public static final Path KTYO_PATH             = SUBJECT_ROOT.resolve(Paths.get("dependencies", "kryo-4.0.1.jar"));
    public static final Path JUNIT_PATH            = SUBJECT_ROOT.resolve(Paths.get("dependencies", "junit-4.12.jar"));
    public static final Path FASTJSON_PATH         = SUBJECT_ROOT.resolve(Paths.get("dependencies", "fastjson-1.2.31.jar"));
    public static final Path JAVASSIST_PATH        = SUBJECT_ROOT.resolve(Paths.get("dependencies", "javassist-3.20.0-GA.jar"));
    public static final Path LOG4J_PATH            = SUBJECT_ROOT.resolve(Paths.get("dependencies", "log4j-1.2.16.jar"));
    public static final Path CLOGGING_PATH         = SUBJECT_ROOT.resolve(Paths.get("dependencies", "commons-logging-1.2.jar"));
    public static final Path SLF4J_PATH            = SUBJECT_ROOT.resolve(Paths.get("dependencies", "slf4j-api-1.7.25.jar"));
    
    public static final String TARGET_CLASS_2      = "com/alibaba/dubbo/common/utils/ReflectUtils";
    public static final String TARGET_CLASS_3      = "com/alibaba/dubbo/common/utils/StringUtils";
    public static final String TARGET_CLASS_4      = "com/alibaba/dubbo/common/utils/ClassHelper";
    public static final String TARGET_CLASS_5      = "com/alibaba/dubbo/common/io/UnsafeByteArrayOutputStream";
    public static final String TARGET_CLASS_6      = "com/alibaba/dubbo/common/utils/CompatibleTypeUtils";
    public static final String TARGET_CLASS_7      = "com/alibaba/dubbo/common/beanutil/JavaBeanDescriptor";
    public static final String TARGET_CLASS_8      = "com/alibaba/dubbo/common/Parameters";
    public static final String TARGET_CLASS_9      = "com/alibaba/dubbo/common/io/Bytes";
    public static final String TARGET_CLASS_10     = "com/alibaba/dubbo/common/bytecode/Wrapper";

	public static void main(String[] s) throws IOException {
		final int maxDepth = 1000;
		final int numOfThreads = 2;
		final long timeBudgetDuration = 10;
		final TimeUnit timeBudgetTimeUnit = TimeUnit.MINUTES;
		
		final Options o = new Options();
		o.setTargetClass(TARGET_CLASS_2);
		o.setMaxDepth(maxDepth);
		o.setNumOfThreads(numOfThreads);
		o.setTmpDirectoryBase(TMP_BASE_PATH);
		o.setZ3Path(Z3_PATH);
		o.setJBSELibraryPath(JBSE_PATH);
		o.setClassesPath(SUBJECT_PATH_1, SUBJECT_PATH_2, CGLIB_CORE_PATH, JMOCKIT_CORE_PATH, EASYMOCK_CORE_PATH, HAMCREST_CORE_PATH, JSON_IO_PATH, JAVA_UTIL_PATH, JUNIT_PATH,
				JACKSON_PATH, FST_PATH, KRYO_PATH, OBJENESIS_PATH, MINLOG_PATH, ASM_PATH, REFLECTASM_PATH, KTYO_PATH, FASTJSON_PATH, JAVASSIST_PATH, LOG4J_PATH,
				CLOGGING_PATH, SLF4J_PATH);
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
