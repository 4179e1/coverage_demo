package biz

import (
	"coverage_demo/lib"
	"fmt"
)

func formatTwoNumber(a, b int) string {
	return fmt.Sprintf("%d-%d\n", a, b)
}
func GetRandomPair() string {
	return formatTwoNumber(lib.GetRandomNumber(), lib.GetRandomNumber())
}
