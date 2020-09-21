# TARDISBenchmarks-junitcontest

### Important information:
Satisfy the following requirements to have the repository ready to use:
1. Install [TARDIS](https://github.com/pietrobraione/tardis) in *"/home/ubuntu/tardisFolder/tardisProva/tardis"* folder
2. Run `git clone` under *"/home/ubuntu/tardisFolder/tardisExperiments/bin"* folder

If you don't respect these paths make sure you edit the TARDIS configuration files (RunFiles folder) to reflect the paths where you installed the code.


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
