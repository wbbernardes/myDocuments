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
    
    public func loadUsers(callback: @escaping CompletionHandler){
        Alamofire.request(url).responseJSON { response in
            print(response.result)
            
            if let json = response.result.value as? [AnyObject] {
                for user in json {
                    let userObject = UserModel(json:JSON(user))
                    self.userModel.append(userObject)
                }
                callback(true)
                return
            } else {
                print("error calling GET on /users")
                print(response.description)
                callback(false)
            }
        }
    }
}
