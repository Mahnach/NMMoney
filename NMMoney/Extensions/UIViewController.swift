//
//  UIViewController+NavBar.swift
//  TokenWallet
//
//  Created by BAMFAdmin on 28.06.2018.
//  Copyright © 2018 BAMFAdmin. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    
    func setupNavigationBar() {
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.barTintColor = .clear
        
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "back-btn")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "back-btn")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.done, target: nil, action: nil)
    }
    
    func popToVC(backToStart: Bool) {
        let button = UIButton(type: .custom)
        var pos = 0
        if #available(iOS 11.0, *) {
            pos = 6
        } else {
            pos = -10
        }
        let view = UIImageView(frame: CGRect(x: -8, y: pos, width: 13, height: 21))
        view.image = UIImage(named: "back-btn")
        button.addSubview(view)
        if backToStart {
            button.addTarget(self, action: #selector(self.backToStart), for: .touchUpInside)
        } else {
            button.addTarget(self, action: #selector(self.backToMnemonic), for: .touchUpInside)
        }
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = barButton
    }
    
    @objc func backToStart() {
        let composeVC = self.navigationController?.viewControllers[0]
        self.navigationController?.popToViewController(composeVC!, animated: true)
    }
    @objc func backToMnemonic() {
        let composeVC = self.navigationController?.viewControllers[3]
        self.navigationController?.popToViewController(composeVC!, animated: true)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func pushVC(identifier: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: identifier)
        self.navigationController?.pushViewController(vc, animated: true)
    }

    
}
