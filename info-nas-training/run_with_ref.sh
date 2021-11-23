#!/bin/bash


test -n "$seed" || { echo >&2 "Variable seed is not set!"; exit 1; }

DATADIR=/storage/plzen1/home/gabisuchoparova/diplomka

echo "$PBS_JOBID is running on node `hostname -f` in a scratch directory $SCRATCHDIR" >> $DATADIR/jobs_info.txt

bash $DATADIR/setup_venv.sh || { echo 'Venv creation failed'; exit 1 ; }
. "$SCRATCHDIR"/pyt/bin/activate


cd $DATADIR
infonas="$DATADIR"/info-nas

mkdir "$infonas"/data/vae_checkpoints/with_ref_"$seed"/

python "$infonas"/scripts/train_vae.py --model_cfg "$infonas"/configs/model_config.json \
    --epochs 30 \
    --seed "$seed" \
    --train_path "$infonas"/data/train_long.pt \
    --valid_path "$infonas"/data/valid_long.pt \
    --unseen_valid_path "$infonas"/data/test_small_split.pt \
    --scale_dir "$infonas"/data/scales/ \
    --checkpoint_path "$infonas"/data/vae_checkpoints/with_ref_"$seed"/ \
    --nasbench_path "$infonas"/data/nasbench.pickle \
    --nb_dataset "$infonas"/data/nb_dataset.json \
    --cifar "$infonas"/data/cifar/ \
    --use_ref \
    --use_unseen_data --test_is_splitted > "$SCRATCHDIR"/out.txt 2> "$SCRATCHDIR"/err.txt


cp "$SCRATCHDIR"/out.txt with_ref_"$seed"_out.txt
cp "$SCRATCHDIR"/err.txt with_ref_"$seed"_err.txt

rm -r "$SCRATCHDIR"/*

