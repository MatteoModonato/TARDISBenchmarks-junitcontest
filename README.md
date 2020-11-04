# TARDISBenchmarks-junitcontest

### Important information:
Make sure you edit the paths indicated in the first comment lines of **TardisLauncher.sh**, **EvosuiteLauncher.sh** and **CompileAndMove.sh** to have the repository ready to use ([TARDIS](https://github.com/pietrobraione/tardis) run files are automatically updated by scripts).


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

Eg. `bash TardisLauncher.sh -j 5 -e 10 -m 5 -t 180 -g 20 -d 25`

The script computes the test suite metrics after each Tardis run.

#### EvosuiteLauncher.sh
Run **EvosuiteLauncher.sh** script to run Evosuite on a single program or on a multiple benchmarks. Pass the following parameter to set Evosuite configuration: 
* search budget (-s)

Eg. `bash EvosuiteLauncher.sh -s 120`

The script computes the test suite metrics after each Evosuite run.

#### DiskCleanup.sh
Run **DiskCleanup.sh** script to move *tardis-tmp* subfolders to *tardis-tmp/old* or to empty all *tardis-tmp* folders.
