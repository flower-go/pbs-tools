#!bin/bash
module add conda-modules-py37
rm -rf ../envs/OA2_env/
conda create --prefix /storage/plzen1/home/ayshi/envs/OA2_env python==3.7.9
conda activate /storage/plzen1/home/ayshi/envs/OA2_env

echo "**conda env activated"
base_dir="/storage/plzen1/home/ayshi/envs"
tmp_dir="$base_dir"/tmp
cache_dir="$base_dir"/cache

rm -rf $cache_dir
rm -rf $tmp_dir
mkdir $cache_dir
mkdir $tmp_dir

echo "**mazani a vytvoreni adresaru tmp a cache"
pip_args="--cache-dir=$cache_dir"


TMPDIR=$tmp_dir
echo $TMPDIR
TMPDIR=$tmp_dir pip3 install "$pip_args" --upgrade pip
echo "**pip version:"
TMPDIR=$tmp_dir pip "$pip_args" --version
echo "**lets install"
cd /storage/plzen1/home/ayshi/coding
TMPDIR=$tmp_dir pip install "$pip_args" -e './overcooked_ai[harl]'

