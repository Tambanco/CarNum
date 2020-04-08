//
//  ViewController.swift
//  CarNum
//
//  Created by Tambanco on 04.04.2020.
//  Copyright © 2020 Tambanco. All rights reserved.
//

import UIKit

class CarNumViewController: UITableViewController, RecieveData{
    
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.carNumber = "New Item"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.carNumber = "Luke"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.carNumber = "Obevan"
        itemArray.append(newItem3)
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarNumCell", for: indexPath)

        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.carNumber
        
// value = condition ? valueIfTrue : valueIfFalse
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "addNewItem", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addNewItem" {
            let secondVC = segue.destination as! AddViewController
            secondVC.delegate = self
        }
    }
    
    func dataRecieved(data: String) {
        
        let newItem = Item()
        newItem.carNumber = data
        
        self.itemArray.append(newItem)
        
        defaults.set(self.itemArray, forKey: "CarNumArray")
        
        self.tableView.reloadData()
    }
    
}

