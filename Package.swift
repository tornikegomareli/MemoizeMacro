// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import CompilerPluginSupport

let package = Package(
  name: "Memoize",
  platforms: [
    .iOS(.v13),
    .macOS(.v12),
    .tvOS(.v13),
    .watchOS(.v6),
  ],
  products: [
    .library(
      name: "Memoize",
      targets: [
        "Memoize"
      ]
    ),
    .executable(name: "MemoizeMacroClient", targets: ["MemoizeMacroClient"])
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-syntax", "509.0.0"..<"601.0.0")
  ],
  targets: [
    .macro(
      name: "MemoizeMacro",
      dependencies: [
        .product(name: "SwiftSyntax", package: "swift-syntax"),
        .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
        .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
      ]
    ),
    .target(
      name: "Memoize",
      dependencies: [
        "MemoizeMacro"
      ]
    ),
    .executableTarget(
      name: "MemoizeMacroClient",
      dependencies: [
        "Memoize"
      ]
    ),
    .testTarget(
      name: "MacroTests",
      dependencies: [
        "MemoizeMacro",
        .product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax"),
      ]
    )
  ]
)
