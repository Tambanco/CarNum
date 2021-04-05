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

class CategoryViewController: SwipeTableViewController
{
    
    // MARK: - Properties
    var categories = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        loadCategories()
    }
    override func viewWillAppear(_ animated: Bool)
    {
        guard let navBar = navigationController?.navigationBar else {fatalError("Navigation controller does not exist")}
        
        navBar.backgroundColor = UIColor(hexString: "00b894")
        view.backgroundColor = UIColor(hexString: "00b894")
        if let index = self.tableView.indexPathForSelectedRow
        {
            self.tableView.deselectRow(at: index, animated: true)
        }
    }
    
    //MARK: - TableView datasourse methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        cell.textLabel?.text = categories[indexPath.row].name ?? "There are no types"
        cell.backgroundColor = UIColor(hexString: categories[indexPath.row].colourOfCell ?? "3A4862")
        cell.textLabel?.textColor = UIColor.init(contrastingBlackOrWhiteColorOn: cell.backgroundColor, isFlat: true)
        
        return cell
    }
    
    //MARK: - TableView delegate method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        performSegue(withIdentifier: "goToCarNumbers", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let destinationVC = segue.destination as! CarNumViewController
        if let indexPath = tableView.indexPathForSelectedRow
        {
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }
    
    //MARK: - Data manipulation methods
    func saveCategories()
    {
        do
        {
            try context.save()
        }
        catch
        {
            print("Error saving category \(error)")
        }
            tableView.reloadData()
    }
    
    func loadCategories()
    {
        let request: NSFetchRequest<Category> = Category.fetchRequest()
            do
            {
                categories = try context.fetch(request)
            }
            catch
            {
                print("Error fetching request \(error)")
            }
                tableView.reloadData()
    }
    
    //MARK: - Delete data from Swipe
    override func updateModel(at indexPath: IndexPath)
    {
        super.updateModel(at: indexPath)
        self.context.delete(self.categories[indexPath.row])
        self.categories.remove(at: indexPath.row)
        do
        {
            try self.context.save()
        }
        catch
        {
            print("Error saving context \(error)")
        }
    }
    
    //MARK: - Add new category
    @IBAction func addCategoryPressed(_ sender: UIBarButtonItem)
    {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Body Type", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
        let newCategory = Category(context: self.context)
        newCategory.name = textField.text!
        newCategory.colourOfCell = UIColor.randomFlat()?.hexValue()
        self.categories.append(newCategory)
        self.saveCategories()
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(action)
        alert.addTextField { (field) in
        textField = field
        textField.autocapitalizationType = .sentences
        textField.placeholder = "Car Body Type"
        }
        present(alert, animated: true, completion: nil)
    }
    
}
