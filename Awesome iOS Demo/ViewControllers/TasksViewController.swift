//
//  TasksViewController.swift
//  Awesome iOS Demo
//
//  Created by Kent Winder on 2/19/19.
//  Copyright © 2019 Kent Winder. All rights reserved.
//

import UIKit
import RxSwift

class TasksViewController: BaseViewController {
    static let identifier = "TasksViewController"
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: TasksViewModel!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getTasks()
    }
    
    func setupViewModel() {
        viewModel = TasksViewModel()
        
        viewModel.error.subscribe(onNext: { [weak self] (message) in
            guard let weakSelf = self else { return }
            weakSelf.hideLoading()
            weakSelf.alert(message: message)
        }).disposed(by: disposeBag)
        
        viewModel.isLoading.subscribe(onNext: { [weak self] (showLoading) in
            guard let weakSelf = self else { return }
            if showLoading {
                weakSelf.showLoading()
            } else {
                weakSelf.hideLoading()
            }
        }).disposed(by: disposeBag)
        
        viewModel.tasksDidLoad.subscribe(onNext: { (_) in
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
    }
    
    func setupViews() {
        title = "To do list"
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 88
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func addTask(_ sender: Any) {
        let alert = UIAlertController(title: "", message: "Add an awesome task to do below", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak alert, weak self] (_) in
            let textField = alert?.textFields![0]
            self?.viewModel.addTask(withDesc: textField!.text ?? "")
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (_) in
        }))
        
        present(alert, animated: true, completion: nil)
    }
}

extension TasksViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tasks?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.identifier, for: indexPath) as! TaskTableViewCell
        cell.task = viewModel.tasks![indexPath.row]
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension TasksViewController: TaskTableViewCellDelegate {
    func didTapOptions(_ taskTableViewCell: TaskTableViewCell, forTask task: Task) {
        let optionMenu = UIAlertController(title: nil, message: "Please Select", preferredStyle: .actionSheet)
        
        if !task.isDone {
            let finishAction = UIAlertAction(title: "Mark as DONE", style: .default, handler: {
                (alert: UIAlertAction!) -> Void in
                self.finish(task: task)
            })
            optionMenu.addAction(finishAction)
        }
        
        let deleteAction = UIAlertAction(title: "Delete Task", style: .destructive, handler: {
            (alert: UIAlertAction!) -> Void in
            self.confirmDelete(task: task)
        })
        optionMenu.addAction(deleteAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
        })
        optionMenu.addAction(cancelAction)
        
        present(optionMenu, animated: true, completion: nil)
    }
    
    func finish(task: Task) {
        viewModel.finishTask(withId: task.id!)
    }
    
    func confirmDelete(task: Task) {
        let alert = UIAlertController(title: "", message: "Are you sure you want to delete this to do", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] (_) in
            self?.viewModel.deleteTask(taskId: task.id!)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (_) in
        }))
        present(alert, animated: true, completion: nil)
    }
    
}

