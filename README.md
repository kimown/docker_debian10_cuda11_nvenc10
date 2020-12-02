# run
```shell
# NVIDIA-SMI 450.80.02    Driver Version: 450.80.02    CUDA Version: 11.0
sh download.sh

md5sum *.*


docker build -t docker_debian10_cuda11_nvenc10:latest .

docker run --gpus all -ti docker_debian10_cuda11_nvenc10 /bin/bash
```