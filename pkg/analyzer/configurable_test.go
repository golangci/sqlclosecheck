package analyzer_test

import (
	"testing"

	"github.com/golangci/sqlclosecheck/pkg/analyzer"
	"golang.org/x/tools/go/analysis/analysistest"
)

func TestConfigurableAnalyzerDeferOnly(t *testing.T) {
	t.Parallel()

	testdata := analysistest.TestData()
	checker := analyzer.NewConfigurableAnalyzer(analyzer.ConfigurableAnalyzerDeferOnly)

	packages := []string{
		"github.com/golangci/sqlclosecheck/pkg/analyzer/testdata/rows",
		"github.com/golangci/sqlclosecheck/pkg/analyzer/testdata/stmt",
		"github.com/golangci/sqlclosecheck/pkg/analyzer/testdata/pgx",
	}

	for _, pkg := range packages {
		pkg := pkg

		t.Run(pkg, func(t *testing.T) {
			t.Parallel()

			analysistest.Run(t, testdata, checker, pkg)
		})
	}
}

func XTestConfigurableAnalyzerClosed(t *testing.T) {
	t.Parallel()

	testdata := analysistest.TestData()
	checker := analyzer.NewConfigurableAnalyzer(analyzer.ConfigurableAnalyzerClosed)

	packages := []string{
		"github.com/golangci/sqlclosecheck/pkg/analyzer/testdata/closed",
	}

	for _, pkg := range packages {
		pkg := pkg

		t.Run(pkg, func(t *testing.T) {
			t.Parallel()

			analysistest.Run(t, testdata, checker, pkg)
		})
	}
}
