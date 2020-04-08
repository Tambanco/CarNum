//
//  ViewController.swift
//  CarNum
//
//  Created by Tambanco on 04.04.2020.
//  Copyright © 2020 Tambanco. All rights reserved.
//

import UIKit
import CoreData

class CarNumViewController: UITableViewController, RecieveData{
    
    var itemArray = [Item]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        loadItems()
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarNumCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.carNumber
        
        // TERNARY OPERATOR value = condition ? valueIfTrue : valueIfFalse
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        
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
        
        let newItem = Item(context: context)
        newItem.carNumber = data
        newItem.done = false
        self.itemArray.append(newItem)
        
        saveItems()
        
        self.tableView.reloadData()
    }
    func saveItems(){
        
        do{
            try context.save()
        }catch{
            print("Error saving context \(error)")
        }
    }
    
    func loadItems (with request: NSFetchRequest<Item> = Item.fetchRequest()){
        do{
            itemArray = try context.fetch(request)
        }catch{
            print("Error fetching data from context: \(error)")
        }
        tableView.reloadData()
    }
}

extension CarNumViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        request.predicate = NSPredicate(format: "carNumber CONTAINS[cd] %@", searchBar.text!)
        
        request.sortDescriptors = [NSSortDescriptor(key: "carNumber", ascending: true)]
              
        loadItems(with: request)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0{
            loadItems()
            
            DispatchQueue.main.async{
                searchBar.resignFirstResponder()
            }
        }
    }
}
