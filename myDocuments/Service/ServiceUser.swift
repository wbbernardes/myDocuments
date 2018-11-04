//
//  ServiceUser.swift
//  myDocuments
//
//  Created by Wesley Brito on 03/11/18.
//  Copyright © 2018 Wesley Brito. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

typealias CompletionHandler = (Any?) -> Void

class ServiceUser: NSObject {

    let url = "http://localhost:3000/users"
    var userModel: [UserModel] = []
    
    let headers: HTTPHeaders = [
        "Accept": "application/json"
    ]
    func addUsers(user: UserModel?) -> Bool {
        if let userObject = user {
            Alamofire.request(url, method: .post, parameters: userObject.dictionaryRepresentation(), encoding: JSONEncoding.default, headers: headers).response { (result) in
                print(result)
            }
            self.userModel.append(userObject)
            return true
        }
        
        return false
    }
    
    public func loadUsers(callback: @escaping CompletionHandler){
        Alamofire.request(url).responseJSON { response in
            print(response.result)
            
            if let json = response.result.value as? [AnyObject] {
                for user in json {
                    let userObject = UserModel(json:JSON(user))
                    self.userModel.append(userObject)
                }
                let sortedUser = self.userModel.sorted { $0.nome ?? "z" < $1.nome ?? "z" }
                callback(sortedUser)
                return
            } else {
                print("error calling GET on /users")
                print(response.description)
                callback(false)
            }
        }
    }
}
