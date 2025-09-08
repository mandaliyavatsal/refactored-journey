import Foundation
import Combine

class TodoStore: ObservableObject {
    @Published var items: [TodoItem] = []
    
    init() {
        loadItems()
    }
    
    func addItem(title: String) {
        let newItem = TodoItem(title: title)
        items.append(newItem)
        saveItems()
    }
    
    func deleteItem(at indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
        saveItems()
    }
    
    func toggleCompletion(for item: TodoItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].isCompleted.toggle()
            saveItems()
        }
    }
    
    func updateItem(_ item: TodoItem, newTitle: String) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].title = newTitle
            saveItems()
        }
    }
    
    private func loadItems() {
        items = TodoItem.loadFromUserDefaults()
    }
    
    private func saveItems() {
        TodoItem.saveToUserDefaults(items)
    }
    
    var completedItems: [TodoItem] {
        items.filter { $0.isCompleted }
    }
    
    var activeItems: [TodoItem] {
        items.filter { !$0.isCompleted }
    }
}