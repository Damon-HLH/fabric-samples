# 使用官方 Ubuntu 镜像作为基础镜像
FROM ubuntu:20.04

# 避免交互式安装影响构建
ENV DEBIAN_FRONTEND=noninteractive

# 更新系统并安装必要的软件包（包括 git、curl、unzip、docker）
RUN apt-get update && apt-get install -y \
    curl git docker.io unzip \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /fabric

# 将当前目录的内容复制到 Docker 容器中
COPY . /fabric

# 确保 install-fabric.sh 具有可执行权限
RUN chmod +x ./install-fabric.sh

# 运行 install-fabric.sh 脚本
RUN ./install-fabric.sh

# 使用 bash 作为默认启动命令
CMD ["bash"]

