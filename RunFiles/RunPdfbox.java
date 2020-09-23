package settings;

import java.nio.file.Path;
import java.nio.file.Paths;

import java.io.IOException;
import java.util.concurrent.TimeUnit;

import tardis.Main;
import tardis.Options;

public class RunPdfbox {

	public static final Path TARDIS_WORKSPACE      = Paths.get("/home", "ubuntu", "tardisFolder", "tardisProva", "tardis");
    public static final Path SUBJECT_ROOT          = Paths.get("/home", "ubuntu", "tardisFolder", "tardisExperiments", "bin", "TARDISBenchmarks-junitcontest", "pdfbox");
    public static final Path Z3_PATH               = Paths.get("/home", "ubuntu", "bin", "z3");
    
    public static final Path JBSE_PATH             = TARDIS_WORKSPACE.resolve(Paths.get("jbse", "build", "classes", "java", "main"));
    public static final Path EVOSUITE_PATH         = TARDIS_WORKSPACE.resolve(Paths.get("lib", "evosuite-shaded-1.0.3.jar"));
	public static final Path EVOSUITE_MOSA_PATH    = TARDIS_WORKSPACE.resolve(Paths.get("lib", "evosuite-shaded-1.0.6-SNAPSHOT.jar"));
	public static final Path SUSHI_LIB_PATH        = TARDIS_WORKSPACE.resolve(Paths.get("runtime", "build", "classes", "java", "main"));
    
    public static final Path TMP_BASE_PATH         = SUBJECT_ROOT.resolve(Paths.get("tardis-tmp"));
    public static final Path OUT_PATH              = SUBJECT_ROOT.resolve(Paths.get("tardis-test"));

    public static final Path SUBJECT_PATH          = SUBJECT_ROOT.resolve(Paths.get("pdfbox", "target", "classes"));
    public static final Path BCPKIX_PATH           = SUBJECT_ROOT.resolve(Paths.get("dependencies", "bcpkix-jdk15on-1.60.jar"));
    public static final Path BCPROV_ANNO_PATH      = SUBJECT_ROOT.resolve(Paths.get("dependencies", "bcprov-jdk15on-1.60.jar"));
    public static final Path DIFFUTILS_API_PATH    = SUBJECT_ROOT.resolve(Paths.get("dependencies", "diffutils-1.3.0.jar"));
    public static final Path HAMCREST_PATH         = SUBJECT_ROOT.resolve(Paths.get("dependencies", "hamcrest-core-1.3.jar"));
    public static final Path JBIG2_PATH            = SUBJECT_ROOT.resolve(Paths.get("dependencies", "jbig2-imageio-3.0.3.jar"));
    public static final Path JAI_CORE_PATH         = SUBJECT_ROOT.resolve(Paths.get("dependencies", "jai-imageio-core-1.4.0.jar"));
    public static final Path JAI_JPEG_PATH         = SUBJECT_ROOT.resolve(Paths.get("dependencies", "jai-imageio-jpeg2000-1.3.0.jar"));
    public static final Path JUNIT_PATH            = SUBJECT_ROOT.resolve(Paths.get("dependencies", "junit-4.12.jar"));
    public static final Path FONTBOX_PATH          = SUBJECT_ROOT.resolve(Paths.get("dependencies", "fontbox-2.0.18.jar"));
    public static final Path BCMAIL_PATH           = SUBJECT_ROOT.resolve(Paths.get("dependencies", "bcmail-jdk15on-1.60.jar"));
    public static final Path COMMONS_PATH          = SUBJECT_ROOT.resolve(Paths.get("dependencies", "commons-logging-1.2.jar"));

