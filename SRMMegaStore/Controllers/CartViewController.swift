//
//  CartViewController.swift
//  SRMMegaStore
//
//  Created by Sagar Musale on 23/08/16.
//  Copyright © 2016 SRM. All rights reserved.
//

import UIKit

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var lblFinalAmount: UILabel!
    @IBOutlet weak var tableViewCart: UITableView!
    
    var allCartItems: [Cart] = []
    var totalPrice: Double = 0
    let reusableIdForCartCell = String(CartTableViewCell)
    var itemSelectionBlock: ((Item)->Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        fetchAllCartItems()
    }
    
    // Setting up UI components in view
    func setupUI(){
        lblFinalAmount.setProperties(UIColor.whiteColor(), textFont: Fonts.Medium_14)
        tableViewCart.separatorStyle = .None
    }
    
    // Action on cancel
    @IBAction func actionOnCancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Getting all items from cart
    func fetchAllCartItems(){
        if let cartItems = CartDataHandler.getCartItems(){
            allCartItems = cartItems
            calculateAndDisplayFinalAmount()
            tableViewCart.reloadData()
        }
    }
    
    // MARK: Calculating total price
    func calculateAndDisplayFinalAmount() {
        totalPrice = 0
        for cartItem in allCartItems {
            if let count = cartItem.count, let uniquePrice = cartItem.item?.price as? Double{
                totalPrice = totalPrice + (uniquePrice * Double(count))
            }
        }
        lblFinalAmount.text = "Final Amount: $" + String(totalPrice)
    }
    
    // MARK: UITableView DataSource and Delegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCartItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if let cartCell = tableView.dequeueReusableCellWithIdentifier(reusableIdForCartCell) as? CartTableViewCell {
            let cartItem = allCartItems[indexPath.row]
            
            if let name = cartItem.item?.name {
                cartCell.lblName.text = name
            }
            if let count = Int(cartItem.count!) as? Int, let price = cartItem.item?.price as? Double{
                let priceTotal = price * Double(count)
                let priceText = String("\(count) x \(price) = \(priceTotal)")
                cartCell.lblPrice.text = priceText
            }
            if let imageData = cartItem.item?.image{
                cartCell.imgView.image = UIImage(data: imageData)
            }
            cartCell.setupCellUI()
            
            return cartCell
        }
        
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let removeAction = UITableViewRowAction(style: UITableViewRowActionStyle.Destructive, title: "Remove") { (rowAction, indexPath) in
            self.actionRemoveItemAtIndex(indexPath.row)
        }
        return [removeAction]
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let item = self.allCartItems[indexPath.row].item{
            self.navigationController?.dismissViewControllerAnimated(true) {
                // After selection of item, loading that item in details view
                if let selectionBlock = self.itemSelectionBlock {
                    selectionBlock(item)
                }
            }
        }
    }
    
    // MARK: Removing item action
    func actionRemoveItemAtIndex(index: Int){
        let alertAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default) { (action) in
            let itemToRemove = self.allCartItems[index]
            if CartDataHandler.removeItemFromCart(itemToRemove){
                self.allCartItems.removeAtIndex(index)
                self.calculateAndDisplayFinalAmount()
                self.tableViewCart.reloadData()
            }
        }
        
        showConfirmationAlertWithTitle("Remove Item?", withMsg: "Do you want to remove this item?", withAlertAction: alertAction)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
