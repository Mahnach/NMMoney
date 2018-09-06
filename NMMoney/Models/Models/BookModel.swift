//
//  BookModel.swift
//  NMMoney
//
//  Created by Евгений Махнач on 28.08.2018.
//  Copyright © 2018 Евгений Махнач. All rights reserved.
//

import Foundation
import RealmSwift

class BookModel: Object {
    @objc dynamic var fname: String?
    @objc dynamic var name: String?
    @objc dynamic var lname: String?
    @objc dynamic var number: String?
    @objc dynamic var email: String?
    @objc dynamic var reasonforenquiryId = 1
    @objc dynamic var date: String?
    @objc dynamic var branchId = 0
    @objc dynamic var modifiedDate: String?
    @objc dynamic var reason: String?
    @objc dynamic var branchName: String?
    @objc dynamic var bookingType = 0
    @objc dynamic var comment: String?
}
