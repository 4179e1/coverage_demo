PWDSLASH:=$(shell pwd|sed 's/\//\\\//g')

all: format main test

main: 
	go build -o binary

unittest:
	go test -v -covermode=count -coverprofile=coverage.out -coverpkg ./... ./...
	#workaround:https://github.com/golang/go/issues/22430
	#@sed -i "s/_${PWDSLASH}/./g" coverage.out
	@go tool cover -html=coverage.out -o coverage.html
	@go tool cover -func=coverage.out -o coverage.txt
	@tail -n 1 coverage.txt | awk '{print $$1,$$3}'

systemtest:
	go test -c -o binary.test -covermode=count -coverpkg ./...
	bash systemtest.sh

test: unittest systemtest
	@echo 'mode: count' > total.out
	@tail -q -n +2 coverage.out >> total.out
	@tail -q -n +2 system.out >> total.out
	@sed -i "s/_${PWDSLASH}/./g" total.out
	@go tool cover -html=total.out -o total.html
	@go tool cover -func=total.out -o total.txt
	@tail -n 1 total.txt | awk '{print $$1,$$3}'
	

format:
	gofmt -l -w -s ./

.PHONY: all main test format


clean:
	rm -rf coverage.* binary binary.test system.out total.*