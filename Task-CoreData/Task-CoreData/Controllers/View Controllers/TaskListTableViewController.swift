//
//  TaskListTableViewController.swift
//  Task-CoreData
//
//  Created by Travis Halle on 4/27/21.
//

import UIKit

class TaskListTableViewController: UITableViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        TaskController.sharedInstance.fetchTasks()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return TaskController.sharedInstance.sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TaskController.sharedInstance.sections[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? TaskTableViewCell else {return UITableViewCell()}
        
        let task = TaskController.sharedInstance.sections[indexPath.section][indexPath.row]
        
        cell.delegate = self
        cell.configure(with: task)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Incomplete"
        } else if section == 1 {
            return "Complete"
        }
        return nil
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let taskToDelete = TaskController.sharedInstance.sections[indexPath.section][indexPath.row]
            TaskController.sharedInstance.removeTask(taskToRemove: taskToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTaskDetailVC" {
            if let index = tableView.indexPathForSelectedRow {
                guard let destinationVC = segue.destination as? TaskDetailViewController else {return}
                let taskToSend = TaskController.sharedInstance.sections[index.section][index.row]
                destinationVC.task = taskToSend
            }
        }
    }
}//End of class

extension TaskListTableViewController: TaskCellDelegate {
    func taskWasCompletedTapped(task: Task, cell: TaskTableViewCell) {
        
        TaskController.sharedInstance.updateCompletionStatus(task: task)
        
        tableView.reloadData()
    }
}//End of extension
 
