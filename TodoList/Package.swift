// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "TodoList",
    products: [
        .executable(name: "TodoList", targets: ["TodoList"])
    ],
    targets: [
        .executableTarget(
            name: "TodoList",
            path: "Sources/TodoList"
        ),
        .testTarget(
            name: "TodoListTests",
            dependencies: ["TodoList"],
            path: "Tests/TodoListTests"
        )
    ]
)
