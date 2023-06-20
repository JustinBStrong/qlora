#!/bin/bash

# Download and install Anaconda
wget https://repo.anaconda.com/archive/Anaconda3-2020.07-Linux-x86_64.sh
bash Anaconda3-2020.07-Linux-x86_64.sh -b

# Create a conda environment and install requirements
conda create --name qlora_env --file requirements.txt

# Activate the conda environment
source activate qlora_env

# If any packages are not available in the conda repository, use pip to install them within the conda environment
pip install -r requirements.txt

# Install additional packages
pip install -q -U bitsandbytes huggingface-hub
pip install -q -U git+https://github.com/huggingface/transformers.git
pip install -q -U git+https://github.com/huggingface/peft.git
pip install -q -U git+https://github.com/huggingface/accelerate.git

# Log in to huggingface-cli
huggingface-cli login --token=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
