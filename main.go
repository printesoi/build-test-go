package main

import (
	_ "github.com/kelseyhightower/envconfig"
	"github.com/printesoi/build-test-go/subpackage"
)

func main() {
	subpackage.Hello()

	_ = subpackage.Config{}
}
