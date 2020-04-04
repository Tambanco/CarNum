//
//  ViewController.swift
//  CarNum
//
//  Created by Tambanco on 04.04.2020.
//  Copyright © 2020 Tambanco. All rights reserved.
//

import UIKit

class CarNumViewController: UITableViewController {

    let itemArray = ["aa999a777", "oo888o99", "ва757а54"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarNumCell", for: indexPath)
    
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }

}
