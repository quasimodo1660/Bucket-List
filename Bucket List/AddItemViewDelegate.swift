//
//  AddItemViewDelegate.swift
//  Bucket List
//
//  Created by Peisure on 1/16/18.
//  Copyright © 2018 Ben. All rights reserved.
//

import UIKit

protocol AddItemViewControllerDelegate: class {
    
    func addItemViewController(_ controller: AddItemViewController, didFinishAddingItem item: String, at indexPath:NSIndexPath?)
    func addItemViewController(_ controller: AddItemViewController, didPressCancelButton button: UIBarButtonItem)
}
