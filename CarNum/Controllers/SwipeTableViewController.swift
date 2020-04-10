//
//  SwipeTableViewController.swift
//  CarNum
//
//  Created by Tambanco on 10.04.2020.
//  Copyright © 2020 Tambanco. All rights reserved.
//

import UIKit
import SwipeCellKit

class SwipeTableViewController: UITableViewController, SwipeTableViewCellDelegate {

    var cell: UITableViewCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 80.0
        tableView.separatorStyle = .singleLine
        
    }
    
    //MARK: - TableView datasource method
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
                                    
                cell.delegate = self
                return cell
            }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            
            
            
            // handle action by updating model with deletion
            
            self.updateModel(at: indexPath)
            
//            self.context.delete(self.categories[indexPath.row])
//            self.categories.remove(at: indexPath.row)
//
//            do{
//                try self.context.save()
//            }catch{
//                print("Error saving context \(error)")
//            }
//
            //            self.saveItems()
        }
        
        // customize the action appearance
        deleteAction.image = UIImage(named: "delete-icon")
        
        return [deleteAction]
    }
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        return options
    }
    func updateModel(at indexPath: IndexPath){
        
    }

}