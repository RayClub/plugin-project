# Step 1
############################
FROM node:18-alpine


# 设置工作目录
ADD ./ /root/ray-docker/plugin-project
WORKDIR /root/ray-docker/plugin-project/

# 复制go.mod文件以保持依赖一致性
COPY go.mod ./

# 安装插件所需的依赖
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories
ENV GO111MODULE=on
ENV GOPROXY=https://proxy.golang.org,direct
RUN curl -sSfL https://raw.githubusercontent.com/golang/go/master/src/go/version.info | grep 'version = "go1.21"' && \
    apt-get update && \
    apt-get install -y golang-go && \
    go version
RUN go env -w GOPRIVATE=git.jxedc.com
RUN go mod tidy

# 复制源代码到工作目录
COPY . .

# 构建插件
RUN go build -o go_plugin/impl_plugin

# 设置容器启动时运行的命令
ENTRYPOINT ["./go_plugin"]
