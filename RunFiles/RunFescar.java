package settings;

import java.nio.file.Path;
import java.nio.file.Paths;

import java.io.IOException;
import java.util.concurrent.TimeUnit;

import tardis.Main;
import tardis.Options;

public class RunFescar {

	public static final Path TARDIS_WORKSPACE      = Paths.get("/home", "ubuntu", "tardisFolder", "tardisProva", "tardis");
    public static final Path SUBJECT_ROOT          = Paths.get("/home", "ubuntu", "tardisFolder", "tardisExperiments", "bin", "TARDISBenchmarks-junitcontest", "fescar");
    public static final Path Z3_PATH               = Paths.get("/home", "ubuntu", "bin", "z3");
    
    public static final Path JBSE_PATH             = TARDIS_WORKSPACE.resolve(Paths.get("jbse", "build", "classes", "java", "main"));
    public static final Path EVOSUITE_PATH         = TARDIS_WORKSPACE.resolve(Paths.get("lib", "evosuite-shaded-1.0.3.jar"));
	public static final Path EVOSUITE_MOSA_PATH    = TARDIS_WORKSPACE.resolve(Paths.get("lib", "evosuite-shaded-1.0.6-SNAPSHOT.jar"));
	public static final Path SUSHI_LIB_PATH        = TARDIS_WORKSPACE.resolve(Paths.get("runtime", "build", "classes", "java", "main"));
    
    public static final Path TMP_BASE_PATH         = SUBJECT_ROOT.resolve(Paths.get("tardis-tmp"));
    public static final Path OUT_PATH              = SUBJECT_ROOT.resolve(Paths.get("tardis-test"));

    public static final Path SUBJECT_PATH_1        = SUBJECT_ROOT.resolve(Paths.get("core", "target", "classes"));
    public static final Path SUBJECT_PATH_2        = SUBJECT_ROOT.resolve(Paths.get("common", "target", "classes"));
    public static final Path SUBJECT_PATH_3        = SUBJECT_ROOT.resolve(Paths.get("config", "target", "classes"));
    public static final Path CONFIG_PATH           = SUBJECT_ROOT.resolve(Paths.get("dependencies", "config-1.2.1.jar"));
    public static final Path SLF4J_PATH            = SUBJECT_ROOT.resolve(Paths.get("dependencies", "slf4j-api-1.7.22.jar"));
    public static final Path LOGBACK_PATH          = SUBJECT_ROOT.resolve(Paths.get("dependencies", "logback-classic-1.1.6.jar"));
    public static final Path NETTY_TR_PATH         = SUBJECT_ROOT.resolve(Paths.get("dependencies", "netty-transport-native-unix-common-4.1.24.Final.jar"));
    public static final Path NETTY_RE_PATH         = SUBJECT_ROOT.resolve(Paths.get("dependencies", "netty-resolver-4.1.24.Final.jar"));
    public static final Path JUNIT_PATH            = SUBJECT_ROOT.resolve(Paths.get("dependencies", "junit-4.12.jar"));
    public static final Path POOL_PATH             = SUBJECT_ROOT.resolve(Paths.get("dependencies", "commons-pool-1.6.jar"));
    public static final Path NETTY_BU_PATH         = SUBJECT_ROOT.resolve(Paths.get("dependencies", "netty-buffer-4.1.24.Final.jar"));
    public static final Path NETTY_TR2_PATH        = SUBJECT_ROOT.resolve(Paths.get("dependencies", "netty-transport-native-epoll-4.1.24.Final-linux-x86_64.jar"));
    public static final Path NETTY_ALL_PATH        = SUBJECT_ROOT.resolve(Paths.get("dependencies", "netty-all-4.1.24.Final.jar"));
    public static final Path HAMCREST_CORE_PATH    = SUBJECT_ROOT.resolve(Paths.get("dependencies", "hamcrest-core-1.3.jar"));
    public static final Path FESCAR_CONF_PATH      = SUBJECT_ROOT.resolve(Paths.get("dependencies", "fescar-config-0.1.0-SNAPSHOT.jar"));
    public static final Path LOGBACK_CORE_PATH     = SUBJECT_ROOT.resolve(Paths.get("dependencies", "logback-core-1.1.6.jar"));
    public static final Path COMMONS_LANG_PATH     = SUBJECT_ROOT.resolve(Paths.get("dependencies", "commons-lang-2.6.jar"));
    public static final Path FESCAR_COMM_PATH      = SUBJECT_ROOT.resolve(Paths.get("dependencies", "fescar-common-0.1.0-SNAPSHOT.jar"));
    public static final Path FASTJSON_PATH         = SUBJECT_ROOT.resolve(Paths.get("dependencies", "fastjson-1.2.48.jar"));
    public static final Path NETTY_CO_PATH         = SUBJECT_ROOT.resolve(Paths.get("dependencies", "netty-common-4.1.24.Final.jar"));
    public static final Path NETTY_TR3_PATH        = SUBJECT_ROOT.resolve(Paths.get("dependencies", "netty-transport-4.1.24.Final.jar"));
    public static final Path POOL2_PATH            = SUBJECT_ROOT.resolve(Paths.get("dependencies", "commons-pool2-2.4.2.jar"));
    public static final Path NETTY_TR4_PATH        = SUBJECT_ROOT.resolve(Paths.get("dependencies", "netty-transport-native-kqueue-4.1.24.Final-osx-x86_64.jar"));
    
