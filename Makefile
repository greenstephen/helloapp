PKG := Packages/AppCore

# Run from the repo root so .swift-format is discovered in the cwd.
.PHONY: verify build test format format-check docker-test clean

verify: format-check build test

# NOTE: subcommand must come before options in this swift-format version,
# and the config file is NOT auto-discovered, so pass it explicitly.
format-check:
	swift format lint --strict --configuration .swift-format -r Packages

format:
	swift format format --in-place --configuration .swift-format -r Packages

build:
	swift build --package-path $(PKG)

test:
	swift test --package-path $(PKG)

docker-test:
	./scripts/docker-test.sh

clean:
	cd $(PKG) && rm -rf .build
