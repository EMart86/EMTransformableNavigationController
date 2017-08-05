//
//  ViewController.swift
//  EMTransformableNavigationController
//
//  Created by eberl_ma@gmx.at on 08/05/2017.
//  Copyright (c) 2017 eberl_ma@gmx.at. All rights reserved.
//

import UIKit
import EMTransformableNavigationController

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let viewController = UIViewController()
        viewController.view.backgroundColor = .lightGray
        let navigationController = EMTransformableNavigationController(rootViewController: viewController)
        navigationController.add(to: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

