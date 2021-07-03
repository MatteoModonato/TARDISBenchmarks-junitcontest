# TARDISBenchmarks-junitcontest

### Important information:
* Make sure you edit the paths indicated in the first comment lines of **TardisLauncher.sh**, **EvosuiteLauncher.sh**, **SushiLauncher.sh** and **CompileAndMove.sh** to have the repository ready to use ([TARDIS](https://github.com/pietrobraione/tardis) run files are automatically updated by scripts).
* Tested on Ubuntu 18.04.4 LTS.
* Run all scripts from the root folder of this repository.

Main requirements:
* Zip (tested with Zip 3.0)
* Unzip (tested with UnZip 6.00)
* Java (tested with java version "1.8.0_261")
* Maven (tested with Apache Maven 3.6.3)

### How to use the repository:
#### UnzipAndCompile.sh
First of all, run **UnzipAndCompile.sh** script to unzip and compile all benchmarks, compile all TARDIS configuration Files and move them in the correct folders.

#### TardisLauncher.sh
Run **TardisLauncher.sh** script to run TARDIS on a single program or on a multiple benchmarks. Pass the following parameters to set TARDIS configuration: 
* number of JBSE threads (-j)
* number of Evosuite threads (-e)
* number of mosa (-m)
* Evosuite time budget (-t)
* global time budget (-g)
* max test case depth (-d)
* throttle factor evosuite (-f)

Eg. `bash TardisLauncher.sh -j 5 -e 10 -m 5 -t 180 -g 20 -d 25 -f 0.0f`

The script computes the test suite metrics after each Tardis run.

#### EvosuiteLauncher.sh
Run **EvosuiteLauncher.sh** script to run Evosuite on a single program or on a multiple benchmarks. Pass the following parameter to set Evosuite configuration: 
* search budget (-s)

Eg. `bash EvosuiteLauncher.sh -s 120`

The script computes the test suite metrics after each Evosuite run.

#### SushiLauncher.sh
Run **SushiLauncher.sh** script to run [SUSHI](https://github.com/pietrobraione/sushi) on a single program or on a multiple benchmarks. Pass the following parameter to set SUSHI configuration: 
* number of Evosuite threads (-e)
* number of mosa (-m)
* Evosuite time budget (-t)
* global time budget (-g)

Eg. `bash SushiLauncher.sh -e 5 -m 10 -t 300 -g 1200`

The script computes the test suite metrics after each Sushi run.

#### DiskCleanup.sh
Run **DiskCleanup.sh** script to move *tardis-tmp* subfolders to *tardis-tmp/old* or to empty all *tardis-tmp* folders.
