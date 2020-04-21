//
//  AddViewController.swift
//  CarNum
//
//  Created by Tambanco on 06.04.2020.
//  Copyright © 2020 Tambanco. All rights reserved.
//

import UIKit

protocol RecieveData {
    func dataRecieved(data: String)
}

class AddViewController: UIViewController, UITextFieldDelegate {
    
    var delegate: RecieveData?
    var data = ""
    
    @IBOutlet weak var labelText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelText.layer.cornerRadius = 5.0
        labelText.layer.borderWidth = 1.0
        labelText.delegate = self
        view.backgroundColor = UIColor(hexString: "#00b894")
        
    }
    @IBAction func addNewItemButton(_ sender: UIButton) {
        
        let totalData = "\(self.labelText.text!)"
        
        labelText.endEditing(true)
        delegate?.dataRecieved(data: totalData)
        dismiss(animated: true, completion: nil)
        
    }
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pickerChanged(_ sender: UIDatePicker) {
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        labelText.endEditing(true)
        return true
    }
}

