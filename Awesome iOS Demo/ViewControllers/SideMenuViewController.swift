//
//  SideMenuViewController.swift
//  Awesome iOS Demo
//
//  Created by Kent Winder on 3/8/19.
//  Copyright © 2019 Kent Winder. All rights reserved.
//

import UIKit

class SideMenuViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // setup table view
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 88
    }
}

extension SideMenuViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuTableViewCell.identifier, for: indexPath) as! SideMenuTableViewCell
        cell.descLabel?.text = "Menu name \(indexPath.row + 1)"
        return cell
    }
}

extension SideMenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // handle menu clicked here
        revealViewController().revealToggle(animated: true)
    }
}
