package subpackage

import (
	"fmt"

	"github.com/printesoi/build-test-go/config"
)

type Config struct {
	config.Config
}

func Hello() {
	fmt.Println("Hello from subpackage")
}
