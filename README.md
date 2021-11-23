# pbs-tools
Tools for pbs grid computing (used e.g. in [MetaCentrum](https://metavo.metacentrum.cz)).

Scripts in `info-nas-training` were used to train neural networks
using PyTorch and can serve as inspiration for other training.

Other utility files include github key agent start (to use on reserved machines)
and venv creation with caching to a scratch dir with enough place
(it is expected to not save large data outside of the scratch dir, but
the pip cache defaults to home dir).