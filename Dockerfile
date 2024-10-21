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

# 克隆 Damon-HLH 的 fabric-samples 仓库的 main 分支
RUN git clone --branch main https://github.com/Damon-HLH/fabric-samples.git .

# 列出当前目录的文件，便于调试
RUN ls -la

# 确保 install-fabric.sh 存在并赋予执行权限
# 这里用 ls 确认文件的准确名称
RUN ls -la && chmod +x ./install-fabric.sh

# 运行 install-fabric.sh 脚本
RUN ./install-fabric.sh

# 暴露 Hyperledger Fabric 的常用端口
EXPOSE 7050 7051 7052 7053 8051 9051 10051

# 使用 bash 作为默认启动命令
CMD ["bash"]
