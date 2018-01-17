//
//  MainTableView.swift
//  Bucket List
//
//  Created by Peisure on 1/16/18.
//  Copyright © 2018 Ben. All rights reserved.
//

import UIKit

class MainTableView: UITableViewController,AddItemViewControllerDelegate {
    
    var list:[String] = ["liam","Emily"]
    
    @IBOutlet var maintable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()        
    }
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "Edit", sender: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        list.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let controller = navigationController.topViewController as! AddItemViewController
        controller.delegate = self
        if let indexPath = (sender as? NSIndexPath){
            controller.item =  list[indexPath.row]
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
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get the UITableViewCell and create/populate it with data then return it
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        cell.textLabel?.text = list[indexPath.row]
        return cell
    }
    func addItemViewController(_ controller: AddItemViewController, didPressCancelButton button: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func addItemViewController(_ controller: AddItemViewController, didFinishAddingItem item: String, at indexPath:NSIndexPath?) {
        if let ip = indexPath{
            list[ip.row]=item
        }
        else{
            list.append(item)
        }
        dismiss(animated: true, completion: nil)
        tableView.reloadData()
    }
}
