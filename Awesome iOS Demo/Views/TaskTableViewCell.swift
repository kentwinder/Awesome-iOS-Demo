//
//  TaskTableViewCell.swift
//  Awesome iOS Demo
//
//  Created by Kent Winder on 2/19/19.
//  Copyright © 2019 Kent Winder. All rights reserved.
//

import UIKit

protocol TaskTableViewCellDelegate: class {
    func didTapOptions(_ taskTableViewCell: TaskTableViewCell, forTask task: Task)
}

class TaskTableViewCell: UITableViewCell {
    static let identifier = "TaskTableViewCell"
    
    weak var delegate: TaskTableViewCellDelegate?
    
    @IBOutlet weak var descLabel: UILabel?
    @IBOutlet weak var optionsButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var task: Task! {
        didSet {
            if task.isDone {
                let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: task.desc ?? "")
                attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
                descLabel?.attributedText = attributeString
            } else {
                descLabel?.text = task.desc
            }
        }
    }
    
    @IBAction func optionsDidTapped(_ sender: Any) {
        delegate?.didTapOptions(self, forTask: task)
    }
}

