#!/bin/bash

if [ ! -d "$HOME/anaconda3" ]; then
    # Download and install Anaconda
    wget https://repo.anaconda.com/archive/Anaconda3-2023.03-1-Linux-x86_64.sh
    bash Anaconda3-2023.03-1-Linux-x86_64.sh -b -p $HOME/anaconda3
fi

# Add Anaconda to PATH
export PATH="$HOME/anaconda3/bin:$PATH"

# Create a conda environment and install requirements
conda create --name qlora_env --file requirements.txt

# Activate the conda environment
source activate qlora_env
conda list | grep cuda
echo "######### listing toolkit ############ "
conda list cudatoolkit
echo "######## Done listing toolkit ######## "

# If any packages are not available in the conda repository, use pip to install them within the conda environment
pip install -r requirements.txt



# Install CUDA Toolkit in the conda environment
conda install -c nvidia cuda-toolkit

#conda install pytorch torchvision -c pytorch

# Assuming that the CUDA toolkit has been installed in the default location
export PATH="/usr/local/cuda/bin:$PATH"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/home/ubuntu/anaconda3/pkgs/cuda-cudart-dev-12.1.105-0/lib/libcudart.so"

git clone https://github.com/timdettmers/bitsandbytes.git
cd bitsandbytes
CUDA_VERSION=117 make cuda117
python setup.py install
cd ..

echo "######### listing toolkit ############ "
conda list cudatoolkit
echo "######## Done listing toolkit ######## "
# Install additional packages
#pip install -q -U bitsandbytes huggingface-hub
#pip install -q -U git+https://github.com/huggingface/transformers.git
#pip install -q -U git+https://github.com/huggingface/peft.git
#pip install -q -U git+https://github.com/huggingface/accelerate.git
pip install -q -U transformers datasets evaluate nltk peft transformers accelerate huggingface-hub

## Fix issue with protoc
#pip install protobuf==3.20.0

# Log in to huggingface-cli
huggingface-cli login --token=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

python qlora.py --model_name_or_path "bigcode/starcoderbase" --max_memory_MB 40000 --max_eval_samples 200