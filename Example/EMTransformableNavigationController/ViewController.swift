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
    
    private weak var transformableNavigationController: EMTransformableNavigationController?

    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            if let navigationController = transformableNavigationController,
                UIDevice.current.userInterfaceIdiom == .phone {
                navigationController.removeFromParentViewController()
                transformableNavigationController = nil
            } else {
                createTransformableNavigationController()
            }
        }
    }
    
    private func createTransformableNavigationController() {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CatView")
        viewController.view.backgroundColor = .lightGray
        let navigationController = EMTransformableNavigationController(rootViewController: viewController)
        navigationController.allowedFrame = view.bounds
        navigationController.add(to: self)
        navigationController.transformDelegate = self
        transformableNavigationController = navigationController
    }
}

extension ViewController: EMTransformableNavigationControllerDelegate {
    func transformableNavigationController(_ transformableNavigationController: EMTransformableNavigationController, didTransform to: CGRect) {
        //now you know the frame of the transformable navigation controller
    }
}

