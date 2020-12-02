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

apt-get update && apt-get -y install build-essential vim wget git kmod libxml2-dev sudo

chmod +x cuda_11.1.1_455.32.00_linux.run
./cuda_11.1.1_455.32.00_linux.run --no-opengl-libs --toolkit --samples --silent --override
rm -rf cuda_11.1.1_455.32.00_linux.run
#echo "export PATH=/usr/local/cuda-11.1/bin:\$PATH" >>~/.bashrc
#echo "export LD_LIBRARY_PATH=/usr/local/cuda-10.1/lib64:\$LD_LIBRARY_PATH" >>~/.bashrc
#export PATH=/usr/local/cuda-10.1/bin:$PATH
#export LD_LIBRARY_PATH=/usr/local/cuda-10.1/lib64:$LD_LIBRARY_PATH
#source ~/.bashrc
#find / -name nvcc
#nvcc  --version
#
#
#cd /docker_debian10_cuda11_nvenc10
#cd nv-codec-headers
#git checkout sdk/10.0
#make
#make install
#cd ..
#rm -rf nv-codec-headers
#
#cd /docker_debian10_cuda11_nvenc10
#sudo apt-get update -qq && sudo apt-get -y install \
#  autoconf \
#  automake \
#  build-essential \
#  cmake \
#  git-core \
#  libass-dev \
#  libfreetype6-dev \
#  libgnutls28-dev \
#  libsdl2-dev \
#  libtool \
#  libva-dev \
#  libvdpau-dev \
#  libvorbis-dev \
#  libxcb1-dev \
#  libxcb-shm0-dev \
#  libxcb-xfixes0-dev \
#  pkg-config \
#  texinfo \
#  wget \
#  yasm \
#  zlib1g-dev
#  
#sudo apt-get install nasm libx264-dev libvpx-dev libfdk-aac-dev libmp3lame-dev libopus-dev
#sudo apt-get install libunistring-dev libgnutls28-dev
#
#export DIR=`pwd`
#mkdir -p ffmpeg_sources ffmpeg_build bin
#cd $DIR/ffmpeg_sources
#tar xjvf ffmpeg-4.3.1.tar.bz2
#cd ffmpeg-4.3.1 
#PATH="$DIR/bin:$PATH" PKG_CONFIG_PATH="$DIR/ffmpeg_build/lib/pkgconfig" ./configure \
#  --prefix="$DIR/ffmpeg_build" \
#  --pkg-config-flags="--static" \
#  --extra-cflags="-I$DIR/ffmpeg_build/include" \
#  --extra-ldflags="-L$DIR/ffmpeg_build/lib" \
#  --extra-libs="-lpthread -lm" \
#  --bindir="$DIR/bin" \
#  --enable-static \
#  --disable-shared \
#  --enable-gpl \
#  --enable-gnutls \
#  --disable-libaom \
#  --enable-libass \
#  --enable-libfdk-aac \
#  --enable-libfreetype \
#  --enable-libmp3lame \
#  --enable-libopus \
#  --enable-libvorbis \
#  --enable-libvpx \
#  --enable-libx264 \
#  --disable-libx265 \
#  --enable-nonfree \
#  --enable-cuda-nvcc --enable-libnpp --extra-cflags=-I/usr/local/cuda/include --extra-ldflags=-L/usr/local/cuda/lib64 \
#  --enable-cuda --enable-cuvid --enable-nvenc
#  
#PATH="$PWD/bin:$PATH" make -j$(nproc)
#make install
#cd ../..
#rm -rf ffmpeg_sources
