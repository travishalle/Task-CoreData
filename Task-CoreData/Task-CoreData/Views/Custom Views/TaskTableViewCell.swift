//
//  TaskTableViewCell.swift
//  Task-CoreData
//
//  Created by Travis Halle on 4/27/21.
//

import UIKit

//MARK: Protocol
protocol TaskCellDelegate: AnyObject {
    func taskWasCompletedTapped(task: Task, cell: TaskTableViewCell)
}

class TaskTableViewCell: UITableViewCell {

    //MARK: Outlets
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var taskCompletionButton: UIButton!
    
    
    //MARK: Properties
    weak var delegate: TaskCellDelegate?
    var task: Task? {
        didSet {
            guard let task = task else {return}
            updateViews(for: task)
        }
    }
    private var isComplete: Bool = false
    
    //MARK: Actions
    @IBAction func completionButtonTapped(_ sender: Any) {
        guard let task = task else {return}
        
        delegate?.taskWasCompletedTapped(task: task, cell: self)
    }
    
    //MARK: Functions
    func configure(with task: Task) {
        self.task = task
        self.isComplete = task.isComplete
        let image = self.isComplete ? UIImage(systemName: "checkmark.square") : UIImage(systemName: "square")
        
        taskNameLabel.text = task.name
        taskCompletionButton.setImage(image, for: .normal)
    }
    
    func updateViews(for task: Task) {
        taskNameLabel.text = task.name
        let image = isComplete ? UIImage(systemName: "checkmark.square") : UIImage(systemName: "square")
        taskCompletionButton.setBackgroundImage(image, for: .normal)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        task = nil
        isComplete = false
    }
}//End of class
