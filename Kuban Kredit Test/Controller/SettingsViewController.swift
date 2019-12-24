//
//  SettingsViewController.swift
//  Kuban Kredit Test
//
//  Created by Антон Захарченко on 22.12.2019.
//  Copyright © 2019 Антон Захарченко. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    let networkConfig = GetConfiguration()
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var firstUrlTextField: UITextField!
    @IBOutlet weak var firstEndpointTextField: UITextField!
    @IBOutlet weak var firstHtthMethodTextField: UITextField!
    
    @IBOutlet weak var secondServerSvitch: UISwitch!
    @IBOutlet weak var secondUrlTextField: UITextField!
    @IBOutlet weak var secondEndpointTextField: UITextField!
    @IBOutlet weak var secondHttpMethodTextField: UITextField!
    
    @IBOutlet weak var timerTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getConfiguration()
    }
    
    
    @IBAction func updateSettingsButton(_ sender: UIButton) {
        saveConfiguration()
    }
    
    
    func saveConfiguration() {
        defaults.set("\(firstUrlTextField.text ?? "")", forKey: "firstUrl")
        defaults.set("\(firstEndpointTextField.text ?? "")", forKey: "firstEndpoint")
        defaults.set("\(firstHtthMethodTextField.text ?? "")", forKey: "firstHttpMethod")
        
        defaults.set(secondServerSvitch.isOn, forKey: "secondServer")
        defaults.set(secondUrlTextField.text ?? "", forKey: "secondUrl")
        defaults.set(secondEndpointTextField.text ?? "", forKey: "secondEndpoint")
        defaults.set(secondHttpMethodTextField.text ?? "", forKey: "secondHttpMethod")
        defaults.set(Int(timerTextField.text ?? "10"), forKey: "timerCounter")
    }
    
    func getConfiguration() {
        firstUrlTextField.text = networkConfig.firstUrl
        firstEndpointTextField.text = networkConfig.firstEndpoint
        firstHtthMethodTextField.text = networkConfig.firstHttpMethod
        
        secondServerSvitch.isOn = Bool(networkConfig.secondServer)
        secondUrlTextField.text = networkConfig.secondUrl
        secondEndpointTextField.text = networkConfig.secondEndpoint
        secondHttpMethodTextField.text = networkConfig.secondUrl
        timerTextField.text = String(networkConfig.timerCounter)
    }
    
}
