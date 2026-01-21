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
            .path()

        let configuration = context.package
            .directoryURL
            .appending(path: ".swiftformat")

        let packagePath = context.package
            .directoryURL
            .path()

        let swiftSourceFiles =
            target
            .sourceModule?
            .sourceFiles
            .filter { $0.type == .source && $0.url.pathExtension == "swift" }
            .map { $0.url } ?? []

        let timestampFile = context.pluginWorkDirectoryURL
            .appending(path: "swiftformat.stamp")

        return [
            .buildCommand(
                displayName: "Running SwiftFormatPlugin",
                executable: URL(filePath: "/bin/bash"),
                arguments: [
                    scriptPath,
                    packagePath,
                    configuration.path(),
                    timestampFile.path(),
                ],
                environment: [:],
                inputFiles: swiftSourceFiles,
                outputFiles: [timestampFile]
            )
        ]
    }
}
