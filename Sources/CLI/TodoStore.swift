import Foundation

class TodoStore {
    private var items: [TodoItem] = []
    
    init() {
        loadItems()
    }
    
    func loadItems() {
        items = TodoItem.loadFromFile()
    }
    
    func saveItems() {
        TodoItem.saveToFile(items)
    }
    
    func addItem(title: String) {
        let newItem = TodoItem(title: title)
        items.append(newItem)
        saveItems()
        print("✅ Added: \(title)")
    }
    
    func listItems(showCompleted: Bool = true) {
        let activeItems = items.filter { !$0.isCompleted }
        let completedItems = items.filter { $0.isCompleted }
        
        if items.isEmpty {
            print("📝 No tasks yet! Add one with: add <task>")
            return
        }
        
        if !activeItems.isEmpty {
            print("\n📋 Active Tasks:")
            for (index, item) in activeItems.enumerated() {
                print("  \(index + 1). \(item.displayString)")
            }
        }
        
        if showCompleted && !completedItems.isEmpty {
            print("\n✅ Completed Tasks:")
            for (index, item) in completedItems.enumerated() {
                print("  \(index + 1). \(item.displayString)")
            }
        }
        
        print("\n📊 Summary: \(activeItems.count) active, \(completedItems.count) completed")
    }
    
    func completeItem(at index: Int) -> Bool {
        let activeItems = items.filter { !$0.isCompleted }
        guard index > 0 && index <= activeItems.count else {
            print("❌ Invalid task number. Use 'list' to see available tasks.")
            return false
        }
        
        let itemToComplete = activeItems[index - 1]
        if let globalIndex = items.firstIndex(where: { $0.id == itemToComplete.id }) {
            items[globalIndex].isCompleted = true
            saveItems()
            print("✅ Completed: \(itemToComplete.title)")
            return true
        }
        return false
    }
    
    func uncompleteItem(at index: Int) -> Bool {
        let completedItems = items.filter { $0.isCompleted }
        guard index > 0 && index <= completedItems.count else {
            print("❌ Invalid completed task number.")
            return false
        }
        
        let itemToUncomplete = completedItems[index - 1]
        if let globalIndex = items.firstIndex(where: { $0.id == itemToUncomplete.id }) {
            items[globalIndex].isCompleted = false
            saveItems()
            print("⬜ Uncompleted: \(itemToUncomplete.title)")
            return true
        }
        return false
    }
    
    func deleteItem(at index: Int) -> Bool {
        guard index > 0 && index <= items.count else {
            print("❌ Invalid task number. Use 'list' to see available tasks.")
            return false
        }
        
        let removedItem = items.remove(at: index - 1)
        saveItems()
        print("🗑️ Deleted: \(removedItem.title)")
        return true
    }
    
    func clearCompleted() {
        let beforeCount = items.count
        items = items.filter { !$0.isCompleted }
        let removedCount = beforeCount - items.count
        
        if removedCount > 0 {
            saveItems()
            print("🗑️ Removed \(removedCount) completed task(s)")
        } else {
            print("ℹ️ No completed tasks to remove")
        }
    }
}