//
//  UserDefaultsViewController.swift
//  Spark
//
//  Created by Clayton Orman on 12/22/20.
//

import UIKit

class UserDefaultsViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var departmentTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        refreshUI()
    }
    
    func refreshUI() {
        nameTextField.text = UserDefaults.standard.string(forKey: "name")
        emailTextField.text = UserDefaults.standard.string(forKey: "email")
        departmentTextField.text = UserDefaults.standard.string(forKey: "department")
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        /* User Defaults Key-Value Local Storage */
        UserDefaults.standard.set(nameTextField.text, forKey: "name")
        UserDefaults.standard.setValue(emailTextField.text, forKey: "email")
        UserDefaults.standard.setValue(departmentTextField.text, forKey: "department")
    }
    
    @IBAction func clearAllButtonTapped(_ sender: UIButton) {
        UserDefaults.standard.removeObject(forKey: "name")
        UserDefaults.standard.removeObject(forKey: "email")
        UserDefaults.standard.removeObject(forKey: "department")
        
        refreshUI()
    }
    
}
