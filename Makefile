PHONY: build install test

BIN_OUTPUT := $(if $(filter $(shell go env GOOS), windows),sqlclosecheck.exe,sqlclosecheck)

build:
	go build -o ${BIN_OUTPUT} .

install:
	go install

test: build
	go test ./...
	# Due to an issue with importing in a anaylsistest's test data some hoop jumping is required
	# I call twice to avoid collecting package downloads in output
	-go vet -vettool=${BIN_OUTPUT} ./testdata/sqlx_examples
	-go vet -vettool=${BIN_OUTPUT} ./testdata/sqlx_examples 2> sqlx_examples_results.txt
	diff -a sqlx_examples_results.txt ./testdata/sqlx_examples/expected_results.txt

	-go vet -vettool=${BIN_OUTPUT} ./testdata/pgx_examples
	-go vet -vettool=${BIN_OUTPUT} ./testdata/pgx_examples 2> pgx_examples_results.txt
	diff -a pgx_examples_results.txt ./testdata/pgx_examples/expected_results.txt

lint:
	golangci-lint run
