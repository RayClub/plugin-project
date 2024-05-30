package main

import (
	"fmt"
	"plugin"
)

type Plugin interface {
	Execute() string
}

func main() {
	p, err := plugin.Open("plugin/go_plugin.so")
	if err != nil {
		println(err.Error())
		return
	}

	sym, err := p.Lookup("MyPlugin")
	if err != nil {
		println(err.Error())
		return
	}

	myPlugin, ok := sym.(Plugin)
	if !ok {
		println("unexpected type from module symbol")
		return
	}

	result := myPlugin.Execute()
	fmt.Println(result)
}
