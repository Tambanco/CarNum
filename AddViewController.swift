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
    
    @IBAction func addNewItemButton(_ sender: UIButton) {
        
        let firstVC = CarNumViewController()
        firstVC.itemArray.append(labelText.text!)
        
        firstVC.tableView.reloadData()
        
        dismiss(animated: true, completion: nil)
        
        
    }
    @IBAction func dateChanged(_ sender: UIDatePicker) {
    }
    

}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self,
                         action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}
