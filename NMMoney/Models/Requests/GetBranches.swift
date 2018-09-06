//
//  GetBranches.swift
//  NMMoney
//
//  Created by Евгений Махнач on 28.08.2018.
//  Copyright © 2018 Евгений Махнач. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift

class GetBranches{
    
    static func getBranches(completion: @escaping (Bool) -> Void) {
        // testing - http://apidev.nmmoneybookings.co.uk/bms/branch/list
        //http://api.nmmoneybookings.co.uk/bms/branch/list
        let url = "http://api.nmmoneybookings.co.uk/bms/branch/list"
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "X-AuthToken": RealmService.getToken().last!.token!
        ]

        
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .responseJSON{ (response) in
                print(response.result.value)
                if response.result.value != nil {
                    let branchesArray = response.result.value as! Array<[String: Any]>
                    RealmService.deleteBranches()
                    for element in branchesArray {
                        let branchInstance = BranchModel()
                        branchInstance.id = element["Id"] as! Int
                        branchInstance.modifiedDate = element["modifiedDate"] as? String
                        branchInstance.name = element["Name"] as? String
                        RealmService.writeIntoRealm(object: branchInstance)
                    }
 
                }
                
                completion(true)
        }
    }
}
