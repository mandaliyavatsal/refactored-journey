import SwiftUI

struct ContentView: View {
    @StateObject private var todoStore = TodoStore()
    @State private var newTaskTitle = ""
    @State private var showingCompletedTasks = false
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            headerView
            
            // Add new task section
            addTaskSection
            
            Divider()
            
            // Task list
            taskListView
        }
        .frame(minWidth: 400, minHeight: 500)
        .background(Color(.windowBackgroundColor))
    }
    
    private var headerView: some View {
        VStack {
            HStack {
                Text("My To-Do List")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                Spacer()
                
                Button(action: {
                    showingCompletedTasks.toggle()
                }) {
                    Image(systemName: showingCompletedTasks ? "eye.slash" : "eye")
                        .font(.title2)
                        .foregroundColor(.secondary)
                }
                .buttonStyle(.plain)
                .help(showingCompletedTasks ? "Hide completed tasks" : "Show completed tasks")
            }
            .padding()
            
            // Task summary
            HStack {
                Text("\(todoStore.activeItems.count) active")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                if !todoStore.completedItems.isEmpty {
                    Text("•")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Text("\(todoStore.completedItems.count) completed")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
            }
            .padding(.horizontal)
            .padding(.bottom, 8)
        }
        .background(Color(.controlBackgroundColor))
    }
    
    private var addTaskSection: some View {
        HStack {
            TextField("Add a new task...", text: $newTaskTitle)
                .textFieldStyle(.roundedBorder)
                .onSubmit {
                    addNewTask()
                }
            
            Button("Add") {
                addNewTask()
            }
            .disabled(newTaskTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
        }
        .padding()
    }
    
    private var taskListView: some View {
        ScrollView {
            LazyVStack(spacing: 8) {
                if !todoStore.activeItems.isEmpty {
                    Section("Active Tasks") {
                        ForEach(todoStore.activeItems) { item in
                            TodoRowView(item: item, todoStore: todoStore)
                        }
                    }
                    .padding(.horizontal)
                }
                
                if showingCompletedTasks && !todoStore.completedItems.isEmpty {
                    Section("Completed Tasks") {
                        ForEach(todoStore.completedItems) { item in
                            TodoRowView(item: item, todoStore: todoStore)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top)
                }
                
                if todoStore.items.isEmpty {
                    VStack(spacing: 16) {
                        Image(systemName: "checkmark.circle")
                            .font(.system(size: 60))
                            .foregroundColor(.secondary)
                        
                        Text("No tasks yet")
                            .font(.title2)
                            .foregroundColor(.secondary)
                        
                        Text("Add your first task above to get started!")
                            .font(.body)
                            .foregroundColor(.tertiary)
                    }
                    .padding(40)
                }
            }
            .padding(.vertical)
        }
    }
    
    private func addNewTask() {
        let trimmedTitle = newTaskTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedTitle.isEmpty else { return }
        
        todoStore.addItem(title: trimmedTitle)
        newTaskTitle = ""
    }
}

#Preview {
    ContentView()
}