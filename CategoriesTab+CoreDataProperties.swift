//
//  CategoriesTab+CoreDataProperties.swift
//  
//
//  Created by Noura Rizk on 1/6/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension CategoriesTab {

    @NSManaged var arName: String?
    @NSManaged var enName: String?
    @NSManaged var desc: String?

}
