import click
import subprocess

#qsub -l select=1:ncpus=4:ngpus=1:mem=16gb:scratch_local=2gb:cluster=adan -q
#gpu -l walltime=00:30:00 -v hashdir=data/hashes/train_hashes_100_splits/,hashno=same_4 pretrain.sh


@click.command()
@click.argument('script_path')
@click.option('--gpu/--no_gpu', default=False)
@click.option('--select', default="1")
@click.option('--ngpus', default="1")
@click.option('--ncpus', default="4")
@click.option('--mem', default="16gb")
@click.option('--scratch_local', default="2gb")
@click.option('--cluster', default="adan")
@click.option('--walltime', default="00:10:00")
@click.option('--env_vars', default=None, help="Variables are set like name1=val1,name2=val2...")
@click.option('--print_command/--no_print', default=False)
def main(script_path, gpu, select, ngpus, ncpus, mem, scratch_local, cluster, walltime, env_vars, print_command):
    script_def = ['qsub', '-l']

    # resources settings
    config_str = f"select={select}:ncpus={ncpus}:mem={mem}:scratch_local={scratch_local}:cluster={cluster}"
    config_str += "" if not gpu else f":ngpus={ngpus}"
    script_def.append(config_str)

    # gpu queue
    if gpu:
        script_def.append('-q')
        script_def.append('gpu')

    # running time
    script_def.append('-l')
    script_def.append(f'walltime={walltime}')

    # env variables to be set before running the script
    if env_vars is not None:
        script_def.append('-v')
        script_def.append(env_vars)

    script_def.append(script_path)

    if print_command:
        print(" ".join(script_def))

    ret_val = subprocess.call(script_def)
    exit(ret_val)


if __name__ == "__main__":
    main()
