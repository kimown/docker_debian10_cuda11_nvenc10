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

cd /docker_debian10_cuda11_nvenc10
chmod +x cuda_11.0.3_450.51.06_linux.run
apt-get update && apt-get -y install libxml2-dev
./cuda_11.0.3_450.51.06_linux.run --no-opengl-libs --toolkit --samples --silent --override
rm -rf cuda_11.0.3_450.51.06_linux.run
echo "export PATH=/usr/local/cuda-11.0/bin:\$PATH" >>~/.bashrc
echo "export LD_LIBRARY_PATH=/usr/local/cuda-11.0/lib64:\$LD_LIBRARY_PATH" >>~/.bashrc
export PATH=/usr/local/cuda-11.0/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda-11.0/lib64:$LD_LIBRARY_PATH
source ~/.bashrc
find / -name nvcc
nvcc  --version


cd /docker_debian10_cuda11_nvenc10
sh NVIDIA-Linux-x86_64-450.80.02.run -s --no-kernel-module


cd /docker_debian10_cuda11_nvenc10
cd nv-codec-headers
git checkout sdk/10.0
make
make install
cd ..
rm -rf nv-codec-headers

cd /docker_debian10_cuda11_nvenc10
sudo apt-get update -qq && sudo apt-get -y install \
  autoconf \
  automake \
  build-essential \
  cmake \
  git-core \
  libass-dev \
  libfreetype6-dev \
  libgnutls28-dev \
  libsdl2-dev \
  libtool \
  libva-dev \
  libvdpau-dev \
  libvorbis-dev \
  libxcb1-dev \
  libxcb-shm0-dev \
  libxcb-xfixes0-dev \
  pkg-config \
  texinfo \
  wget \
  yasm \
  zlib1g-dev
sudo apt-get install -y nasm libx264-dev libvpx-dev libfdk-aac-dev libmp3lame-dev libopus-dev
sudo apt-get install -y libunistring-dev libgnutls28-dev

mkdir ffmpeg
cd ffmpeg
export DIR=`pwd`
mkdir -p ffmpeg_sources ffmpeg_build bin
cd $DIR/ffmpeg_sources
cp ../../ffmpeg-4.3.1.tar.bz2 .
tar xjvf ffmpeg-4.3.1.tar.bz2
cd ffmpeg-4.3.1

# from: ffmpeg_hw_nvenc.sh
sed -i 's/sm_30/sm_35/g' configure
sed -i 's/compute_30/compute_35/g' configure

PATH="$DIR/bin:$PATH" PKG_CONFIG_PATH="$DIR/ffmpeg_build/lib/pkgconfig" ./configure \
  --prefix="$DIR/ffmpeg_build" \
  --pkg-config-flags="--static" \
  --extra-cflags="-I$DIR/ffmpeg_build/include" \
  --extra-ldflags="-L$DIR/ffmpeg_build/lib" \
  --extra-libs="-lpthread -lm" \
  --bindir="$DIR/bin" \
  --enable-static \
  --disable-shared \
  --enable-gpl \
  --enable-gnutls \
  --disable-libaom \
  --enable-libass \
  --enable-libfdk-aac \
  --enable-libfreetype \
  --enable-libmp3lame \
  --enable-libopus \
  --enable-libvorbis \
  --enable-libvpx \
  --enable-libx264 \
  --disable-libx265 \
  --enable-nonfree \
  --enable-cuda-nvcc --enable-libnpp --extra-cflags=-I/usr/local/cuda/include --extra-ldflags=-L/usr/local/cuda/lib64 \
  --enable-cuda --enable-cuvid --enable-nvenc

PATH="$PWD/bin:$PATH" make -j$(nproc)
make install
cd ../../bin

./ffmpeg -codecs|grep nvenc

echo 'export PATH="/docker_debian10_cuda11_nvenc10/ffmpeg/bin:$PATH"' >> /etc/profile
echo 'cat /etc/profile'
cat /etc/profile
echo 'export PATH="/docker_debian10_cuda11_nvenc10/ffmpeg/bin:$PATH"' >> ~/.bashrc
echo 'cat ~/.bashrc'
cat ~/.bashrc