    public static final String TARGET_CLASS_8      = "org/apache/pdfbox/pdmodel/font/FileSystemFontProvider";
    public static final String TARGET_CLASS_22     = "org/apache/pdfbox/pdmodel/fdf/FDFAnnotationCaret";
    public static final String TARGET_CLASS_26     = "org/apache/pdfbox/pdmodel/encryption/SecurityProvider";
    public static final String TARGET_CLASS_40     = "org/apache/pdfbox/pdmodel/font/PDCIDFontType2";
    public static final String TARGET_CLASS_62     = "org/apache/pdfbox/rendering/PageDrawer";
    public static final String TARGET_CLASS_83     = "org/apache/pdfbox/contentstream/operator/text/SetTextRenderingMode";
    public static final String TARGET_CLASS_91     = "org/apache/pdfbox/pdmodel/documentinterchange/taggedpdf/PDArtifactMarkedContent";
    public static final String TARGET_CLASS_117    = "org/apache/pdfbox/filter/Predictor";
    public static final String TARGET_CLASS_127    = "org/apache/pdfbox/pdfparser/PDFObjectStreamParser";
    public static final String TARGET_CLASS_130    = "org/apache/pdfbox/pdmodel/interactive/digitalsignature/visible/PDVisibleSignDesigner";
    public static final String TARGET_CLASS_157    = "org/apache/pdfbox/pdmodel/font/PDType1Font";
    public static final String TARGET_CLASS_198    = "org/apache/pdfbox/pdmodel/fdf/FDFAnnotationLine";
    public static final String TARGET_CLASS_214    = "org/apache/pdfbox/pdfparser/EndstreamOutputStream";
    public static final String TARGET_CLASS_220    = "org/apache/pdfbox/filter/JPXFilter";
    public static final String TARGET_CLASS_229    = "org/apache/pdfbox/util/XMLUtil";
    public static final String TARGET_CLASS_234    = "org/apache/pdfbox/pdmodel/interactive/action/PDActionSound";
    public static final String TARGET_CLASS_235    = "org/apache/pdfbox/pdmodel/font/PDTrueTypeFontEmbedder";
    public static final String TARGET_CLASS_265    = "org/apache/pdfbox/pdmodel/font/PDType3Font";
    public static final String TARGET_CLASS_278    = "org/apache/pdfbox/pdfwriter/ContentStreamWriter";
    public static final String TARGET_CLASS_285    = "org/apache/pdfbox/pdmodel/interactive/digitalsignature/PDSignature";

	public static void main(String[] s) throws IOException {
		final int maxDepth = 1000;
		final int numOfThreads = 2;
		final long timeBudgetDuration = 10;
		final TimeUnit timeBudgetTimeUnit = TimeUnit.MINUTES;
		
		final Options o = new Options();
		o.setTargetClass(TARGET_CLASS_22);
		o.setMaxDepth(maxDepth);
		o.setNumOfThreads(numOfThreads);
		o.setTmpDirectoryBase(TMP_BASE_PATH);
		o.setZ3Path(Z3_PATH);
		o.setJBSELibraryPath(JBSE_PATH);
		o.setClassesPath(SUBJECT_PATH, BCPKIX_PATH, BCPROV_ANNO_PATH, DIFFUTILS_API_PATH, HAMCREST_PATH, JBIG2_PATH, JAI_CORE_PATH, JAI_JPEG_PATH,
				JUNIT_PATH, FONTBOX_PATH, BCMAIL_PATH, COMMONS_PATH);
		o.setOutDirectory(OUT_PATH);
		o.setSushiLibPath(SUSHI_LIB_PATH);
		o.setEvosuitePath(EVOSUITE_MOSA_PATH);
		o.setUseMOSA(true);
		o.setNumMOSATargets(2);
		o.setGlobalTimeBudgetDuration(timeBudgetDuration);
		o.setGlobalTimeBudgetUnit(timeBudgetTimeUnit);
		//o.setThrottleFactorEvosuite(1.0f);
		o.setEvosuiteTimeBudgetDuration(120);
        o.setMaxSimpleArrayLength(600_000);
	
		final Main m = new Main(o);
		m.start();
	}
}