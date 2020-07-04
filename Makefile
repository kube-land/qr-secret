GOOS = $(shell go env GOOS)
GOARCH = $(shell go env GOARCH)

GO = go
GO_PACKAGES = ./...


define binary
qr-secret-$(1)-$(2):
	GOOS=$(1) GOARCH=$(2) $(GO) build -o build/$$@ .
endef

$(eval $(call binary,linux,amd64))
$(eval $(call binary,darwin,amd64))

qr-secret: qr-secret-$(GOOS)-$(GOARCH)