//
//  Singleton.swift
//  NMMoney
//
//  Created by Evgeny Mahnach on 11.09.2018.
//  Copyright © 2018 Евгений Махнач. All rights reserved.
//

import Foundation

class Singleton {
    
    static let shared = Singleton()

    var available = true
    var year: String?
    var month: String?
    var day: String?
    var hours: String?
    var minutes: String?
    var weekDay: String?
    
}
