#!/bin/bash

datename=$(date +%m%d-%H%M)
stars="************************************************************************"

export BASEDIR="/storage/plzen1/home/ayshi"
export DATADIR="$BASEDIR"/coding
export INFODIR="$DATADIR"/results
export CODEDIR="$DATADIR"/PPO/overcooked_pytorch_stable_baselines/overcooked_ai

#TODO setup_env?

echo "$datename $PBS_JOBID is running on node `hostname -f` in a scratch directory $SCRATCHDIR" >> $INFODIR/jobs_info.txt


while getopts ":t:" opt; do
  case $opt in
    t)
      echo "-a was triggered, Parameter: $OPTARG" >&2
      testy=$OPTARG
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done



# Create environments
. $DATADIR/pbs-tools/setup_venv.sh || { echo 'Venv creation failed'; exit1 ; }
# . "$SCRATCHDIR"/pyt/bin/activate
conda activate "$BASEDIR"/envs/PPO_env

# Run tests
if [[ 1 == *"$testy"* ]]; then
    echo $stars
    echo "TESTING/OVERCOOKED_TEST"
    echo $stars

    python3 "$CODEDIR"/testing/overcooked_test.py > "$SCRATCHDIR"/out.txt 2> "$SCRATCHDIR"/err.txt
fi
#harl_testy
if [[ 2 == *"$testy"* ]]; then
    echo $stars
    echo "HARL TESTS (./run_tests.sh)"
    echo $stars
    cd "$CODEDIR"/src/human_aware_rl
    sh ./run_tests.sh >> "$SCRATCHDIR"/out.txt 2>> "$SCRATCHDIR"/err.txt
fi
#harl_testy

# jeste ty treti testy!
if [[ 3 == *"$testy"* ]]; then
    echo $stars
    echo "VSECHNY HARL TESTY"
    echo $stars
    cd ../..
    python3 -m unittest discover -s testing/ -p "*_test.py"
fi
cp "$SCRATCHDIR"/out.txt "$INFODIR"/"$datename"."$PBS_JOBID"_out.txt
cp "$SCRATCHDIR"/err.txt "$INFODIR"/"$datename"."$PBS_JOBID"_err.txt

rm -r "$SCRATCHDIR"/*





