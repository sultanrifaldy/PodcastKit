//
//  RegisterViewController.swift
//  PodcastKit
//
//  Created by Sultan Rifaldy on 21/12/22.
//

import UIKit

class RegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationItem.hidesBackButton = true
        navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func signInButton(_ sender: UIButton) {
        
//        self.dismiss(animated: true)
        self.navigationController?.popViewController(animated: true)
        
    }
    
}


