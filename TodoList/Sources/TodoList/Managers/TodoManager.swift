import Foundation

public final class TodoManager {
    private var tasks: [TodoItem]
    private var nextID: Int

    public init(tasks: [TodoItem] = []) {
        self.tasks = tasks

        if let maxID = tasks.map(\.id).max() {
            self.nextID = maxID + 1
        } else {
            self.nextID = 1
        }
    }

    public func addTask(title: String) -> TodoItem {
        let cleanedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        let item = TodoItem(id: nextID, title: cleanedTitle)
        nextID += 1
        tasks.append(item)
        return item
    }

    public func allTasks() -> [TodoItem] {
        tasks
    }

    public func markTaskCompleted(id: Int) -> Bool {
        guard let index = tasks.firstIndex(where: { $0.id == id }) else {
            return false
        }

        tasks[index].isCompleted = true
        return true
    }

    public func markTaskIncomplete(id: Int) -> Bool {
        guard let index = tasks.firstIndex(where: { $0.id == id }) else {
            return false
        }

        tasks[index].isCompleted = false
        return true
    }

    public func deleteTask(id: Int) -> Bool {
        guard let index = tasks.firstIndex(where: { $0.id == id }) else {
            return false
        }

        tasks.remove(at: index)
        return true
    }

    public func searchTasks(term: String) -> [TodoItem] {
        let searchTerm = term.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()

        guard !searchTerm.isEmpty else {
            return tasks
        }

        return tasks.filter { $0.title.lowercased().contains(searchTerm) }
    }

    public func completedTasks() -> [TodoItem] {
        tasks.filter { $0.isCompleted }
    }

    public func incompleteTasks() -> [TodoItem] {
        tasks.filter { !$0.isCompleted }
    }

    public func replaceAllTasks(with newTasks: [TodoItem]) {
        self.tasks = newTasks

        if let maxID = newTasks.map(\.id).max() {
            self.nextID = maxID + 1
        } else {
            self.nextID = 1
        }
    }
}
