//
//  CartViewController.swift
//  SRMMegaStore
//
//  Created by Sagar Musale on 23/08/16.
//  Copyright © 2016 SRM. All rights reserved.
//

import UIKit

class CartViewController: UIViewController {
    
    var allCartItems: [Cart] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchAllCartItems()
    }
    
    // MARK: Getting all items from cart
    func fetchAllCartItems(){
        if let cartItems = CartDataHandler.getCartItems(){
            print("cartItems:\(cartItems.count)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
