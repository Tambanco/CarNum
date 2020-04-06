//
//  AddViewController.swift
//  CarNum
//
//  Created by Tambanco on 06.04.2020.
//  Copyright © 2020 Tambanco. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    @IBOutlet weak var labelText: UITextField!
    @IBOutlet weak var dataMark: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func addButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        
    }


}
