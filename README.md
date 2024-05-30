# PyTorch bindings for Warp-ctc

|branch|status|
|:-:|:-:|
|`pytorch_bindings`|[![Build Status](https://travis-ci.org/espnet/warp-ctc.svg?branch=pytorch_bindings)](https://github.com/espnet/warp-ctc/tree/pytorch_bindings)|
|`pytorch-0.4`|[![Build Status](https://travis-ci.org/espnet/warp-ctc.svg?branch=pytorch-0.4)](https://github.com/espnet/warp-ctc/tree/pytorch-0.4)|
|`pytorch-1.0`|[![Build Status](https://travis-ci.org/espnet/warp-ctc.svg?branch=pytorch-1.0)](https://github.com/espnet/warp-ctc/tree/pytorch-1.0)|

This is an extension onto the original repo found [here](https://github.com/baidu-research/warp-ctc).

## Installation

Install [PyTorch](https://github.com/pytorch/pytorch#installation) first.

`warpctc-pytorch` wheel uses [local version identifiers](https://www.python.org/dev/peps/pep-0440/#local-version-identifiers),
which has a restriction that users have to specify the version explicitly.

```console
$ pip install warpctc-pytorch==X.X.X+torchYY.cudaZZ
```

The latest version is 0.2.1 and if you work with PyTorch 1.6 and CUDA 10.2, you can run:

```console
$ pip install warpctc-pytorch==0.2.1+torch16.cuda102
```

### for PyTorch 1.4 - 1.6

`warpctc-pytorch` wheels are provided for Python 3.8, 3.7, 3.6 and CUDA 10.2, 10.1, 10.0, 9.2.

### for PyTorch 1.1 - 1.3

`warpctc-pytorch` wheels are provided for Python 3.7, 3.6 and CUDA 10.2, 10.1, 10.0, 9.2.

### for PyTorch 1.0

`warpctc-pytorch10-cudaYY` wheels are provided for Python 3.7, 3.6 and CUDA 10.1, 10.0, 9.2, 9.1, 9.0, 8.0.

If you work with CUDA 10.1, you can run:

```console
$ pip install warpctc-pytorch10-cuda101
```

### for PyTorch 0.4.1

Wheels for PyTorch 0.4.1 are not provided so users have to build from source manually.

`WARP_CTC_PATH` should be set to the location of a built WarpCTC
(i.e. `libwarpctc.so`).  This defaults to `../build`, so from within a
new warp-ctc clone you could build WarpCTC like this:

```bash
$ git clone https://github.com/espnet/warp-ctc.git
$ cd warp-ctc; git checkout -b pytorch-0.4 remotes/origin/pytorch-0.4
$ mkdir build; cd build
$ cmake ..
$ make
```

Now install the bindings:
```bash
$ cd ../pytorch_binding
$ pip install numpy cffi
$ python setup.py install
```

## Example

Example to use the bindings below.

```python
import torch
from warpctc_pytorch import CTCLoss
ctc_loss = CTCLoss()
# expected shape of seqLength x batchSize x alphabet_size
probs = torch.FloatTensor([[[0.1, 0.6, 0.1, 0.1, 0.1], [0.1, 0.1, 0.6, 0.1, 0.1]]]).transpose(0, 1).contiguous()
labels = torch.IntTensor([1, 2])
label_sizes = torch.IntTensor([2])
probs_sizes = torch.IntTensor([2])
probs.requires_grad_(True)  # tells autograd to compute gradients for probs
cost = ctc_loss(probs, labels, probs_sizes, label_sizes)
cost.backward()
```

## Documentation

```
CTCLoss(size_average=False, length_average=False, reduce=True)
    # size_average (bool): normalize the loss by the batch size (default: False)
    # length_average (bool): normalize the loss by the total number of frames in the batch. If True, supersedes size_average (default: False)
    # reduce (bool): average or sum over observation for each minibatch.
        If `False`, returns a loss per batch element instead and ignores `average` options.
        (default: `True`)

forward(acts, labels, act_lens, label_lens)
    # acts: Tensor of (seqLength x batch x outputDim) containing output activations from network (before softmax)
    # labels: 1 dimensional Tensor containing all the targets of the batch in one large sequence
    # act_lens: Tensor of size (batch) containing size of each output sequence from the network
    # label_lens: Tensor of (batch) containing label length of each example
```
