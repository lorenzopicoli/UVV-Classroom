//
//  ViewController.swift
//  UVVClassroom
//
//  Created by lorenzopicoli on 25/03/17.
//  Copyright © 2017 Lorenzo Piccoli. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let navController = UINavigationController(rootViewController: BuildingsViewController())
        navController.navigationBar.barTintColor = .uvvBlue
        navController.navigationBar.tintColor = .white
        navController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]

        self.present(navController, animated: true, completion: nil)
    }

}

