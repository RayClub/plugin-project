package main

// 定义插件的接口和功能
type Plugin interface {
	Execute() string
}
