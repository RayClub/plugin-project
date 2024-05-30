package main

import "fmt"

type GoPlugin struct{}

var MyPlugin GoPlugin

// 实现插件
func (p *GoPlugin) Execute() string {
	return "Hello from MyPlugin!"
}

func main() {

	fmt.Println("Testing MyPlugin...")
	plugin := &GoPlugin{}
	result := plugin.Execute()
	fmt.Println(result)
}
