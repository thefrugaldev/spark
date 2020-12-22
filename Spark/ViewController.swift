//
//  ViewController.swift
//  Spark
//
//  Created by Clayton Orman on 12/17/20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var navView: UIView!
    
    @IBAction func clickMenu(_ sender: UIBarButtonItem) {
        if(!navView.isHidden) {
            navView.isHidden = true
        } else {
            navView.isHidden = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navView.isHidden = true
    }
}

 
