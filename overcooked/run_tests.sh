#!/bin/bash

datename=$(date +%m%d-%H%M)
stars="************************************************************************"

BASEDIR="/storage/plzen1/home/ayshi"
DATADIR="$BASEDIR"/coding
INFODIR="$DATADIR"/results
CODEDIR="$DATADIR"/overcooked_ai

#TODO setup_env?

echo "$datename $PBS_JOBID is running on node `hostname -f` in a scratch directory $SCRATCHDIR" >> $INFODIR/jobs_info.txt

# Create environments
bash $DATADIR/pbs-tools/setup_venv.sh || { echo 'Venv creation failed'; exit1 ; }
. "$SCRATCHDIR"/pyt/bin/activate

# Run tests
echo $stars
echo "TESTING/OVERCOOKED_TEST"
echo $stars

python3 "$CODEDIR"/testing/overcooked_test.py > "$SCRATCHDIR"/out.txt 2> "$SCRATCHDIR"/err.txt

echo $stars
echo "HARL TESTS (./run_tests.sh)"
echo $stars
cd "$CODEDIR"/src/human_aware_rl
sh ./run_tests.sh > "$SCRATCHDIR"/out.txt 2> "$SCRATCHDIR"/err.txt

# jeste ty treti testy!
echo $stars
echo "vsechny harl testy"
echo $stars
python3 -m unittest discover -s testing/ -p "*_test.py"







