# TodoList

A simple command-line to-do list application built with Swift and Swift Package Manager.

## Features

- Add tasks
- View all tasks
- Mark tasks as completed or incomplete
- Delete tasks
- Search tasks case-insensitively
- Show completed and incomplete tasks only
- Save tasks to a local JSON file
- Handle invalid input gracefully

## Project structure

```text
TodoList/
├── Package.swift
├── README.md
├── .gitignore
├── Sources/
│   └── TodoList/
│       ├── main.swift
│       ├── Models/
│       │   └── TodoItem.swift
│       ├── Managers/
│       │   └── TodoManager.swift
│       ├── Services/
│       │   └── StorageService.swift
│       └── UI/
│           └── ConsoleUI.swift
└── Tests/
    └── TodoListTests/
        └── TodoManagerTests.swift
```

## Requirements

- Swift 6.x
- Swift Package Manager

## Build

```bash
swift build
```

## Run

```bash
swift run
```

## Run tests

```bash
swift test
```

## Example usage

```text
========================
       TODO LIST
========================
1. Add task
2. View tasks
3. Mark task as completed
4. Mark task as incomplete
5. Delete task
6. Search tasks
7. Show completed tasks
8. Show incomplete tasks
9. Exit
========================
Choose an option:
```

## Notes

Tasks are saved to a local `todos.json` file in the current working directory.
