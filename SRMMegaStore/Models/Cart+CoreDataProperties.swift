//
//  Cart+CoreDataProperties.swift
//  SRMMegaStore
//
//  Created by Sagar Musale on 21/08/16.
//  Copyright © 2016 SRM. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Cart {

    @NSManaged var total: NSNumber?
    @NSManaged var item: NSSet?

}
