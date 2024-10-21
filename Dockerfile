# 使用带有必要工具的官方 Node.js 镜像作为基础镜像
FROM ubuntu:20.04

# 设置环境变量，避免交互式安装
ENV DEBIAN_FRONTEND=noninteractive

# 更新系统并安装必要的软件包
RUN apt-get update && apt-get install -y \
    curl git docker.io unzip \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /root

# 克隆 fabric-samples 仓库
RUN git clone https://github.com/hyperledger/fabric-samples.git .

# 给脚本执行权限并运行 bootstrap.sh
RUN chmod +x ./scripts/bootstrap.sh && ./scripts/bootstrap.sh

# 启动容器时进入 bash
CMD ["bash"]
