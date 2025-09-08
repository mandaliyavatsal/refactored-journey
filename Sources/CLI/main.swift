import Foundation

struct ToDoAppCLI {
    static func main() {
        let todoStore = TodoStore()
        
        print("🎯 Welcome to ToDoApp CLI!")
        print("Type 'help' for available commands or 'quit' to exit.")
        
        if CommandLine.arguments.count > 1 {
            // Handle command line arguments
            let args = Array(CommandLine.arguments.dropFirst())
            handleCommand(args.joined(separator: " "), todoStore: todoStore)
            return
        }
        
        // Interactive mode
        while true {
            print("\n> ", terminator: "")
            
            guard let input = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines) else {
                continue
            }
            
            if input.isEmpty { continue }
            
            if input.lowercased() == "quit" || input.lowercased() == "exit" {
                print("👋 Goodbye!")
                break
            }
            
            handleCommand(input, todoStore: todoStore)
        }
    }
    
    static func handleCommand(_ input: String, todoStore: TodoStore) {
        let components = input.components(separatedBy: " ")
        let command = components[0].lowercased()
        let args = Array(components.dropFirst())
        
        switch command {
        case "help", "h":
            printHelp()
            
        case "list", "ls", "l":
            let showCompleted = !args.contains("--active")
            todoStore.listItems(showCompleted: showCompleted)
            
        case "add", "a":
            if args.isEmpty {
                print("❌ Please provide a task title. Usage: add <task>")
            } else {
                let title = args.joined(separator: " ")
                todoStore.addItem(title: title)
            }
            
        case "complete", "done", "c":
            if let indexStr = args.first, let index = Int(indexStr) {
                _ = todoStore.completeItem(at: index)
            } else {
                print("❌ Please provide a task number. Usage: complete <number>")
            }
            
        case "uncomplete", "undo", "u":
            if let indexStr = args.first, let index = Int(indexStr) {
                _ = todoStore.uncompleteItem(at: index)
            } else {
                print("❌ Please provide a completed task number. Usage: uncomplete <number>")
            }
            
        case "delete", "del", "d", "remove", "rm":
            if let indexStr = args.first, let index = Int(indexStr) {
                _ = todoStore.deleteItem(at: index)
            } else {
                print("❌ Please provide a task number. Usage: delete <number>")
            }
            
        case "clear":
            todoStore.clearCompleted()
            
        case "reload", "refresh":
            todoStore.loadItems()
            print("🔄 Reloaded tasks from storage")
            
        default:
            // Try to add as a task if it doesn't match any command
            if !input.isEmpty {
                todoStore.addItem(title: input)
            } else {
                print("❌ Unknown command: \(command). Type 'help' for available commands.")
            }
        }
    }
    
    static func printHelp() {
        print("""
        
        📋 ToDoApp CLI - Available Commands:
        
        📝 Adding Tasks:
          add <task>          Add a new task
          <task>              Add a new task (shortcut)
        
        📋 Viewing Tasks:
          list                List all tasks
          list --active       List only active tasks
          ls, l               Short aliases for list
        
        ✅ Managing Tasks:
          complete <number>   Mark task as completed
          done <number>       Alias for complete
          uncomplete <number> Mark completed task as active
          undo <number>       Alias for uncomplete
        
        🗑️ Removing Tasks:
          delete <number>     Delete a specific task
          del, rm <number>    Short aliases for delete
          clear               Remove all completed tasks
        
        🔧 Utility:
          help                Show this help message
          reload              Reload tasks from storage
          quit, exit          Exit the application
        
        💡 Tips:
        - Task numbers are shown in the list command
        - Tasks are automatically saved to ~/.todoapp_tasks.json
        - Use 'list --active' to hide completed tasks
        
        """)
    }
}

// Entry point
ToDoAppCLI.main()