# 使用 Ubuntu 作为基础镜像
FROM ubuntu:latest

# 更新系统并安装 ffmpeg，wget 和 git
RUN apt-get update && apt-get install -y ffmpeg wget git cron

# 安装 lux
RUN wget https://github.com/iawia002/lux/releases/download/v0.17.2/lux_0.17.2_Linux_x86_64.tar.gz \
    && tar -zxvf lux*.tar.gz \
    && chmod 0777 lux \
    && mv lux /usr/local/bin/ \
    && rm -rf lux*

# 设置工作目录
WORKDIR /root

# 克隆 Git 仓库
RUN git clone https://github.com/hechuan4/BiliFavoritesDownloader

# 创建一个新的 cron job，每十分钟运行一次脚本
RUN (crontab -l 2>/dev/null; echo "*/10 * * * * /root/BiliFavoritesDownloader/bilidown-lux-run.sh") | crontab -

# 启动 cron
CMD ["cron", "-f"]
