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

        let configuration = context.package
            .directoryURL
            .appending(path: ".swiftformat")

        let packagePath = context.package
            .directoryURL
            .path

        // Collect your input files so Xcode knows when to re-run
        let swiftSourceFiles =
            target.sourceModule?.sourceFiles
            .filter { $0.type == .source && $0.url.pathExtension == "swift" }
            .map { $0.url }
            ?? []

        // Define a "Stamp" file in the plugin's working directory
        // This file tells Xcode "The linting for this build is done"
        let timestampFile = context.pluginWorkDirectoryURL
            .appending(path: "swiftformat.stamp")
            .path()

        return [
            .buildCommand(
                displayName: "Running SwiftFormatPlugin",
                executable: URL(filePath: "/bin/bash"),
                arguments: [
                    scriptPath,
                    packagePath,
                    configuration.path,
                    timestampFile,
                ],
                environment: [:],
                inputFiles: swiftSourceFiles,
                outputFiles: [configuration]
            )
        ]
    }
}
