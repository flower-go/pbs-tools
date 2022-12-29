#!/bin/bash

test -n "$repo_dir" || { echo >&2 "Variable repo_dir is not set!"; exit 1; }
test -n "$SCRATCHDIR" || { echo >&2 "Variable SCRATCHDIR is not set!"; exit 1; }

#module add python/3.8.0-gcc-rab6t
module add python/python-3.10.4-gcc-8.3.0-ovkjwzd
#module add cudnn/cudnn-7.6.5.32-10.2-linux-x64-gcc-6.3.0-xqx4s5f
module add cudnn/cudnn-7.6.5.32-10.2-linux-x64-gcc-6.3.0-xqx4s5f

tmp_dir="$SCRATCHDIR/tmp/"
mkdir "$tmp_dir"

python3 -m venv "$SCRATCHDIR"/pyt
. "$SCRATCHDIR"/pyt/bin/activate

# cache dir outside of limited reserved disk space
pip_args="--cache-dir=$tmp_dir --build $tmp_dir"

TMPDIR=$tmp_dir pip install "$pip_args" --upgrade pip
TMPDIR=$tmp_dir pip install "$pip_args" -r "$repo_dir/requirements.txt"
TMPDIR=$tmp_dir pip install -e 'overcooked_ai[harl]'
TMPDIR=$tmp_dir pip install -e 'stable-baselines3'
#if [[ $info_nas ]]; then
 # TMPDIR=$tmp_dir pip install "$pip_args" "$repo_dir/nasbench/"
  #TMPDIR=$tmp_dir pip install "$pip_args" "$repo_dir/NASBench-PyTorch/"
 # TMPDIR=$tmp_dir pip install "$pip_args" "$repo_dir/arch2vec/"
 # TMPDIR=$tmp_dir pip install "$pip_args" "$repo_dir/info-nas/"
