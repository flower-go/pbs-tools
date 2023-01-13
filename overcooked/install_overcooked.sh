#!bin/bash

base_dir="/storage/plzen1/home/ayshi/envs"
tmp_dir="$base_dir"/tmp
cache_dir="$base_dir"/cache

pip_args="--cache-dir=$cache_dir"


TMPDIR=$tmp_dir
echo $TMPDIR
TMPDIR=$tmp_dir pip3 install "$pip_args" --upgrade pip
TMPDIR=$tmp_dir pip3 install "$pip_args" --version


TMPDIR=$tmp_dir pip3 install "$pip_args" -e './overcooked_ai[harl]'
