import XCTest
@testable import TodoList

final class TodoManagerTests: XCTestCase {
    func testAddTask() {
        let manager = TodoManager()

        let task = manager.addTask(title: "Learn Swift")

        XCTAssertEqual(task.title, "Learn Swift")
        XCTAssertFalse(task.isCompleted)
        XCTAssertEqual(manager.allTasks().count, 1)
    }

    func testCompletingTask() {
        let manager = TodoManager()
        let task = manager.addTask(title: "Write tests")

        let success = manager.markTaskCompleted(id: task.id)

        XCTAssertTrue(success)
        XCTAssertTrue(manager.allTasks().first(where: { $0.id == task.id })?.isCompleted == true)
    }

    func testMarkingTaskIncomplete() {
        let manager = TodoManager()
        let task = manager.addTask(title: "Review code")
        _ = manager.markTaskCompleted(id: task.id)

        let success = manager.markTaskIncomplete(id: task.id)

        XCTAssertTrue(success)
        XCTAssertFalse(manager.allTasks().first(where: { $0.id == task.id })?.isCompleted ?? true)
    }

    func testDeletingTask() {
        let manager = TodoManager()
        let task = manager.addTask(title: "Delete this")

        let success = manager.deleteTask(id: task.id)

        XCTAssertTrue(success)
        XCTAssertTrue(manager.allTasks().isEmpty)
    }

    func testSearchingTasks() {
        let manager = TodoManager()
        _ = manager.addTask(title: "Learn Swift")
        _ = manager.addTask(title: "Study Git")
        _ = manager.addTask(title: "Buy groceries")

        let result = manager.searchTasks(term: "swift")

        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.title, "Learn Swift")
    }

    func testFilteringCompletedTasks() {
        let manager = TodoManager()
        let first = manager.addTask(title: "Read book")
        _ = manager.addTask(title: "Write code")
        _ = manager.markTaskCompleted(id: first.id)

        let completed = manager.completedTasks()

        XCTAssertEqual(completed.count, 1)
        XCTAssertEqual(completed.first?.id, first.id)
    }

    func testFilteringIncompleteTasks() {
        let manager = TodoManager()
        let first = manager.addTask(title: "Read book")
        _ = manager.addTask(title: "Write code")
        _ = manager.markTaskCompleted(id: first.id)

        let incomplete = manager.incompleteTasks()

        XCTAssertEqual(incomplete.count, 1)
        XCTAssertFalse(incomplete.first?.isCompleted ?? true)
    }
}
