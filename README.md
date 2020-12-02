# run
```shell
sh download.sh

md5sum NVIDIA-Linux-x86_64-450.80.02.run cuda_11.0.3_450.51.06_linux.run ffmpeg-4.3.1.tar.bz2
c68b3500fb5ceb17a0fcebcbb143dad8  NVIDIA-Linux-x86_64-450.80.02.run
70af4cebe30549b9995fb9c57d538214  cuda_11.0.3_450.51.06_linux.run
804707549590e90880e8ecd4e5244fd8  ffmpeg-4.3.1.tar.bz2

# https://www.yuque.com/kimown/hiy9e0/hws5kp
nvidia-installer --uninstall
apt-get purge nvidia. 
update-initramfs -u

chmod +x NVIDIA-Linux-x86_64-450.80.02.run 
./NVIDIA-Linux-x86_64-450.80.02.run
nvidia-smi 
Wed Dec  2 17:11:03 2020       
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 450.80.02    Driver Version: 450.80.02    CUDA Version: 11.0     |
|-------------------------------+----------------------+----------------------+

# 安装kit:https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#setting-up-nvidia-container-toolkit
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
echo $distribution
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -    && curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
echo $?
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
sudo apt-get update
sudo apt-get install -y nvidia-docker2
sudo systemctl restart docker

# 重置/etc/docker/daemon.json： https://www.yuque.com/kimown/hiy9e0/ogbaeb
 
docker run --rm --gpus all debian:10 nvidia-smi


docker build -t docker_debian10_cuda11_nvenc10:latest .

docker run --gpus all -ti docker_debian10_cuda11_nvenc10 /bin/bash
```