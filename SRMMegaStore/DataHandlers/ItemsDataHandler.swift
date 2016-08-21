//
//  ItemsDataHandler.swift
//  SRMMegaStore
//
//  Created by Sagar Musale on 21/08/16.
//  Copyright © 2016 SRM. All rights reserved.
//

import UIKit
import CoreData

enum FilterType {
    case ByCategory
    case ByName
    case ByPrice
}

class ItemsDataHandler: NSObject {

    // MARK: Getting items as per filter type. If there is no filter then ByName will be default.
    class func getAllItems(withFilterType filter: FilterType? = .ByName)->[Item]?{
        
        let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        let context = appDelegate?.managedObjectContext
        let request = NSFetchRequest(entityName: "Item")
        
        do{
            let fetchedItems = try context?.executeFetchRequest(request) as? [Item]
            if let allItems = fetchedItems{
                print("all items are: \(allItems.count)")
                var sortedResult: [Item]!
                switch filter! as FilterType {
                case .ByName:
                    sortedResult = allItems.sort({
                        $0.name!.compare($1.name!) == NSComparisonResult.OrderedAscending
                    })
                    break
                case .ByPrice:
                    sortedResult = allItems.sort({
                        $0.price!.compare($1.price!) == NSComparisonResult.OrderedAscending
                    })
                    break
                case .ByCategory:
                    sortedResult = allItems.sort({
                        $0.price!.compare($1.price!) == NSComparisonResult.OrderedAscending
                    })
                    break
                }
                return sortedResult
            }
        } catch {
            fatalError("Error in fetching all items")
        }
        return nil
    }
}
