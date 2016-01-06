//
//  Recipe+CoreDataProperties.swift
//  Recipez
//
//  Created by Grayson faircloth on 1/3/16.
//  Copyright © 2016 Grayson Faircloth. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Recipe {

    @NSManaged var image: NSData?
    @NSManaged var ingredients: String?
    @NSManaged var steps: String?
    @NSManaged var title: String?

}
