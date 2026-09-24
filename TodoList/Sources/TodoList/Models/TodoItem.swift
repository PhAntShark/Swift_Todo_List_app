import Foundation

public struct TodoItem: Identifiable, Codable, Equatable {
    public let id: Int
    public var title: String
    public var isCompleted: Bool
    public var createdAt: Date

    public init(id: Int, title: String, isCompleted: Bool = false, createdAt: Date = Date()) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
        self.createdAt = createdAt
    }
}
