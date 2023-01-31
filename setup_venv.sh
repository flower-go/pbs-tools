#!/bin/bash

#TODO dodelat vic kontrol
test -n "$DATADIR" || { echo >&2 "ERROR Variable datadir is not set!"; exit 1; }
test -n "$SCRATCHDIR" || { echo >&2 "ERROR Variable SCRATCHDIR is not set!"; exit 1; }

#module add python/3.8.0-gcc-rab6t
#module add python/python-3.10.4-gcc-8.3.0-ovkjwzd
#module add python/3.7.4-gcc-yr5ac
module add conda-modules-py37
#module add cudnn/cudnn-7.6.5.32-10.2-linux-x64-gcc-6.3.0-xqx4s5f
#module add cudnn/cudnn-7.6.5.32-10.2-linux-x64-gcc-6.3.0-xqx4s5f
module add cudnn/cudnn-8.1.1.33-10.2-linux-x64-intel-19.0.4-gvqz65i


tmp_dir="$SCRATCHDIR/tmp/"
mkdir "$tmp_dir"

#python3 -m venv "$SCRATCHDIR"/pyt
conda activate "$BASEDIR"/envs/OA2_env

# cache dir outside of limited reserved disk space
pip_args="--cache-dir=$tmp_dir"

#TMPDIR=$tmp_dir pip install "$pip_args" --upgrade pip
#TMPDIR=$tmp_dir pip install "$pip_args" -r "$repo_dir/requirements.txt"
#TMPDIR=$tmp_dir pip install "$pip_args" -e 'overcooked_ai[harl]'
#TMPDIR=$tmp_dir pip install "$pip_args" -e 'stable-baselines3'
#if [[ $info_nas ]]; then
 # TMPDIR=$tmp_dir pip install "$pip_args" "$repo_dir/nasbench/"
  #TMPDIR=$tmp_dir pip install "$pip_args" "$repo_dir/NASBench-PyTorch/"
 # TMPDIR=$tmp_dir pip install "$pip_args" "$repo_dir/arch2vec/"
 # TMPDIR=$tmp_dir pip install "$pip_args" "$repo_dir/info-nas/"
