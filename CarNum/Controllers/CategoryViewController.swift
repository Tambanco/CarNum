//
//  CategoryViewController.swift
//  CarNum
//
//  Created by Tambanco on 09.04.2020.
//  Copyright © 2020 Tambanco. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController{

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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories[indexPath.row].name
        
        return cell
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
            print("Error fetching request \(error)")
        }
        tableView.reloadData()
    }
    
    //MARK: - Add new category
    @IBAction func addCategoryPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Добавить новый тип кузова", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
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
