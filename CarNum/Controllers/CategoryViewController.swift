//
//  CategoryViewController.swift
//  CarNum
//
//  Created by Tambanco on 09.04.2020.
//  Copyright © 2020 Tambanco. All rights reserved.
//

import UIKit
import CoreData
import ChameleonFramework

class CategoryViewController: SwipeTableViewController{
    
    var categories = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
        
    }
    
    //MARK: - TableView datasourse methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        cell.textLabel?.text = categories[indexPath.row].name
        
        if let colour = UIColor.flatWhite()?.darken(byPercentage: CGFloat(indexPath.row) / CGFloat(categories.count)){
            cell.backgroundColor = colour
            
//            cell.textLabel?.textColor = ContrastColor(colour, isFlat: true)
        }
        
        cell.backgroundColor = UIColor(hexString: categories[indexPath.row].colourOfCell ?? "30D158")
    
        return cell
    }
    
    //MARK: - TableView delegate method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToCarNumbers", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //        if segue.identifier == "goToCarNumbers"{
        let destinationVC = segue.destination as! CarNumViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }
    
    //MARK: - Data manipulation method
    
    func saveCategories(){
        do{
            try context.save()
        }catch{
            print("Error saving category \(error)")
        }
        tableView.reloadData()
    }
    
    func loadCategories(){
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        do{
            categories = try context.fetch(request)
        }catch{
            print("Error fetching request \(error)"  )
        }
        tableView.reloadData()
    }
    //MARK: - Delete data from Swipe
    
    override func updateModel(at indexPath: IndexPath) {
        
        super.updateModel(at: indexPath)
        
        self.context.delete(self.categories[indexPath.row])
        self.categories.remove(at: indexPath.row)
        
        do{
            try self.context.save()
        }catch{
            print("Error saving context \(error)")
        }
        
        //          self.saveItems()
    }
    
    //MARK: - Add new category
    @IBAction func addCategoryPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Добавить новый тип кузова", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Добавить", style: .default) { (action) in
            
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            
            self.categories.append(newCategory)
            
            self.saveCategories()
            
        }
        alert.addAction(action)
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Тип кузова"
        }
        present(alert, animated: true, completion: nil)
    }
    
}
//func saveItems(){
//
//     do{
//         try context.save()
//     }catch{
//         print("Error saving context \(error)")
//     }
// }
