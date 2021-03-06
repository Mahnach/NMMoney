//
//  SaveBook.swift
//  NMMoney
//
//  Created by Евгений Махнач on 28.08.2018.
//  Copyright © 2018 Евгений Махнач. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift

class SaveBook{
    
    static func saveBook(completion: @escaping (Bool) -> Void) {
       // testing - http://apidev.nmmoneybookings.co.uk/bms/booking/save http://api.nmmoneybookings.co.uk/bms/booking/save
        let url = "http://api.nmmoneybookings.co.uk/bms/booking/save"
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "X-AuthToken": RealmService.getToken().last!.token!
        ]

        let parameters: Parameters = [
            "FirstName": RealmService.getBook().last!.fname!,
            "ContactNumber": RealmService.getBook().last!.number!,
            "EmailAddress": RealmService.getBook().last!.email!,
            "ReasonforenquiryId": RealmService.getBook().last!.reasonforenquiryId,
            "branchId": RealmService.getBook().last!.branchId,
            "BookingDateandTime": RealmService.getBook().last!.date!,
            "LastName" : RealmService.getBook().last!.lname!,
            "Latitude" : RealmService.getAddress().last!.lat!,
            "Longitude" : RealmService.getAddress().last!.long!,
            "Location" : RealmService.getAddress().last!.address!,
            "BookingType" : RealmService.getBook().last!.bookingType,
            "Comment" : RealmService.getBook().last!.comment!
        ]
        print(parameters)
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .responseJSON{ (response) in
                print(response)
                if response.result.value != nil {
                    //print(response.result.value)
                    completion(true)
                }
                completion(false)
        }
    }
}
