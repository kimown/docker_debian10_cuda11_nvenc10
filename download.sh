#https://developer.nvidia.com/cuda-11.0-update1-download-archive?target_os=Linux&target_arch=x86_64&target_distro=Ubuntu&target_version=1804&target_type=runfilelocal
wget https://us.download.nvidia.com/tesla/450.80.02/NVIDIA-Linux-x86_64-450.80.02.run
wget https://developer.download.nvidia.com/compute/cuda/11.0.3/local_installers/cuda_11.0.3_450.51.06_linux.run
wget https://www.ffmpeg.org/releases/ffmpeg-4.3.1.tar.bz2

# https://github.com/FFmpeg/nv-codec-headers/tree/sdk/10.0
git clone https://git.videolan.org/git/ffmpeg/nv-codec-headers.git
