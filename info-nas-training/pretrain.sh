#!/bin/bash


test -n "$hashdir" || { echo >&2 "Variable hashdir is not set!"; exit 1; }
test -n "$hashno" || { echo >&2 "Variable hashno is not set!"; exit 1; }

DATADIR=/storage/praha1/home/ayshi/coding/odPremka/PPO

echo "$PBS_JOBID is running on node `hostname -f` in a scratch directory $SCRATCHDIR" >> $DATADIR/jobs_info.txt

bash $DATADIR/setup_venv.sh || { echo 'Venv creation failed'; exit1 ; }
. "$SCRATCHDIR"/pyt/bin/activate


infonas="$DATADIR"/overcooked_pytorch_stable_baselines/overcooked_ai/src/overcooked_ai_py/diverse_population

python "$infonas"/diverse_pool_build.py > "$SCRATCHDIR"/out.txt 2> "$SCRATCHDIR"/err.txt

cp "$SCRATCHDIR"/out.txt "$infonas"/"$hashdir"/"$hashno"_out.txt
cp "$SCRATCHDIR"/err.txt "$infonas"/"$hashdir"/"$hashno"_err.txt

rm -r "$SCRATCHDIR"/*

