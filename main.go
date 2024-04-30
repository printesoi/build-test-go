package main

import (
	_ "github.com/kelseyhightower/envconfig"
	"github.com/printesoi/build-test-go/subpackage"
)

type Config struct {
	Type string
}

func main() {
	subpackage.Hello()

	_ = subpackage.Config{}
}
