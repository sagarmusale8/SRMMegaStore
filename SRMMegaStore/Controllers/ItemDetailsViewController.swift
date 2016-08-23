//
//  ItemDetailsViewController.swift
//  SRMMegaStore
//
//  Created by Sagar Musale on 22/08/16.
//  Copyright © 2016 SRM. All rights reserved.
//

import UIKit

class ItemDetailsViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnAddToCart: UIButton!
    
    let cornerRadius: CGFloat = 8.0
    
    var selectedItemBlock : ((Void)->Item)?
    var selectedItem: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        showDetials()
    }
    
    // Setting up UI
    func setupUI() {
        lblName.font = Fonts.Regular_18
        lblPrice.font = Fonts.Regular_18
        btnAddToCart.setProperties(UIColor.whiteColor(), textFont: Fonts.Medium_18, backgroundColor: Colors.Green_609030)
        btnAddToCart.makeViewWithRoundedCorner(cornerRadius)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Show selected item details
    func showDetials(){
        if let getSelectedItemBlock = selectedItemBlock{
            selectedItem = getSelectedItemBlock()
            loadDetailsForItem(selectedItem!)
        }
    }
    
    // Loading details for item in view
    func loadDetailsForItem(item: Item){
        selectedItem = item
        self.lblName.text = item.name
        if let price = item.price{
            self.lblPrice.text = "$\(price)"
        }
        if let imageData = item.image{
            self.imgView.image = UIImage(data: imageData)
        }
    }
    
    // MARK: Passing data to details view
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // On click of Add to cart, this segue will get invoked.
        // Adding item to cart
        if segue.identifier == ProjectConstant.SEGUE_ADD_TO_CART {
            if let item = selectedItem{
                CartDataHandler.addItemToCart(item)
            }
            addItemSelectionBlockToCartViewWithSegue(segue)
        } else if segue.identifier == ProjectConstant.SEGUE_PUSH_CART {
            addItemSelectionBlockToCartViewWithSegue(segue)
        }
    }
    
    // Adding itemSelection block to CartView
    func addItemSelectionBlockToCartViewWithSegue(segue: UIStoryboardSegue){
        // if item selected in Cart then it will get load in this view itself
        if let navController = segue.destinationViewController as? UINavigationController, let cartController = navController.viewControllers.first as? CartViewController{
            cartController.itemSelectionBlock = { (item: Item)->Void in
                self.loadDetailsForItem(item)
            }
        }
    }
}
