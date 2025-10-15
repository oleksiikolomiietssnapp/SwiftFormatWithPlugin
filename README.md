# SwiftFormatLintPlugin - Reusable Swift Package Plugin

This repository contains a **reusable Swift Package Manager plugin** that integrates swift-format linting into any Swift package, plus an example package demonstrating its usage.

## Repository Structure

- **SwiftFormatLintPlugin/** - The reusable plugin package that can be distributed and used in any project
- **ExamplePackage/** - Example package demonstrating how to use the plugin

## Features

- **Reusable Plugin**: SwiftFormatLintPlugin can be added as a dependency to any Swift package
- **Zero Configuration**: Just add the dependency and plugin reference to your Package.swift
- **Swift-Format Integration**: Automatically runs swift-format linting during build
- **Swift Package & Xcode Project Support**: Works with SPM packages and Xcode projects (Xcode 14+)
- **Customizable**: Configure via `.swiftformat` file in your package root

## Usage

### Adding to Your Package

1. Add SwiftFormatLintPlugin as a dependency in your `Package.swift`:

```swift
// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "YourPackage",
    dependencies: [
        // For local development:
        .package(path: "../SwiftFormatLintPlugin")
        // For production (once published):
        // .package(url: "https://github.com/yourusername/SwiftFormatLintPlugin.git", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "YourTarget",
            plugins: [
                .plugin(name: "SwiftFormatPlugin", package: "SwiftFormatLintPlugin")
            ]
        )
    ]
)
```

2. Create a `.swiftformat` configuration file in your package root:

```json
{
  "version": 1,
  "lineLength": 120,
  "indentation": {
    "spaces": 4
  },
  "respectsExistingLineBreaks": true
}
```

3. Build your package - the plugin will run automatically!

### Adding to Xcode Projects

The plugin supports Xcode projects via `XcodeBuildToolPlugin` (Xcode 14+), but requires additional manual setup:

1. **Add the package dependency** to your Xcode project:
   - File → Add Package Dependencies
   - Add SwiftFormatLintPlugin package

2. **Enable the plugin for each target**:
   - Select your target in Xcode
   - Go to Build Phases tab
   - Expand "Run Build Tool Plug-ins"
   - Click "+" and add "SwiftFormatPlugin"

3. **Add configuration file to project**:
   - Create `.swiftformat` file in your project directory
   - **Important**: Add the file to your Xcode project (not just the filesystem) so the plugin can discover it
   - The plugin looks for the config in `target.inputFiles`

4. **Verify swift-format is installed**:
   ```bash
   swift-format --version
   ```

**Note**: Unlike SPM packages where the plugin runs automatically, Xcode projects require explicit Build Phase configuration for each target.

## Step by step implementation

[Link to medium article]()

## Requirements

- Swift 6.0 or later
- swift-format tool installed (via Xcode or Homebrew)
- Xcode 14 or later (for Xcode project support via XcodeBuildToolPlugin)

## Contributing

Feel free to submit issues or improvements. Contributions are welcome!
