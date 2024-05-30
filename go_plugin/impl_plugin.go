package main

import "fmt"

type MyPlugin struct{}

// 实现插件
func (p *MyPlugin) Execute() string {
	return "Hello from MyPlugin!"
}

func main() {

	fmt.Println("Testing MyPlugin...")
	plugin := &MyPlugin{}
	result := plugin.Execute()
	fmt.Println(result)
}
