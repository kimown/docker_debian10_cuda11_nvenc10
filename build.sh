#!/bin/bash

set -e
env
echo 'build.sh execute'

cat <<\EOT> /etc/apt/sources.list
deb http://mirrors.aliyun.com/debian/ buster main non-free contrib
deb-src http://mirrors.aliyun.com/debian/ buster main non-free contrib
deb http://mirrors.aliyun.com/debian-security buster/updates main
deb-src http://mirrors.aliyun.com/debian-security buster/updates main
deb http://mirrors.aliyun.com/debian/ buster-updates main non-free contrib
deb-src http://mirrors.aliyun.com/debian/ buster-updates main non-free contrib
deb http://mirrors.aliyun.com/debian/ buster-backports main non-free contrib
deb-src http://mirrors.aliyun.com/debian/ buster-backports main non-free contrib
EOT

apt-get update && apt-get -y install build-essential vim wget git kmod libxml2-dev

cd /opt/tiger/mdk/
chmod +x NVIDIA-Linux-x86_64-418.116.00.run
sh NVIDIA-Linux-x86_64-418.116.00.run -s --no-kernel-module

#chmod +x cuda_10.0.130_410.48_linux.run
#./cuda_10.0.130_410.48_linux.run --no-opengl-libs  --verbose --toolkit --samples --silent --override

chmod +x cuda_10.1.243_418.87.00_linux.run
./cuda_10.1.243_418.87.00_linux.run --no-opengl-libs --toolkit --samples --silent --override


echo "export PATH=/usr/local/cuda-10.1/bin:\$PATH" >>~/.bashrc
echo "export LD_LIBRARY_PATH=/usr/local/cuda-10.1/lib64:\$LD_LIBRARY_PATH" >>~/.bashrc
source ~/.bashrc

nvcc  --version

cd /usr/local/cuda-10.1/samples/1_Utilities/deviceQuery
make -j$(nproc)
ls 
../../bin/x86_64/linux/release/deviceQuery

cd /usr/local/cuda-10.1/samples
make -j$(nproc)



#docker build -t debian10_cuda10:latest .

#docker run --gpus all -ti --rm debian10_cuda10 /usr/local/cuda-10.0/samples/bin/x86_64/linux/release/deviceQuery

#docker images
#docker run --gpus all -ti --rm debian10_cuda10 /usr/local/cuda-10.0/samples/bin/x86_64/linux/release/deviceQuery
