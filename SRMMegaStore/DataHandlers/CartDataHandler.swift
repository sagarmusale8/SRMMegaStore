//
//  CartDataHandler.swift
//  SRMMegaStore
//
//  Created by Sagar Musale on 23/08/16.
//  Copyright © 2016 SRM. All rights reserved.
//

import UIKit
import CoreData

class CartDataHandler: NSObject {

    // Add item to cart
    class func addItemToCart(item: Item){
        let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        let context = appDelegate?.managedObjectContext
        let request = NSFetchRequest(entityName: "Cart")
        if let itemName = item.name{
            request.predicate = NSPredicate(format: "item.name == %@", itemName)
        }
        
        do{
            let fetchedItems = try context?.executeFetchRequest(request) as! [Cart]
            var newCount : NSDecimalNumber = 1
            // Item is already in cart. Update the count
            if let cart = fetchedItems.first{
                if let count = cart.count {
                    let updatedCount = Int(newCount)+Int(count)
                    newCount = NSDecimalNumber(long: updatedCount)
                }
                if let uniquePrice = item.price as? Double{
                    let price = Double(newCount) * uniquePrice
                    cart.total = NSNumber(double: price)
                }
                cart.count = newCount
                try context?.save()
            }
            // Item is not in cart. Add item in cart
            else {
                let entity = NSEntityDescription.entityForName("Cart", inManagedObjectContext: context!)
                let cart = Cart(entity: entity!, insertIntoManagedObjectContext: context!)
                cart.count = NSDecimalNumber(long: Int(newCount))
                cart.item = item
                if let uniquePrice = item.price as? Double{
                    let price = Double(newCount) * uniquePrice
                    cart.total = NSNumber(double: price)
                }
                try context?.save()
            }
        } catch {
            fatalError("Error in fetching or adding cart item")
        }
    }
    
    // Remove item from cart
    class func removeItemFromCart(cartItem: Cart)->Bool{
        let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        let context = appDelegate?.managedObjectContext
        let request = NSFetchRequest(entityName: "Cart")
        if let itemName = cartItem.item!.name{
            request.predicate = NSPredicate(format: "item.name == %@", itemName)
        }
        
        do{
            let fetchedItems = try context?.executeFetchRequest(request) as! [Cart]
            if let cartItem = fetchedItems.first{
                context?.deleteObject(cartItem)
                try context?.save()
                return true
            }
        } catch {
            fatalError("Error in deleting cart item")
        }
        return false
    }
    
    // Getting all items in cart
    class func getCartItems()->[Cart]?{
        let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        let context = appDelegate?.managedObjectContext
        let request = NSFetchRequest(entityName: "Cart")
        
        do{
            let fetchedItems = try context?.executeFetchRequest(request) as! [Cart]
            return fetchedItems
        } catch {
            fatalError("Error in fetching cart items")
        }
        
        return nil
    }
}
