import SwiftUI

struct TodoRowView: View {
    let item: TodoItem
    let todoStore: TodoStore
    @State private var isEditing = false
    @State private var editingTitle = ""
    
    var body: some View {
        HStack {
            // Completion checkbox
            Button(action: {
                todoStore.toggleCompletion(for: item)
            }) {
                Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                    .font(.title2)
                    .foregroundColor(item.isCompleted ? .green : .secondary)
            }
            .buttonStyle(.plain)
            
            // Task content
            if isEditing {
                TextField("Task title", text: $editingTitle)
                    .textFieldStyle(.roundedBorder)
                    .onSubmit {
                        saveEdit()
                    }
                    .onAppear {
                        editingTitle = item.title
                    }
            } else {
                VStack(alignment: .leading, spacing: 2) {
                    Text(item.title)
                        .font(.body)
                        .strikethrough(item.isCompleted)
                        .foregroundColor(item.isCompleted ? .secondary : .primary)
                    
                    Text(DateFormatter.relative.string(from: item.createdAt))
                        .font(.caption)
                        .foregroundColor(.tertiary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .contentShape(Rectangle())
                .onTapGesture(count: 2) {
                    startEditing()
                }
            }
            
            Spacer()
            
            // Action buttons
            HStack(spacing: 8) {
                if isEditing {
                    Button("Save") {
                        saveEdit()
                    }
                    .keyboardShortcut(.return)
                    
                    Button("Cancel") {
                        cancelEdit()
                    }
                    .keyboardShortcut(.escape)
                } else {
                    Button(action: {
                        startEditing()
                    }) {
                        Image(systemName: "pencil")
                            .font(.caption)
                    }
                    .buttonStyle(.plain)
                    .help("Edit task")
                    
                    Button(action: {
                        deleteTask()
                    }) {
                        Image(systemName: "trash")
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                    .buttonStyle(.plain)
                    .help("Delete task")
                }
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(.controlBackgroundColor))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color(.separatorColor), lineWidth: 0.5)
        )
    }
    
    private func startEditing() {
        isEditing = true
        editingTitle = item.title
    }
    
    private func saveEdit() {
        let trimmedTitle = editingTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        if !trimmedTitle.isEmpty {
            todoStore.updateItem(item, newTitle: trimmedTitle)
        }
        isEditing = false
    }
    
    private func cancelEdit() {
        isEditing = false
        editingTitle = item.title
    }
    
    private func deleteTask() {
        if let index = todoStore.items.firstIndex(where: { $0.id == item.id }) {
            todoStore.deleteItem(at: IndexSet(integer: index))
        }
    }
}

extension DateFormatter {
    static let relative: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .medium
        formatter.doesRelativeDateFormatting = true
        return formatter
    }()
}

#Preview {
    VStack {
        TodoRowView(item: TodoItem(title: "Sample task"), todoStore: TodoStore())
        TodoRowView(item: TodoItem(title: "Completed task"), todoStore: TodoStore())
    }
    .padding()
}