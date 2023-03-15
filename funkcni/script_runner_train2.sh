#!/bin/bash
#TOTO funguje
exp=$1;
layout_name=$2;
seed=$3;

home_dir="/storage/plzen1/home/ayshi"
echo "home set to: $home_dir"
res_dir="$home_dir"/coding/results
date_name=$(date +%m%d-%H%M)

echo $exp
echo $layout_name
echo $seed

job_name="${exp}_${layout_name}_train"
echo $job_name

#No diversification
qsub -m ba -N "$date_name" -e "$res_dir" -o "$res_dir" -l select=1:ncpus=4:ngpus=1:mem=14gb:scratch_local=4gb -q gpu -l walltime=23:50:00 -v layout_name=$layout_name,trained_models=1,exp=$exp,init_SP_agents=3,delay_shared_rewards=False,mode="SP",kl_diff_bonus_reward_coef=0.0,kl_diff_bonus_reward_clip=0.0,kl_diff_loss_coef=0.0,kl_diff_loss_clip=0.0,seed=$seed,n_sample_partners=-1 $home_dir/bin/run_old_env
