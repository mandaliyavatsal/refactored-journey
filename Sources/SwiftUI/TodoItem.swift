import Foundation

struct TodoItem: Identifiable, Codable {
    let id = UUID()
    var title: String
    var isCompleted: Bool = false
    var createdAt: Date = Date()
    
    init(title: String) {
        self.title = title
    }
}

// Extension for UserDefaults persistence
extension TodoItem {
    static let storageKey = "TodoItems"
    
    static func loadFromUserDefaults() -> [TodoItem] {
        guard let data = UserDefaults.standard.data(forKey: storageKey),
              let items = try? JSONDecoder().decode([TodoItem].self, from: data) else {
            return []
        }
        return items
    }
    
    static func saveToUserDefaults(_ items: [TodoItem]) {
        if let data = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(data, forKey: storageKey)
        }
    }
}