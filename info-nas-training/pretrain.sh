#!/bin/bash

#test -n "$hashdir" || { echo >&2 "Variable hashdir is not set!"; exit 1; }
#test -n "$hashno" || { echo >&2 "Variable hashno is not set!"; exit 1; }
datename=$(date +%m%d-%H%M)

DATADIR=/storage/praha1/home/ayshi/coding/
infodir="$DATADIR"/results
codedir="$DATADIR"/overcooked_pytorch_stable_baselines/overcooked_ai/src/overcooked_ai_py/diverse_population

echo "$PBS_JOBID is running on node `hostname -f` in a scratch directory $SCRATCHDIR" >> $infodir/jobs_info.txt

bash $DATADIR/pbs-tools/setup_venv.sh || { echo 'Venv creation failed'; exit1 ; }
. "$SCRATCHDIR"/pyt/bin/activate



python "$codedir"/odPremka/PPO/diverse_pool_build.py > "$SCRATCHDIR"/out.txt 2> "$SCRATCHDIR"/err.txt

cp "$SCRATCHDIR"/out.txt "$infodir"/"$datename"_out.txt
cp "$SCRATCHDIR"/err.txt "$infodir"/"$datename"_err.txt

rm -r "$SCRATCHDIR"/*

