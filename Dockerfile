FROM debian:10

# https://github.com/NVIDIA/nvidia-container-runtime/blob/master/README.md
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES all

COPY . /docker_debian10_cuda11_nvenc10
