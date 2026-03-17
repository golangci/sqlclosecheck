PHONY: build install test

build:
	go build -o sqlclosecheck .

install:
	go install

test: build
	go test ./...
	# Due to an issue with importing in a anaylsistest's test data some hoop jumping is required
	# I call twice to avoid collecting package downloads in output
	-go vet -vettool=sqlclosecheck ./testdata/sqlx_examples
	-go vet -vettool=sqlclosecheck ./testdata/sqlx_examples 2> sqlx_examples_results.txt
	diff -a sqlx_examples_results.txt ./testdata/sqlx_examples/expected_results.txt

	-go vet -vettool=sqlclosecheck ./testdata/pgx_examples
	-go vet -vettool=sqlclosecheck ./testdata/pgx_examples 2> pgx_examples_results.txt
	diff -a pgx_examples_results.txt ./testdata/pgx_examples/expected_results.txt

lint:
	golangci-lint run
