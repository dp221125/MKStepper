//
//  ViewController.swift
//  CustomStepper
//
//  Created by Seokho on 2020/01/03.
//  Copyright © 2020 Seokho. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .systemBackground
        self.view = view
        
        let stepper = MKStepper()
        view.addSubview(stepper)
        stepper.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stepper.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            stepper.heightAnchor.constraint(equalTo: stepper.widthAnchor, multiplier: 0.3),
            stepper.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stepper.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
