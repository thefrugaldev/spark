//
//  ViewController.swift
//  Spark
//
//  Created by Clayton Orman on 12/17/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var departmentTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // TODO: populate the UI from UserDefaults storage
        nameTextField.text = UserDefaults.standard.string(forKey: "name")
        emailTextField.text = UserDefaults.standard.string(forKey: "email")
        departmentTextField.text = UserDefaults.standard.string(forKey: "department")
    }

    @IBAction func saveButtonTapped(_ sender: UIButton) {
        UserDefaults.standard.set(nameTextField.text, forKey: "name")
        UserDefaults.standard.setValue(emailTextField.text, forKey: "email")
        UserDefaults.standard.setValue(departmentTextField.text, forKey: "department")
    }
    
    func clearAll() {
        UserDefaults.standard.removeObject(forKey: "name")
        UserDefaults.standard.removeObject(forKey: "email")
        UserDefaults.standard.removeObject(forKey: "department")
    }
}

 
