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
    @IBOutlet weak var dataMark: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func addNewItemButton(_ sender: UIButton) {
        
        
        delegate?.dataRecieved(data: self.labelText.text!)
        
        dismiss(animated: true, completion: nil)
        
    }
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
 
    
}

