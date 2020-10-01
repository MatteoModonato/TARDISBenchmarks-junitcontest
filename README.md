# TARDISBenchmarks-junitcontest

### Important information:
Make sure you edit the paths indicated in the first comment lines of **TardisLauncher.sh** and **CompileAndMove.sh** to have the repository ready to use ([TARDIS](https://github.com/pietrobraione/tardis) run files are automatically updated by scripts).


### How to use the repository:
#### UnzipAndCompile.sh
First of all, run **UnzipAndCompile.sh** script to unzip and compile all benchmarks, compile all TARDIS configuration Files and move them in the correct folders.

#### TardisLauncher.sh
Run **TardisLauncher.sh** script to run TARDIS on a single program or on all benchmarks. Pass the following parameters to set TARDIS configuration: 
* number of threads (-t)
* number of mosa (-m)
* evosuiteTimeBudget (-e)
* globalTimeBudget (-g)

Eg. `bash TardisLauncher.sh -t 5 -m 5 -e 180 -g 20`

#### DiskCleanup.sh
Run **DiskCleanup.sh** script to empty all *tardis-tmp* folders.
