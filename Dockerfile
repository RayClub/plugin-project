# Step 1
############################
FROM node:18-alpine


# 设置工作目录
WORKDIR impl_plugin/impl_plugin.go

# 复制go.mod和go.sum文件以保持依赖一致性
COPY go.mod go.sum ./

# 安装插件所需的依赖
RUN go mod download

# 复制源代码到工作目录
COPY . .

# 构建插件
RUN go build -o impl_plugin

# 设置容器启动时运行的命令
ENTRYPOINT ["./impl_plugin"]
