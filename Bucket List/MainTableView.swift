//
//  MainTableView.swift
//  Bucket List
//
//  Created by Peisure on 1/16/18.
//  Copyright © 2018 Ben. All rights reserved.
//

import UIKit
import CoreData

class MainTableView: UITableViewController,AddItemViewControllerDelegate {
    
    var items = [BucketListItem]()
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet var maintable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllItems()
    }
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "Edit", sender: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        managedObjectContext.delete(item)
        do{
            try managedObjectContext.save()
        }
        catch{
            print("\(error)")
        }
        items.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let controller = navigationController.topViewController as! AddItemViewController
        controller.delegate = self
        if let indexPath = (sender as? NSIndexPath){
            controller.item =  items[indexPath.row].text
            controller.indexPath = indexPath
        }
        
//        if segue.identifier == "AddItem"{
//            let navigationController = segue.destination as! UINavigationController
//            let controller = navigationController.topViewController as! AddItemViewController
//            controller.delegate = self
//        }
//        else if segue.identifier == "Edit"{
//            let navigationController = segue.destination as! UINavigationController
//            let controller = navigationController.topViewController as! AddItemViewController
//            controller.delegate = self
//            let indexPath = sender as! NSIndexPath
//            controller.item =  list[indexPath.row]
//            controller.indexPath = indexPath
//
//        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get the UITableViewCell and create/populate it with data then return it
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].text!
        return cell
    }
    func addItemViewController(_ controller: AddItemViewController, didPressCancelButton button: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func addItemViewController(_ controller: AddItemViewController, didFinishAddingItem text: String, at indexPath:NSIndexPath?) {
        if let ip = indexPath{
            let item = items[ip.row]
            item.text = text
        }
        else{
            let item = NSEntityDescription.insertNewObject(forEntityName: "BucketListItem", into: managedObjectContext) as! BucketListItem
            item.text = text
            items.append(item)
        }
        
        do{
            try managedObjectContext.save()
        }
        catch{
            print("\(error)")
        }
        dismiss(animated: true, completion: nil)
        tableView.reloadData()
    }
    func fetchAllItems(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "BucketListItem")
        do{
            let result = try managedObjectContext.fetch(request)
            items = result as! [BucketListItem]
        }
        catch{
            print("\(error)")
        }
    }
}
