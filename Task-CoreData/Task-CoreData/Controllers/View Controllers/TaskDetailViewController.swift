//
//  TaskDetailViewController.swift
//  Task-CoreData
//
//  Created by Travis Halle on 4/27/21.
//

import UIKit

class TaskDetailViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var taskNotesTextfield: UITextView!
    @IBOutlet weak var datePickerDate: UIDatePicker!
    
    //MARK: Properties
    var task: Task?
    var date: Date?
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    //MARK: Actions
    @IBAction func saveTaskButtonTapped(_ sender: Any) {
        guard let name = taskNameTextField.text, !name.isEmpty else {return}
        if let task = task {
            task.name = name
            task.notes = taskNotesTextfield.text
            task.dueDate = datePickerDate.date
            TaskController.sharedInstance.updateTaskDetails(task: task)
        } else {
            TaskController.sharedInstance.createTask(name: name, notes: taskNotesTextfield.text, dueDate: datePickerDate.date)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func dueDatePickerDateChanged(_ sender: Any) {
        date = datePickerDate.date
    }
    
    //MARK: Functions
    func updateView() {
        guard let task = task else {return}
        taskNameTextField.text = task.name
        taskNotesTextfield.text = task.notes
        datePickerDate.date = task.dueDate ?? Date()
    }
}//End of class
