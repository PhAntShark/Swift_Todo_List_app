import Foundation

public final class ConsoleUI {
    private let todoManager: TodoManager
    private let storageService: StorageService

    public init(todoManager: TodoManager, storageService: StorageService) {
        self.todoManager = todoManager
        self.storageService = storageService
    }

    public func run() {
        while true {
            printMenu()

            guard let choice = readInt() else {
                print("Invalid menu choice. Please enter a number.")
                continue
            }

            switch choice {
            case 1:
                addTaskFlow()
            case 2:
                viewTasksFlow()
            case 3:
                markCompletedFlow()
            case 4:
                markIncompleteFlow()
            case 5:
                deleteTaskFlow()
            case 6:
                searchTasksFlow()
            case 7:
                showCompletedTasksFlow()
            case 8:
                showIncompleteTasksFlow()
            case 9:
                print("Goodbye!")
                storageService.save(todoManager.allTasks())
                exit(0)
            default:
                print("Invalid option. Please choose a number from 1 to 9.")
            }
        }
    }

    private func printMenu() {
        print("\n========================")
        print("       TODO LIST")
        print("========================")
        print("1. Add task")
        print("2. View tasks")
        print("3. Mark task as completed")
        print("4. Mark task as incomplete")
        print("5. Delete task")
        print("6. Search tasks")
        print("7. Show completed tasks")
        print("8. Show incomplete tasks")
        print("9. Exit")
        print("========================")
        print("Choose an option: ", terminator: "")
    }

    private func addTaskFlow() {
        print("Enter task title: ", terminator: "")

        guard let title = readLine(), !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            print("Task title cannot be empty.")
            return
        }

        let newTask = todoManager.addTask(title: title)
        print("Task added successfully: \(newTask.title)")
        storageService.save(todoManager.allTasks())
    }

    private func viewTasksFlow() {
        let tasks = todoManager.allTasks()
        displayTasks(tasks)
    }

    private func markCompletedFlow() {
        print("Enter task ID to mark as completed: ", terminator: "")

        guard let id = readInt() else {
            print("Invalid task ID.")
            return
        }

        if todoManager.markTaskCompleted(id: id) {
            print("Task marked as completed.")
            storageService.save(todoManager.allTasks())
        } else {
            print("Task not found.")
        }
    }

    private func markIncompleteFlow() {
        print("Enter task ID to mark as incomplete: ", terminator: "")

        guard let id = readInt() else {
            print("Invalid task ID.")
            return
        }

        if todoManager.markTaskIncomplete(id: id) {
            print("Task marked as incomplete.")
            storageService.save(todoManager.allTasks())
        } else {
            print("Task not found.")
        }
    }

    private func deleteTaskFlow() {
        print("Enter task ID to delete: ", terminator: "")

        guard let id = readInt() else {
            print("Invalid task ID.")
            return
        }

        if todoManager.deleteTask(id: id) {
            print("Task deleted successfully.")
            storageService.save(todoManager.allTasks())
        } else {
            print("Task not found.")
        }
    }

    private func searchTasksFlow() {
        print("Enter search term: ", terminator: "")

        guard let searchTerm = readLine() else {
            print("Invalid search term.")
            return
        }

        let matches = todoManager.searchTasks(term: searchTerm)
        displayTasks(matches)
    }

    private func showCompletedTasksFlow() {
        let tasks = todoManager.completedTasks()
        displayTasks(tasks)
    }

    private func showIncompleteTasksFlow() {
        let tasks = todoManager.incompleteTasks()
        displayTasks(tasks)
    }

    private func displayTasks(_ tasks: [TodoItem]) {
        if tasks.isEmpty {
            print("No tasks found.")
            return
        }

        for task in tasks {
            let status = task.isCompleted ? "[x]" : "[ ]"
            print("\(task.id). \(status) \(task.title)")
        }
    }

    private func readInt() -> Int? {
        guard let input = readLine(), let value = Int(input.trimmingCharacters(in: .whitespacesAndNewlines)) else {
            return nil
        }
        return value
    }
}
