import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Scanner;

public class CalculateResults {

	public static void main(String[] args) {

		//args[0]: Tardis log path, args[1]: Output csv path, args[3]: Benckmark
		String path = args[0];
		File file = new File(path);
		String pathOut = args[1];
		File fileOut = new File(pathOut);
		String benchmark = args[2];
		int seedTest = 0;
		int test =0;
		int infeasible = 0;
		int alternative = 0;
		int noAlternative = 0;
		int lastIndex= 0;
		String coverage = null;

		try {
			Scanner scanner = new Scanner(file);
			int lineNum = 0;
			while (scanner.hasNextLine()) {
				String line = scanner.nextLine();
				lineNum++;
				if(line.contains("depth: -1")) { 
					++seedTest;
				}
				if(line.contains("[EVOSUITE] Generated test case")) { 
					++test;
				}
				if(line.contains("[EVOSUITE] Failed to generate a test case")) { 
					++infeasible;
				}
				if(line.contains("[JBSE    ] From test case")) { 
					++alternative;
				}
				if(line.contains("no path condition generated")) { 
					++noAlternative;
				}
				if (line.contains("[JBSE    ] Current coverage")) {
					lastIndex = lineNum;
					coverage = line.substring(28).replace(",", " -");
				}
			}
		} catch(FileNotFoundException e) { 
			//handle this
		}

		try(FileWriter fw = new FileWriter(fileOut, true);
				BufferedWriter bw = new BufferedWriter(fw);
				PrintWriter out = new PrintWriter(bw)) {
			if (lastIndex == 0) {
				coverage = "/";
			}
			if (fileOut.length()==0) { 
				out.println("Benchmark,TARDIS seed tests,Tot analyzed PC,TARDIS tests,InfeasiblePC,TotAlternativePC,JBSE Coverage");
				out.println(benchmark+","+seedTest+","+((test-seedTest)+infeasible)+","+(test-seedTest)+","+infeasible+","+(alternative-noAlternative)+","+coverage);
			}
			else {
				out.println(benchmark+","+seedTest+","+((test-seedTest)+infeasible)+","+(test-seedTest)+","+infeasible+","+(alternative-noAlternative)+","+coverage);
			}
		} 
		catch (IOException e) {
			//handle this
		}

	}

}
