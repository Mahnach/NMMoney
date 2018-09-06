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

class GetSlots{
    
    static func getSlots(completion: @escaping (Bool) -> Void) {
        // testing - http://apidev.nmmoneybookings.co.uk/bms/appointment/list
        //http://api.nmmoneybookings.co.uk/bms/appointment/list
        let url = "http://api.nmmoneybookings.co.uk/bms/appointment/list"
        
        
        let date = Date()
        let calendar = Calendar.current
        
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        var monthString = ""
        if month < 10 {
            monthString = "0" + String(describing: month)
        } else {
            monthString = String(describing: month)
        }
        let day = calendar.component(.day, from: date)
        var dayString = ""
        if day < 10 {
            dayString = "0" + String(describing: day)
        } else {
            dayString = String(describing: day)
        }
        let h = calendar.component(.hour, from: date)
        let m = calendar.component(.minute, from: date)
        var hString = ""
        if h < 10 {
            hString = "0" + String(describing: h)
        } else {
            hString = String(describing: h)
        }
        var minutesString = ""
        if m < 10 {
            minutesString = "0" + String(describing: m)
        } else {
            minutesString = String(describing: m)
        }
        var secString = ""
        let s = calendar.component(.second, from: date)
        if s < 10 {
            secString = "0" + String(describing: s)
        } else {
            secString = String(describing: s)
        }
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "X-AuthToken": RealmService.getToken().last!.token!
        ]
        
        let parameters: Parameters = [
            "appointmentType": UserDefaults.standard.string(forKey: "appType")!,
            "branchId": UserDefaults.standard.string(forKey: "branchId")!,
            "currentDateTime": String(describing: year) + "-" + monthString + "-" + dayString + "T" + hString + ":" + minutesString + ":" + secString
        ]

        print(parameters)
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .validate()
            .responseJSON{ (response) in
                if response.result.value != nil {
                    RealmService.deleteSlots()
                    //print(response.result.value)
                    
                    let array = response.result.value as! Array<[String: Any]>
                    
                    for element in array {
                        let instance = SlotsModel()
                        instance.available = element["AppointmentAvailable"] as! Bool
                        var date = element["AppointmentDate"] as? String
                        var parsedDate = date?.components(separatedBy: "T")
                        
                        var time = element["AppointmentTime"] as? String
                        var parsedTime = time?.components(separatedBy: "T")
                        instance.weekDay = element["AppointmentDay"] as? String
                        instance.year = parsedDate![0].components(separatedBy: "-")[0]
                        instance.month = parsedDate![0].components(separatedBy: "-")[1]
                        instance.day = parsedDate![0].components(separatedBy: "-")[2]
                        instance.hours = parsedTime![1].components(separatedBy: ":")[0]
                        instance.minutes = parsedTime![1].components(separatedBy: ":")[1]
                        RealmService.writeIntoRealm(object: instance)
                    }

                    completion(true)
                }
                completion(false)
        }
    }
}
