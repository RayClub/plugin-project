# Step 1
############################
FROM node:18-alpine


# 设置工作目录
ADD ./plugin-project/ /root/ray-docker/plugin-project
WORKDIR /root/ray-docker/plugin-project/

# 复制go.mod文件以保持依赖一致性
COPY go.mod ./

# 安装插件所需的依赖
RUN go env -w GOPROXY=https://goproxy.cn,https://gocenter.io,https://goproxy.io,direct
RUN go env -w GOPRIVATE=git.jxedc.com
RUN go mod tidy
RUN GOARCH=amd64 CGO_ENABLED=0 GOOS=linux go build -o applicationd

# 复制源代码到工作目录
COPY . .

# 构建插件
RUN go build -o impl_plugin

# 设置容器启动时运行的命令
ENTRYPOINT ["./impl_plugin"]
