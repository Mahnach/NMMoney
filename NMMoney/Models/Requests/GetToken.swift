//
//  GetToken.swift
//  NMMoney
//
//  Created by Евгений Махнач on 27.08.2018.
//  Copyright © 2018 Евгений Махнач. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift

class GetToken{

    static func getToken(completion: @escaping (Bool) -> Void) {
        
        let url = "http://api.nmmoneybookings.co.uk/login/"
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        let parameters: Parameters = [
            "email": "dev@dev.com",
            "password": "P@ssw0rd!"
        ]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .validate()
            .responseJSON{ (response) in
                print(response.result.value)
                if response.result.value != nil {
                    let token = response.result.value as! [String: Any]
                    let tokenInstance = TokenModel()
                    tokenInstance.token = token["Token"] as! String
                    RealmService.deleteToken()
                    RealmService.writeIntoRealm(object: tokenInstance)
                }
                
                completion(true)
        }
    }
}
