import glob
import os
import shutil


for whl_path in glob.glob(os.path.join(os.getcwd(), 'dist', '*.whl')):
    whl_name = os.path.basename(whl_path)
    dist, version, python_tag, abi_tag, platform_tag = whl_name.split('-')
    if 'manylinux' in platform_tag:
        continue
    platform_tag = platform_tag.replace('linux', 'manylinux1')
    new_whl_name = '-'.join([dist, version, python_tag, abi_tag, platform_tag])
    new_whl_path = os.path.join(os.path.dirname(whl_path), new_whl_name)
    shutil.move(whl_path, new_whl_path)
