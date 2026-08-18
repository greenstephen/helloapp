/// AppCore is the platform-independent core of the app.
///
/// Everything in this package must compile and test on Linux
/// (`swift build` / `swift test`): no `import UIKit` or `import SwiftUI`.
/// UI code belongs in the app target, which is built only on macOS.
public enum AppCore {
    public static let name = "AppCore"
}
