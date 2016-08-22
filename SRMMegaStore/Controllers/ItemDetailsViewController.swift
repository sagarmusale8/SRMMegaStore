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
        showDetials()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Show selected item details
    func showDetials(){
        if let getSelectedItemBlock = selectedItemBlock{
            selectedItem = getSelectedItemBlock()
            self.lblName.text = selectedItem!.name
            if let price = selectedItem!.price{
                self.lblPrice.text = "$\(price)"
            }
            if let imageData = selectedItem!.image{
                self.imgView.image = UIImage(data: imageData)
            }
        }
    }
    
    // MARK: Action Add to Cart
    @IBAction func actionAddToCart(sender: AnyObject) {
        
    }
}
