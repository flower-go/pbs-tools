#!/bin/bash

datename=$(date +%m%d-%H%M)
stars="************************************************************************"

export BASEDIR="/storage/plzen1/home/ayshi"
export DATADIR="$BASEDIR"/coding
export INFODIR="$DATADIR"/results
export CODEDIR="$DATADIR"/PPO/overcooked_pytorch_stable_baselines/overcooked_ai/src/overcooked_ai_py/diverse_population
#echo "uz taky bezim" >> $INFODIR/"$datename"."$PBS_JOBID".fuckit3
echo "$datename $PBS_JOBID is running on node `hostname -f` in a scratch directory $SCRATCHDIR" >> $INFODIR/jobs_info.txt
echo "before activate"
. $DATADIR/pbs-tools/setup_venv.sh || { echo 'Venv creation failed'; exit1 ; }
conda activate "$BASEDIR"/envs/overcooked_ai_terminal
echo "conda activated"
python3 "$CODEDIR"/diverse_pool_build.py --mode="SP" --trained_models=2 --exp="test_small_qsub_2workers_new" --n_epochs=1 --n_steps=400 --num_workers=1 > "$SCRATCHDIR"/out.txt 2> "$SCRATCHDIR"/err.txt
 
echo "job ended"
cp "$SCRATCHDIR"/out.txt "$INFODIR"/"$datename"."$PBS_JOBID"_out.txt
cp "$SCRATCHDIR"/err.txt "$INFODIR"/"$datename"."$PBS_JOBID"_err.txt

rm -r "$SCRATCHDIR"/*

