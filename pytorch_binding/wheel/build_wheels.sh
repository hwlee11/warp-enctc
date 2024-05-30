#!/bin/bash

set -eu

function install_torch_of_specified_version() {
  version=$1
  pip install torch==$1
}

function build_wheel() {
  python setup.py bdist_wheel
  python wheel/rename_wheels.py
}

function install_wheel() {
  torch_version=$1

  torch_vers=(${torch_version//./ })
  torch_major_ver=${torch_vers[0]}
  torch_minor_ver=${torch_vers[1]}
  pip install dist/warpctc_pytorch-*+torch${torch_major_ver}${torch_minor_ver}*.whl
}

function run_tests() {
  pytest tests
  pytest --flakes
}

function post_process() {
  python setup.py clean
  pip uninstall -y warpctc-pytorch torch
  rm -rf build warpctc_pytorch.egg-info
}

torch_versions=(${TORCH_VERSIONS//:/ })
for torch_version in ${torch_versions[@]}; do
  install_torch_of_specified_version $torch_version
  build_wheel
  install_wheel $torch_version
  run_tests
  post_process
done
