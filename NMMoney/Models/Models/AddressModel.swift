//
//  AddressModel.swift
//  NMMoney
//
//  Created by Evgeny Mahnach on 31.08.2018.
//  Copyright © 2018 Евгений Махнач. All rights reserved.
//

import Foundation
import RealmSwift

class AddressModel: Object {
    @objc dynamic var address: String?
    @objc dynamic var lat: String?
    @objc dynamic var long: String?
}
