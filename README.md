# macOS To-Do List App

A native macOS to-do list application built with Swift and SwiftUI, plus a cross-platform command-line version. This app provides a clean, intuitive interface for managing your daily tasks with persistent storage.

## Two Versions Available

### 🖥️ SwiftUI macOS App
A native macOS application with a beautiful SwiftUI interface that follows macOS design principles.

### 💻 Command-Line Interface (CLI)
A cross-platform command-line version that works on macOS, Linux, and other Swift-supported platforms.

## Features

Both versions include:

- ✅ **Add Tasks**: Quickly add new tasks
- ✅ **Mark Complete**: Mark tasks as completed/incomplete
- ✅ **Edit Tasks**: Modify task titles (GUI: double-click, CLI: coming soon)
- ✅ **Delete Tasks**: Remove tasks you no longer need
- ✅ **Show/Hide Completed**: Toggle visibility of completed tasks
- ✅ **Persistent Storage**: Tasks are automatically saved and restored
- ✅ **Task Summary**: See counts of active and completed tasks

## Quick Start - CLI Version

The CLI version works immediately on any platform with Swift:

```bash
# Clone and build
git clone <repository-url>
cd refactored-journey
swift build --product ToDoAppCLI

# Run the app
.build/debug/ToDoAppCLI help

# Add some tasks
.build/debug/ToDoAppCLI "add Buy groceries"
.build/debug/ToDoAppCLI "add Finish project"

# List tasks
.build/debug/ToDoAppCLI list

# Complete a task
.build/debug/ToDoAppCLI "complete 1"

# Interactive mode
.build/debug/ToDoAppCLI
```

### CLI Commands

```
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
```

## Building the macOS SwiftUI App

### Requirements

- macOS 12.0 or later
- Xcode 14.0 or later
- Swift 6.1 or later

### Using Xcode

1. Clone this repository
2. Open `Package.swift` in Xcode
3. Select the "ToDoApp" scheme
4. Build and run the project (⌘R)

### Using Swift Package Manager (macOS only)

```bash
# Build the SwiftUI version (requires macOS)
swift build --product ToDoApp

# Run the SwiftUI app
.build/debug/ToDoApp
```

## Screenshots

### CLI Version
```
🎯 Welcome to ToDoApp CLI!

📋 Active Tasks:
  1. ⬜ Finish project documentation (created: 08/09/2025)
  2. ⬜ Call dentist (created: 08/09/2025)

✅ Completed Tasks:
  1. ✅ ~~Buy groceries~~ (created: 08/09/2025)

📊 Summary: 2 active, 1 completed
```

### SwiftUI macOS App
The SwiftUI version features:
- Clean, native macOS interface
- Sidebar-style task list
- Intuitive drag-and-drop support
- Native macOS controls and animations
- Keyboard shortcuts

## Architecture

The app is built using modern Swift patterns:

**Shared Components:**
- **TodoItem**: A model representing a task with title, completion status, and creation date

**SwiftUI Version:**
- **TodoStore**: An ObservableObject managing tasks with SwiftUI integration
- **ContentView**: The main app interface
- **TodoRowView**: A reusable component for displaying individual tasks

**CLI Version:**
- **TodoStore**: A simple class managing tasks with file persistence
- **ToDoAppCLI**: Command-line interface and argument parsing

## Data Persistence

- **SwiftUI Version**: Uses UserDefaults for seamless macOS integration
- **CLI Version**: Uses JSON file storage at `~/.todoapp_tasks.json`

Both approaches provide reliable persistence without external dependencies.

## Development

### Project Structure

```
Sources/
├── SwiftUI/          # Native macOS SwiftUI app
│   ├── main.swift
│   ├── ContentView.swift
│   ├── TodoRowView.swift
│   ├── TodoStore.swift
│   └── TodoItem.swift
└── CLI/              # Cross-platform command-line app
    ├── main.swift
    ├── TodoStore.swift
    └── TodoItem.swift
```

### Building Both Versions

```bash
# Build both versions
swift build

# Build specific version
swift build --product ToDoApp      # SwiftUI (macOS only)
swift build --product ToDoAppCLI   # CLI (cross-platform)
```

## Contributing

Feel free to submit issues and enhancement requests!

## License

This project is licensed under the Apache License 2.0 - see the [LICENSE](LICENSE) file for details.