#!/bin/bash


test -n "$hash" || { echo >&2 "Variable hash is not set!"; exit 1; }

DATADIR=/storage/plzen1/home/gabisuchoparova/diplomka
OUTDIR="$DATADIR"/seed_experiments/

[[ -d $OUTDIR ]] || mkdir $OUTDIR

echo "$PBS_JOBID is running on node `hostname -f` in a scratch directory $SCRATCHDIR" >> $DATADIR/jobs_info.txt

bash $DATADIR/setup_venv.sh || { echo 'Venv creation failed'; exit1 ; }
. "$SCRATCHDIR"/pyt/bin/activate


infonas="$DATADIR"/info-nas

python "$infonas"/scripts/pretrain_n_times.py $hash \
	--nasbench_path "$infonas"/data/nasbench_only108.tfrecord \
	--out_dir "$OUTDIR" \
	--config_path "$infonas"/info_nas/configs/pretrain_config.json \
	--root "$infonas"/data/cifar/ > "$SCRATCHDIR"/out.txt 2> "$SCRATCHDIR"/err.txt

cp "$SCRATCHDIR"/out.txt "$OUTDIR"/"$hash"_out.txt
cp "$SCRATCHDIR"/err.txt "$OUTDIR"/"$hash"_err.txt

[[ -n $SCRATCHDIR ]] && rm -r "$SCRATCHDIR"/*
