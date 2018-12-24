package %HERE%_test

import (
	"testing"

	"github.com/franela/goblin"
	. "github.com/onsi/gomega"
)

func TestFunctionality(t *testing.T) {
	g := goblin.Goblin(t)
	RegisterFailHandler(func(m string, _ ...int) { g.Fail(m) })

	g.Describe("", func() {
		g.It("should ", func() {
		})
	})
}
