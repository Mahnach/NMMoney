//
//  BranchModel.swift
//  NMMoney
//
//  Created by Евгений Махнач on 28.08.2018.
//  Copyright © 2018 Евгений Махнач. All rights reserved.
//

import Foundation
import RealmSwift

class BranchModel: Object {
    @objc dynamic var id = 0
    @objc dynamic var name: String?
    @objc dynamic var isActive = true
    @objc dynamic var modifiedDate: String?
    
}
