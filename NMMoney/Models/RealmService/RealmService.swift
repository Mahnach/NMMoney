//
//  RealmService.swift
//  NMMoney
//
//  Created by Евгений Махнач on 27.08.2018.
//  Copyright © 2018 Евгений Махнач. All rights reserved.
//


import Foundation
import RealmSwift

class RealmService {
    
static let realm = try! Realm()

    // MARK: Write
    static func writeIntoRealm(object: Object) {
        try! realm.write {
            realm.add(object)
        }
    }

    // MARK: Get
    static func getToken() -> Results<TokenModel> {
        let data = realm.objects(TokenModel.self)
        return data
    }
    static func getBook() -> Results<BookModel> {
        let data = realm.objects(BookModel.self)
        return data
    }

    static func getSlotsModel() -> Results<SlotsModel> {
        let data = realm.objects(SlotsModel.self)
        return data
    }
    
    static func deleteToken() {
        if RealmService.getToken().count > 0 {
            try! realm.write {
                realm.delete(RealmService.getToken())
            }
        }
    }
    
    static func deleteSlots() {
        if RealmService.getSlotsModel().count > 0 {
            try! realm.write {
                realm.delete(RealmService.getSlotsModel())
            }
        }
    }
    
    static func deleteBook() {
        if RealmService.getBook().count > 0 {
            try! realm.write {
                realm.delete(RealmService.getBook())
            }
        }
    }
    
    static func getBranches() -> Results<BranchModel> {
        let data = realm.objects(BranchModel.self)
        return data
    }
    
    static func getAddress() -> Results<AddressModel> {
        let data = realm.objects(AddressModel.self)
        return data
    }
    
    static func deleteAddresses() {
        if RealmService.getAddress().count > 0 {
            try! realm.write {
                realm.delete(RealmService.getAddress())
            }
        }
    }
    
    static func deleteBranches() {
        if RealmService.getBranches().count > 0 {
            try! realm.write {
                realm.delete(RealmService.getBranches())
            }
        }
    }
    
    static func getBranchTime() -> Results<BranchTimeModel> {
        let data = realm.objects(BranchTimeModel.self)
        return data
    }
    
    static func deleteBranchTime() {
        if RealmService.getBranchTime().count > 0 {
            try! realm.write {
                realm.delete(RealmService.getBranchTime())
            }
        }
    }

}
