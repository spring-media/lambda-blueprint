NAME := lambda-blueprint
PKG := github.com/spring-media/$(NAME)

# Set an output prefix, which is the local directory if not specified
PREFIX?=$(shell pwd)
# Set the build dir, where built cross-compiled binaries will be output
BUILDDIR := $(PREFIX)/bin
FUNCDIR := func

# Binary dependencies for this Makefile
BIN_DIR := $(GOPATH)/bin
VGO := $(BIN_DIR)/vgo
LINTER := $(BIN_DIR)/golint
STATIC_CHECK := $(BIN_DIR)/staticcheck

# Set our default go compiler
GO ?= vgo

all: clean build fmt lint test staticcheck vet

$(VGO):
	go get -u golang.org/x/vgo

.PHONY: build
build: $(VGO) ## Builds static executables
	@echo "+ $@"
	@for dir in `ls $(FUNCDIR)`; do \
		CGO_ENABLED=0 $(GO) build $(PKG)/$(FUNCDIR)/$$dir; \
	done

.PHONY: fmt
fmt: ## Verifies all files have men `gofmt`ed
	@echo "+ $@"
	@gofmt -s -l . | grep -v '.pb.go:' | grep -v vendor | tee /dev/stderr

$(LINTER):
	go get -u golang.org/x/lint/golint

.PHONY: lint
lint: $(LINTER) ## Verifies `golint` passes
	@echo "+ $@"
	@golint ./... | grep -v '.pb.go:' | grep -v vendor | tee /dev/stderr

.PHONY: vet
vet: $(VGO) ## Verifies `go vet` passes
	@echo "+ $@"
	@$(GO) vet $(shell go list ./... | grep -v vendor) | grep -v '.pb.go:' | tee /dev/stderr

$(STATIC_CHECK):
	go get -u honnef.co/go/tools/cmd/staticcheck

.PHONY: staticcheck
staticcheck: $(STATIC_CHECK) ## Verifies `staticcheck` passes
	@echo "+ $@"
	@staticcheck $(shell go list ./... | grep -v vendor) | grep -v '.pb.go:' | tee /dev/stderr

.PHONY: test
test: $(VGO) ## Runs the go tests
	@echo "+ $@"
	$(GO) test -v $(shell go list ./... | grep -v vendor)

.PHONY: cover
cover: ## Runs go test with coverage
	@echo "" > coverage.txt
	@for d in $(shell go list ./... | grep -v vendor); do \
		$(GO) test -race -coverprofile=profile.out -covermode=atomic "$$d"; \
		if [ -f profile.out ]; then \
			cat profile.out >> coverage.txt; \
			rm profile.out; \
		fi; \
	done;

.PHONY: release
release: ## Builds cross-compiled binaries
	@echo "+ $@"
	@for dir in `ls $(FUNCDIR)`; do \
		GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build \
		-o $(BUILDDIR)/$$dir -a $(PKG)/$(FUNCDIR)/$$dir; \
	done

.PHONY: deploy
deploy: ## Builds or changes infrastructure using Terraform
	@echo "+ $@"
	@ cd terraform && terraform apply

.PHONY: destroy
destroy: ## Destroy Terraform-managed infrastructure
	@echo "+ $@"
	@ cd terraform && terraform destroy

.PHONY: clean
clean: ## Cleanup any build binaries or packages
	@echo "+ $@"
	$(RM) $(NAME)
	$(RM) -r $(BUILDDIR)
	@for dir in `ls $(FUNCDIR)`; do \
		$(RM) $$dir ; \
	done	

.PHONY: help
help: ## Display this help screen
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'	