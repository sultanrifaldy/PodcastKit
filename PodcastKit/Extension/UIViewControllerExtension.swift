//
//  UIViewControllerExtension.swift
//  PodcastKit
//
//  Created by Sultan Rifaldy on 29/12/22.
//

import UIKit


//MARK: - RegisterViewController
extension UIViewController{
    func showRegisterViewController () {
        let storyboard = UIStoryboard(name: "Auth", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "register") as! RegisterViewController
        navigationController?.pushViewController(viewController, animated: true)
    }
}

//MARK: - MainViewController

extension UIViewController {
    func showMainViewController () {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "main")
        let window = UIApplication.shared.windows.filter{$0.isKeyWindow}.first
        window?.rootViewController = viewController
    }
}
