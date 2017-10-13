package main_test

import (
	"testing"

	. "github.com/franela/goblin"
	. "github.com/onsi/gomega"
)

func TestHandlers(t *testing.T) {
	g := Goblin(t)
	RegisterFailHandler(func(m string, _ ...int) { g.Fail(m) })

	g.Describe("", func() {
		g.It("should ", func() {
		})
	})
}
