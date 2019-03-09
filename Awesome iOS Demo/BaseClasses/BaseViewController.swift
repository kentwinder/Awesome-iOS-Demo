//
//  BaseViewController.swift
//  Awesome iOS Demo
//
//  Created by Kent Winder on 2/19/19.
//  Copyright © 2019 Kent Winder. All rights reserved.
//

import UIKit
import MBProgressHUD
import SWRevealViewController

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // setupSideMenu()
        // setupBackNavigationBarItem()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    open func showLoading() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        MBProgressHUD.hide(for: view, animated: true)
        let loadingNotification = MBProgressHUD.showAdded(to: view, animated: true)
        loadingNotification.mode = .indeterminate
    }
    
    open func hideLoading() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        MBProgressHUD.hide(for: view, animated: true)
    }
    
    open func alert(message: String) {
        alert(message: message, withTitle: "")
    }
    
    open func alert(message: String, withTitle title: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            
        }))
        present(alert, animated: true, completion: nil)
    }
}
