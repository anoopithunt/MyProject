//
//  UserInfo+CoreDataProperties.swift
//  Demo
//
//  Created by Sandeep Kesarwani on 19/12/23.
//
//

import Foundation
import CoreData


extension UserInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserInfo> {
        return NSFetchRequest<UserInfo>(entityName: "UserInfo")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var gender: String 

}

extension UserInfo : Identifiable {

}


@objc(UserInfo)
public class UserInfo: NSManagedObject {

}
