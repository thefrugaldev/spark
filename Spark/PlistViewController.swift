//
//  PlistViewController.swift
//  Spark
//
//  Created by Clayton Orman on 12/21/20.
//

import UIKit

struct Settings: Codable {
    var currentAppTheme: String
    let lightTheme: Theme
    let darkTheme: Theme
}

struct Theme: Codable {
    let fontName: String
    let primaryRGB: [CGFloat]
    let secondaryRGB: [CGFloat]
    let backgroundRGB: [CGFloat]
}

class PlistViewController: UIViewController {
    
    @IBOutlet weak var themeControl: UISegmentedControl!
    @IBOutlet weak var themeLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    var settings: Settings?

    override func viewDidLoad() {
        super.viewDidLoad()

        /* PList */
        let bundledSettingsURL = Bundle.main.url(forResource: "Settings", withExtension: "plist")!
        
        // Should never write back to files in app's bundle
        // Instead, prepare an area in the document directory for writes
        let settingsURL = try! FileManager
            .default
            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent("Settings.plist")
        
        // Copy plist to document directory if it doesn't already exist
        if FileManager.default.fileExists(atPath: settingsURL.path) == false {
            try! FileManager.default.copyItem(at: bundledSettingsURL, to: settingsURL)
        }
        
        let data = try! Data(contentsOf: settingsURL)
        let decoder = PropertyListDecoder()
        self.settings = try! decoder.decode(Settings.self, from: data)
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        let settingsURL = try! FileManager
            .default
            .url(for: .documentDirectory,
                 in: .userDomainMask,
                 appropriateFor: nil,
                 create: true).appendingPathComponent("Settings.plist")
        
        let encoder = PropertyListEncoder()
        let encodedSettings = try! encoder.encode(self.settings)
        
        try! encodedSettings.write(to: settingsURL)
    }
    
    @IBAction func themeControlValueChanged(_ sender: Any) {
        self.settings?.currentAppTheme = self.themeControl.selectedSegmentIndex == 0 ? "Light" : "Dark"
        
        setTheme()
    }
    
    func setTheme() {
        guard let settings = self.settings else { return }
        
        if settings.currentAppTheme == "Light" {
            self.themeControl.selectedSegmentIndex = 0
            self.view.backgroundColor = UIColor.colorWithRedValue(redValue: settings.lightTheme.backgroundRGB[0],
                                                                  greenValue: settings.lightTheme.backgroundRGB[1],
                                                                  blueValue: settings.lightTheme.backgroundRGB[2],
                                                                  alpha: 1.0)
            
            self.themeLabel.textColor = UIColor.colorWithRedValue(redValue: settings.lightTheme.primaryRGB[0],
                                                                   greenValue: settings.lightTheme.primaryRGB[1],
                                                                   blueValue: settings.lightTheme.primaryRGB[2],
                                                                   alpha: 1.0)
            
            self.themeControl.tintColor = UIColor.colorWithRedValue(redValue: settings.lightTheme.secondaryRGB[0],
                                                                    greenValue: settings.lightTheme.secondaryRGB[1],
                                                                    blueValue: settings.lightTheme.secondaryRGB[2],
                                                                    alpha: 1.0)
            
            self.saveButton.tintColor = UIColor.colorWithRedValue(redValue: settings.lightTheme.secondaryRGB[0],
                                                                  greenValue: settings.lightTheme.secondaryRGB[1],
                                                                  blueValue: settings.lightTheme.secondaryRGB[2],
                                                                  alpha: 1.0)
        } else {
            self.themeControl.selectedSegmentIndex = 1
            self.view.backgroundColor = UIColor.colorWithRedValue(redValue: settings.darkTheme.backgroundRGB[0],
                                                                  greenValue: settings.darkTheme.backgroundRGB[1],
                                                                  blueValue: settings.darkTheme.backgroundRGB[2],
                                                                  alpha: 1.0)
            
            self.themeLabel.textColor = UIColor.colorWithRedValue(redValue: settings.darkTheme.primaryRGB[0],
                                                                  greenValue: settings.darkTheme.primaryRGB[1],
                                                                  blueValue: settings.darkTheme.primaryRGB[2],
                                                                  alpha: 1.0)
            
            self.themeControl.tintColor = UIColor.colorWithRedValue(redValue: settings.darkTheme.secondaryRGB[0],
                                                                    greenValue: settings.darkTheme.secondaryRGB[1],
                                                                    blueValue: settings.darkTheme.secondaryRGB[2],
                                                                    alpha: 1.0)
            
            self.saveButton.tintColor = UIColor.colorWithRedValue(redValue: settings.darkTheme.secondaryRGB[0],
                                                                  greenValue: settings.darkTheme.secondaryRGB[1],
                                                                  blueValue: settings.darkTheme.secondaryRGB[2],
                                                                  alpha: 1.0)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UIColor {
    static func colorWithRedValue(redValue: CGFloat, greenValue: CGFloat, blueValue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(red: redValue/255.0, green: greenValue/255.0, blue: blueValue/255.0, alpha: alpha)
    }
}
