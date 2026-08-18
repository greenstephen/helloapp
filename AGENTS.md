# AGENTS.md

iOS app developed on Linux; builds/code-signing happen later on a Mac.
Architecture split so Linux does the heavy lifting:

- `Packages/AppCore` — pure-Swift core (models, networking, domain). Must always
  `swift build` / `swift test` on Linux. **No `import UIKit`/`import SwiftUI` here**
  (verified: `import SwiftUI` fails on Linux).
- App UI target (SwiftUI shell) comes later and is compiled on macOS only.

## Toolchain

- Swift 6.3.3 installed manually at `~/tools/swift-6.3.3` (official
  `swift-6.3.3-RELEASE-ubuntu24.04` tarball + vendored libs; there is **no
  official build for Ubuntu 26.04** yet). On `PATH` via `~/.bashrc`.
- Never `apt install swift` — that package is an unrelated plotting library.
- `swift-format` ships in the toolchain and works on Linux. SwiftLint does not;
  don't plan around it.

## Commands (from repo root)

| Task | Command |
|---|---|
| Verify (lint → build → test) | `make verify` |
| Format in place | `make format` |
| Build / test | `make build` / `make test` |
| Test in official container | `make docker-test` |

CI (`.github/workflows/ci.yml`): lint + `swift test` in the `swift:6.3.3-noble`
container on push/PR.

## Gotchas

- `swift format` (toolchain 6.3.3): subcommand must come **before** options
  (`swift format lint --strict ...`, not `swift format --strict lint`), and the
  config file is **not** auto-discovered in recursive runs — always pass
  `--configuration .swift-format`.
- `make docker-test` uses local image `swift:6.3.3-noble`, which is a
  **locally rebuilt fix**: the original pull (interrupted by a crash) left its
  toolchain binaries as 0-byte files (`exec /usr/bin/swift: exec format error`).
  The fix layers the working tree from `~/tools/swift-6.3.3/usr` over the base
  image. **Do not `docker pull swift:6.3.3-noble` here** — it re-tags the
  corrupted image over the fix. Rebuild if needed:
  `cp -a ~/tools/swift-6.3.3/usr /tmp/swiftfix/usr`,
  Dockerfile: `FROM swift:6.3.3-noble` + `COPY usr/ /usr/`,
  build, then `docker tag` the result to `swift:6.3.3-noble`.
