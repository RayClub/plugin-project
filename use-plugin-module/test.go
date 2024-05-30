package main

import (
	"plugin"
)

func main() {
	p, err := plugin.Open("plugin/go_plugin.so")
	if err != nil {
		println(err.Error())
		return
	}

	v, err := p.Lookup("V")
	if err != nil {
		println(err.Error())
		return
	}
	f, err := p.Lookup("F")
	if err != nil {
		println(err.Error())
		return
	}
	*v.(*int) = 7
	f.(func())() // prints "Hello, number 7"
}
