//
//  HomeViewController.swift
//  Awesome iOS Demo
//
//  Created by Kent Winder on 3/8/19.
//  Copyright © 2019 Kent Winder. All rights reserved.
//

import UIKit
import SWRevealViewController

class HomeViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Side Menu"
        setupSideMenu()
        setupBackNavigationBarItem()
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    func setupSideMenu() {
        navigationItem.leftBarButtonItem?.target = revealViewController()
        navigationItem.leftBarButtonItem?.action = #selector(SWRevealViewController.revealToggle(_:))
        if revealViewController() != nil {
            revealViewController().delegate = self
            let isIpad = UIDevice.current.userInterfaceIdiom == .pad
            let screenWidth = UIScreen.main.bounds.width
            revealViewController().rearViewRevealWidth = isIpad ? screenWidth * 0.4 : screenWidth * 0.7
            revealViewController().rearViewRevealOverdraw = 0 // isIpad ? screenWidth - (screenWidth * 0.4): screenWidth - (screenWidth * 0.7)
            view.addGestureRecognizer(revealViewController().tapGestureRecognizer())
            view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        }
    }
    
    func setupBackNavigationBarItem() {
        if revealViewController() == nil {
            if self.navigationController?.viewControllers.count ?? 0 > 0 {
                let imageName = "ic_back"
                let backButtonImage = UIImage(named: imageName)
                
                // BarButtonItems
                let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
                backButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
                backButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
                backButton.setImage(backButtonImage, for: .normal)
                backButton.contentMode = .scaleAspectFill
                backButton.addTarget(self, action: #selector(self.backButtonAction), for: .touchUpInside)
                
                let backButtonItem = UIBarButtonItem(customView: backButton)
                self.navigationItem.leftBarButtonItem = backButtonItem
            }
        }
    }
    
    @objc func backButtonAction() {
        if let navBar = self.navigationController, navBar.viewControllers.first != self {
            navBar.popViewController(animated: true)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension HomeViewController: SWRevealViewControllerDelegate {
    
}

extension HomeViewController: UIGestureRecognizerDelegate {
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
