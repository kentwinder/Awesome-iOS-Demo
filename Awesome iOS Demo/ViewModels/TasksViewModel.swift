//
//  TasksViewModel.swift
//  Awesome iOS Demo
//
//  Created by Kent Winder on 2/19/19.
//  Copyright © 2019 Kent Winder. All rights reserved.
//

import RxSwift

class TasksViewModel {
    var taskManager = TaskManager()
    
    var isLoading = PublishSubject<Bool>()
    var error = PublishSubject<String>()
    var tasksDidLoad = PublishSubject<Void>()
    
    var tasks: [Task]?
    
    func getTasks() {
        isLoading.onNext(true)
        taskManager.getTasks(completion: { [weak self] (tasks) in
            guard let weakSelf = self else { return }
            weakSelf.tasks = tasks
            weakSelf.isLoading.onNext(false)
            weakSelf.tasksDidLoad.onNext(())
        }) { [weak self] (errorMessage) in
            self?.error.onNext(errorMessage)
        }
    }
    
    func addTask(withDesc desc: String) {
        isLoading.onNext(true)
        taskManager.addTask(desc: desc, completion: { [weak self] (_) in
            guard let weakSelf = self else { return }
            weakSelf.getTasks()
        }) { [weak self] (errorMessage) in
            self?.error.onNext(errorMessage)
        }
    }
    
    func finishTask(withId taskId: String) {
        isLoading.onNext(true)
        taskManager.updateTask(taskId: taskId, isDone: true, completion: { [weak self] (_) in
            guard let weakSelf = self else { return }
            weakSelf.getTasks()
        }) { [weak self] (errorMessage) in
            self?.error.onNext(errorMessage)
        }
    }
    
    func deleteTask(taskId: String) {
        isLoading.onNext(true)
        taskManager.deleteTask(taskId: taskId, completion: { [weak self] (_) in
            guard let weakSelf = self else { return }
            weakSelf.getTasks()
        }) { [weak self] (errorMessage) in
            self?.error.onNext(errorMessage)
        }
    }
}
