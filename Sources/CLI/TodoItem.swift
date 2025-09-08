import Foundation

struct TodoItem: Codable, Identifiable {
    let id = UUID()
    var title: String
    var isCompleted: Bool = false
    var createdAt: Date = Date()
    
    init(title: String) {
        self.title = title
    }
}

// CLI-specific extensions
extension TodoItem {
    static let storageURL: URL = {
        let homeDir = FileManager.default.homeDirectoryForCurrentUser
        return homeDir.appendingPathComponent(".todoapp_tasks.json")
    }()
    
    static func loadFromFile() -> [TodoItem] {
        guard let data = try? Data(contentsOf: storageURL),
              let items = try? JSONDecoder().decode([TodoItem].self, from: data) else {
            return []
        }
        return items
    }
    
    static func saveToFile(_ items: [TodoItem]) {
        if let data = try? JSONEncoder().encode(items) {
            try? data.write(to: storageURL)
        }
    }
    
    var displayString: String {
        let checkbox = isCompleted ? "✅" : "⬜"
        let title = isCompleted ? "~~\(self.title)~~" : self.title
        let date = DateFormatter.short.string(from: createdAt)
        return "\(checkbox) \(title) (created: \(date))"
    }
}

extension DateFormatter {
    static let short: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter
    }()
}