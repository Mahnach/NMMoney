//
//  SlotsModel.swift
//  NMMoney
//
//  Created by Evgeny on 02.09.2018.
//  Copyright © 2018 Евгений Махнач. All rights reserved.
//


import RealmSwift

class SlotsModel: Object {
    @objc dynamic var available = true
    @objc dynamic var year: String?
    @objc dynamic var month: String?
    @objc dynamic var day: String?
    @objc dynamic var hours: String?
    @objc dynamic var minutes: String?
    @objc dynamic var weekDay: String?
}
