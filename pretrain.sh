#!/bin/bash


test -n "$hashdir" || { echo >&2 "Variable hashdir is not set!"; exit 1; }
test -n "$hashno" || { echo >&2 "Variable hashno is not set!"; exit 1; }

DATADIR=/storage/plzen1/home/gabisuchoparova/diplomka

echo "$PBS_JOBID is running on node `hostname -f` in a scratch directory $SCRATCHDIR" >> $DATADIR/jobs_info.txt

bash $DATADIR/setup_venv.sh || { echo 'Venv creation failed'; exit1 ; }
. "$SCRATCHDIR"/pyt/bin/activate


infonas="$DATADIR"/info-nas

python "$infonas"/scripts/pretrain_i_th_hashes.py "$infonas"/$hashdir $hashno \
	--nasbench_path "$infonas"/data/nasbench_only108.tfrecord \
	--config_path "$infonas"/info_nas/configs/pretrain_config.json \
	--root "$infonas"/data/cifar/ > "$SCRATCHDIR"/out.txt 2> "$SCRATCHDIR"/err.txt

cp "$SCRATCHDIR"/out.txt "$infonas"/"$hashdir"/"$hashno"_out.txt
cp "$SCRATCHDIR"/err.txt "$infonas"/"$hashdir"/"$hashno"_err.txt

rm -r "$SCRATCHDIR"/*

