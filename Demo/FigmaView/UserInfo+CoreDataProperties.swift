//
//  UserInfo+CoreDataProperties.swift
//  Demo
//
//  Created by Sandeep Kesarwani on 16/12/23.
//
//

import Foundation
import CoreData


extension UserInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserInfo> {
        return NSFetchRequest<UserInfo>(entityName: "UserInfo")
    }

    @NSManaged public var firstname: String?
    @NSManaged public var lastname: String?
    @NSManaged public var gender: String?

}

extension UserInfo : Identifiable {

}
