import Foundation

public final class StorageService {
    private let fileManager: FileManager
    private let fileURL: URL

    public init(fileManager: FileManager = .default, fileName: String = "todos.json") {
        self.fileManager = fileManager
        let currentDirectory = fileManager.currentDirectoryPath
        self.fileURL = URL(fileURLWithPath: currentDirectory).appendingPathComponent(fileName)
    }

    public func load() -> [TodoItem] {
        guard fileManager.fileExists(atPath: fileURL.path) else {
            return []
        }

        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            let tasks = try decoder.decode([TodoItem].self, from: data)
            return tasks
        } catch {
            return []
        }
    }

    public func save(_ tasks: [TodoItem]) {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = [.prettyPrinted, .sortedKeys]

            let data = try encoder.encode(tasks)
            try data.write(to: fileURL, options: .atomic)
        } catch {
            print("Unable to save tasks: \(error.localizedDescription)")
        }
    }
}
