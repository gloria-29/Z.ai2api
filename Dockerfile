# 使用一个官方的 Python 运行时作为父镜像
FROM python:3.12-slim

# 设置工作目录
WORKDIR /app

# 复制依赖文件并安装依赖
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install --no-cache-dir gunicorn

# 复制项目文件到工作目录
COPY . .

# 暴露端口，让容器外的世界可以访问
EXPOSE 8080

# 定义环境变量（可以在运行时覆盖）
ENV PORT=8080
ENV THINK_TAGS_MODE=think
# ENV UPSTREAM_TOKEN="your_own_token" # 可以在 docker run 命令中设置

# 容器启动时运行的命令
CMD ["gunicorn", "--workers", "3", "--bind", "0.0.0.0:8080", "app:app"]
