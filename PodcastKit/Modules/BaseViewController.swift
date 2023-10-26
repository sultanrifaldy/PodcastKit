//
//  BaseViewController.swift
//  PodcastKit
//
//  Created by Sultan Rifaldy on 30/01/23.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationController?.navigationBar.sizeToFit()
    }
}
