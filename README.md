# HelloApp

iOS app developed on Linux; builds and code-signing happen on Mac.

## Architecture

- **`Packages/AppCore`**: Pure-Swift core (models, networking, domain). Builds and tests on Linux.
- **`HelloApp`**: SwiftUI shell (iOS 17+). Builds only on macOS.

## Linux Development

Linux handles the core logic (AppCore). Run commands from repo root:

```bash
make verify      # lint → build → test
make format      # format in place
make test        # run tests
make docker-test # test in reproducible container
```

## macOS Setup (When You Have Mac Access)

### 1. Transfer Repo to Mac

```bash
rsync -avz -e ssh helloapp/ user@mac:/path/to/helloapp/
```

### 2. Open in Xcode

Option A (SPM):
```bash
cd HelloApp && swift build -c release
```
This also works with Xcode (right-click → Open With → Xcode).

Option B (Xcode Project):
```bash
cd HelloApp
xcodebuild -create-xcodeproj
```
Then open `HelloApp.xcodeproj` and build.

### 3. First Build (Simulator)

Without a Developer account, you can build for simulator only:
```bash
xcodebuild build -scheme HelloApp -destination 'platform=iOS Simulator,name=iPhone 15 Pro'
```

### 4. With Apple Developer Account

You already have an account! Sign in to Xcode → Preferences → Accounts → Add Apple ID. Enable "Automatically manage signing" in Project Settings (Xcode generates certificates/profiles automatically). Then build for device:
```bash
xcodebuild -scheme HelloApp -destination 'generic/platform=iOS' archive
```

## CI

- Linux: `swift format lint` + `swift test` for AppCore
- macOS: `swift build` + `xcodebuild` for HelloApp (simulator)

GitHub Actions: `.github/workflows/ci.yml`

## Local Setup Notes

- **Toolchain**: Swift 6.3.3 manually installed at `~/tools/swift-6.3.3`. Never `apt install swift` (wrong package).
- **swift-format**: Subcommand before options (`swift format lint ...`, not `--strict lint`). Config not auto-discovered recursively.
- **Docker**: `swift:6.3.3-noble` is a locally patched image (corrupted layer workaround). See `AGENTS.md`.

## Next Steps

1. Create GitHub repo and push (`git remote add origin ...`)
2. Access a Mac and run the above setup
3. Get Apple Developer account when ready for physical device builds
