//
//  UserController.swift
//  myDocuments
//
//  Created by Wesley Brito on 03/11/18.
//  Copyright © 2018 Wesley Brito. All rights reserved.
//

import Foundation

class UserController: NSObject {
    
    var userModel: [UserModel] = []
    var numberOfUsers: Int { return userModel.count }
    
    func loadUsers(callback: @escaping CompletionHandler) {
        ServiceUser().loadUsers { (result) in
            self.userModel = result as! [UserModel]
            callback(true)
        }
    }
    
    func getNumberElements() -> Int {
        return userModel.count
    }
    
    func getNome(_ index: Int) -> String {
        if let nome = userModel[index].nome{ return nome } else { return "" }
        
    }
    
    func getEmail(_ index: Int) -> String {
        if let email = userModel[index].email { return email } else { return "" }
        
    }
    
}
