#!/bin/bash

base_dir="/storage/plzen1/home/ayshi/envs"
tmp_dir="$base_dir"/tmp
cache_dir="$base_dir"/cache

#je treba pridat modul, bo jinak nemas naisntalovanou condu
module add conda-modules-py37
conda update -y -n base -c defaults conda
#standartne instaluje 3.5, s argumentem 3.7.0 a to je pitoma verze
conda activate /storage/plzen1/home/ayshi/envs/PPO_env
conda update -y -n base -c defaults conda


#git clone https://github.com/PremekBasta/PPO.git
conda install -y  pytorch torchvision torchaudio pytorch-cuda=11.6 -c pytorch -c nvidia # check current pytorch install instruction
conda install -y -c conda-forge gym
conda install -y -c anaconda pandas
conda install -y -c conda-forge matplotlib
conda install -y -c conda-forge tqdm
conda install -y -c anaconda scipy
conda install -y -c conda-forge tensorboard