    public static final String TARGET_CLASS_1      = "com/alibaba/fescar/core/protocol/transaction/BranchReportRequest";
    public static final String TARGET_CLASS_12     = "com/alibaba/fescar/core/rpc/netty/RpcServerHandler";
    public static final String TARGET_CLASS_18     = "com/alibaba/fescar/core/protocol/MergedWarpMessage";
    public static final String TARGET_CLASS_23     = "com/alibaba/fescar/core/protocol/MergeResultMessage";
    public static final String TARGET_CLASS_25     = "com/alibaba/fescar/core/rpc/netty/RmMessageListener";
    public static final String TARGET_CLASS_36     = "com/alibaba/fescar/core/protocol/RegisterRMRequest";
    public static final String TARGET_CLASS_37     = "com/alibaba/fescar/core/rpc/RpcContext";
    public static final String TARGET_CLASS_41     = "com/alibaba/fescar/core/rpc/netty/RmRpcClient";
    public static final String TARGET_CLASS_42     = "com/alibaba/fescar/core/rpc/DefaultServerMessageListenerImpl";
    public static final String TARGET_CLASS_7      = "com/alibaba/fescar/core/rpc/netty/MessageCodecHandler";
    public static final String TARGET_CLASS_2      = "com/alibaba/fescar/core/service/ServiceManagerStaticConfigImpl";
    public static final String TARGET_CLASS_5      = "com/alibaba/fescar/core/protocol/MessageFuture";
    public static final String TARGET_CLASS_6      = "com/alibaba/fescar/core/rpc/netty/TmRpcClient";
    public static final String TARGET_CLASS_8      = "com/alibaba/fescar/core/rpc/netty/NettyPoolableFactory";
    public static final String TARGET_CLASS_9      = "com/alibaba/fescar/core/protocol/transaction/GlobalBeginRequest";
    public static final String TARGET_CLASS_10     = "com/alibaba/fescar/core/model/BranchType";
    public static final String TARGET_CLASS_13     = "com/alibaba/fescar/core/exception/TransactionExceptionCode";
    public static final String TARGET_CLASS_15     = "com/alibaba/fescar/core/rpc/netty/RpcServer";
    public static final String TARGET_CLASS_17     = "com/alibaba/fescar/core/protocol/transaction/GlobalBeginResponse";
    public static final String TARGET_CLASS_28     = "com/alibaba/fescar/core/rpc/ClientType";
    public static final String TARGET_CLASS_32     = "com/alibaba/fescar/core/protocol/transaction/BranchRegisterRequest";
    public static final String TARGET_CLASS_33     = "com/alibaba/fescar/core/model/GlobalStatus";
    public static final String TARGET_CLASS_34     = "com/alibaba/fescar/core/protocol/ResultCode";

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
		o.setClassesPath(SUBJECT_PATH_1, SUBJECT_PATH_2, SUBJECT_PATH_3, CONFIG_PATH, SLF4J_PATH, LOGBACK_PATH, NETTY_TR_PATH, NETTY_RE_PATH, JUNIT_PATH,
				POOL_PATH, NETTY_BU_PATH, NETTY_TR2_PATH, NETTY_ALL_PATH, HAMCREST_CORE_PATH, FESCAR_CONF_PATH, LOGBACK_CORE_PATH, COMMONS_LANG_PATH,
				FESCAR_COMM_PATH, FASTJSON_PATH, NETTY_CO_PATH, NETTY_TR3_PATH, POOL2_PATH, NETTY_TR4_PATH);
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