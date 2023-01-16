#!/bin/bash

datename=$(date +%m%d-%H%M)
stars="************************************************************************"

datadir=/storage/plzen1/home/ayshi/coding
infodir="$DATADIR"/results
codedir="$DATADIR"/overcooked_ai

#TODO setup_env?

echo "$datename $PBS_JOBID is running on node `hostname -f` in a scratch directory $SCRATCHDIR" >> $infodir/jobs_info.txt

# Create environments
bash $DATADIR/pbs-tools/setup_venv.sh || { echo 'Venv creation failed'; exit1 ; }
. "$SCRATCHDIR"/pyt/bin/activate

# Run tests
echo $stars
echo "TESTING/OVERCOOKED_TEST"
echo $stars

python3 "$codedir"/testing/overcooked_test.py > "$SCRATCHDIR"/out.txt 2> "$SCRATCHDIR"/err.txt

echo $stars
echo "HARL TESTS (./run_tests.sh)"
echo $stars
cd "$codedir"/src/human_aware_rl
sh ./run_tests.sh > "$SCRATCHDIR"/out.txt 2> "$SCRATCHDIR"/err.txt

# jeste ty treti testy!
echo $stars
echo "vsechny harl testy"
echo $stars
python3 -m unittest discover -s testing/ -p "*_test.py"







