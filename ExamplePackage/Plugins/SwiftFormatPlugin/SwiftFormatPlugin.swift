import Foundation
import PackagePlugin

/// Entry point for the SwiftLintPlugin.
@main
struct SwiftLintPlugin: BuildToolPlugin {
    /// This entry point is called when operating on a Swift package.
    func createBuildCommands(context: PluginContext, target: Target) throws -> [Command] {
        // This line sets the path to the script that will be executed by the plugin.
        let scriptPath = context.package
            .directoryURL
            .appending(path: "Plugins/SwiftFormatPlugin/swift-format-lint-script.sh")
            .path

        let configurationPath = context.package
            .directoryURL
            .appending(path: ".swiftformat")
            .path

        let packagePath = context.package
            .directoryURL
            .path

        return [
            .buildCommand(
                displayName: "Running SwiftFormatPlugin",
                executable: URL(filePath: "/bin/bash"),
                arguments: [
                    scriptPath,
                    packagePath,
                    configurationPath,
                ],
                environment: [:],
                inputFiles: [],
                outputFiles: []
            )
        ]
    }
}
