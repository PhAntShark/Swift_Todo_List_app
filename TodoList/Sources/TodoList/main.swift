import Foundation

let storageService = StorageService()
let todoManager = TodoManager(tasks: storageService.load())
let consoleUI = ConsoleUI(todoManager: todoManager, storageService: storageService)

consoleUI.run()
