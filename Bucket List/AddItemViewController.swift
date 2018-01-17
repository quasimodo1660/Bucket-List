//
//  ViewController.swift
//  Bucket List
//
//  Created by Peisure on 1/16/18.
//  Copyright © 2018 Ben. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController {
    
    var indexPath:NSIndexPath?
    var item:String?
    
    @IBOutlet var itemText: UITextField!
    
    var delegate: AddItemViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        itemText.text=item
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        delegate?.addItemViewController(self, didFinishAddingItem: itemText.text!, at:indexPath)
    }
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        delegate?.addItemViewController(self, didPressCancelButton: sender)
    }
}

