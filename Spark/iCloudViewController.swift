//
//  iCloudViewController.swift
//  Spark
//
//  Created by Clayton Orman on 12/22/20.
//

import UIKit

class iCloudViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var departmentTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /* iCloud Key-Value Store */
        // Observable to listen for changes
        NotificationCenter.default.addObserver(self, selector: #selector(onUbiquitousKeyValueStoreDidChangeExternally), name: NSUbiquitousKeyValueStore.didChangeExternallyNotification, object: NSUbiquitousKeyValueStore.default)
       
        // Get all of the latest changes between launches
        NSUbiquitousKeyValueStore.default.synchronize()
        
        refreshUI()
    }
    
    @objc func onUbiquitousKeyValueStoreDidChangeExternally(notification: Notification) {
        let changeReason = notification.userInfo![NSUbiquitousKeyValueStoreChangeReasonKey] as! Int
        let changedKeys = notification.userInfo![NSUbiquitousKeyValueStoreChangedKeysKey] as! [String]
        
        switch changeReason {
        // Due to initial sync on the users device, value on the server changed, or the user changed iCloud accounts
        case NSUbiquitousKeyValueStoreInitialSyncChange,
             NSUbiquitousKeyValueStoreServerChange,
             NSUbiquitousKeyValueStoreAccountChange:
            refreshUI()
            // resolve data conflicts due to airplane mode or inability to sync iCloud
        // Due to exceeding the 1MB storage limit
        case NSUbiquitousKeyValueStoreQuotaViolationChange:
            // Reduce the amount of data stored in iCloud Key-Value store
            break
        default:
            break
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        NSUbiquitousKeyValueStore.default.set(nameTextField.text, forKey: "name")
        NSUbiquitousKeyValueStore.default.setValue(emailTextField.text, forKey: "email")
        NSUbiquitousKeyValueStore.default.setValue(departmentTextField.text, forKey: "department")
    }
    
    @IBAction func clearAllButtonTapped(_ sender: UIButton) {
        NSUbiquitousKeyValueStore.default.removeObject(forKey: "name")
        NSUbiquitousKeyValueStore.default.removeObject(forKey: "email")
        NSUbiquitousKeyValueStore.default.removeObject(forKey: "department")
    }
    
    
    func refreshUI() {
        nameTextField.text = NSUbiquitousKeyValueStore.default.string(forKey: "name")
        emailTextField.text = NSUbiquitousKeyValueStore.default.string(forKey: "email")
        departmentTextField.text = NSUbiquitousKeyValueStore.default.string(forKey: "department")
    }
}
