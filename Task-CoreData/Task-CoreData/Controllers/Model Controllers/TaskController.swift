//
//  TaskController.swift
//  Task-CoreData
//
//  Created by Travis Halle on 4/27/21.
//

import CoreData

class TaskController {
    
    //MARK: Properties
    static let sharedInstance = TaskController()
    var sections: [[Task]] { [incompleteTasks, completeTasks] }
    var tasks: [Task] = []
    var incompleteTasks: [Task] = []
    var completeTasks: [Task] = []
    
    private lazy var fetchRequest: NSFetchRequest<Task> = {
        let request  = NSFetchRequest<Task>(entityName: "Task")
        request.predicate = NSPredicate(value: true)
        return request
    }()
    
    private init() {}
    
    //MARK: Functions
    func createTask(name: String, notes: String, dueDate: Date) {
        let task = Task(name: name, notes: notes, dueDate: dueDate)
        incompleteTasks.append(task)
        CoreDataStack.saveContext()
    }
    
    func fetchTasks() {
        let tasks = (try? CoreDataStack.context.fetch(self.fetchRequest)) ?? []
        
        completeTasks = tasks.filter { $0.isComplete }
        incompleteTasks = tasks.filter { !$0.isComplete }
        
        self.tasks = tasks
    }
    
    func updateTaskDetails(task: Task) {
        CoreDataStack.saveContext()
    }
    
    func updateCompletionStatus(task: Task) {
        task.isComplete.toggle()
        if task.isComplete {
            if let index = incompleteTasks.firstIndex(of: task) {
                incompleteTasks.remove(at: index)
                completeTasks.append(task)
            }
        } else {
            if let index = completeTasks.firstIndex(of: task) {
                completeTasks.remove(at: index)
                completeTasks.append(task)
            }
        }
    }
    
    func removeTask(taskToRemove: Task) {
        
    }
}//End of class
