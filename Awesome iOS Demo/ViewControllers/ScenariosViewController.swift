//
//  ScenariosViewController.swift
//  Awesome iOS Demo
//
//  Created by Kent Winder on 3/8/19.
//  Copyright © 2019 Kent Winder. All rights reserved.
//

import UIKit

class ScenariosViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private enum Scenario: Int, CaseIterable {
        case network, sideMenu, tabBar
        
        func desc() -> (desc: String, segueIdentifier: String) {
            switch self {
            case .network: return ("APIs, Network Requests & JSON", "HomeToTasks")
            case .sideMenu: return ("Side Menu", "HomeToSideMenu")
            case .tabBar: return ("Tab Bar", "HomeToTabBar")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // setup views
        title = "An awesome iOS demo"
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 88
    }
}

extension ScenariosViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Scenario.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ScenarioTableViewCell.identifier, for: indexPath) as! ScenarioTableViewCell
        cell.descLabel?.text = Scenario.init(rawValue: indexPath.row)?.desc().desc
        return cell
    }
}

extension ScenariosViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let segueIdentifier = Scenario.init(rawValue: indexPath.row)?.desc().segueIdentifier, !segueIdentifier.isEmpty {
            performSegue(withIdentifier: segueIdentifier, sender: self)
        }
    }
}
