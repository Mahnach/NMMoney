//
//  BranchTimeModel.swift
//  NMMoney
//
//  Created by Евгений Махнач on 28.08.2018.
//  Copyright © 2018 Евгений Махнач. All rights reserved.
//

import Foundation
import RealmSwift

class BranchTimeModel: Object {
    @objc dynamic var name: String?
    @objc dynamic var year: String?
    @objc dynamic var day: String?
    @objc dynamic var month: String?
    @objc dynamic var hour: String?
    @objc dynamic var minute: String?
    @objc dynamic var second: String?
}
