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
            callback(result)
        }
    }
    
    func getNumberElements() -> Int {
        return userModel.count
    }
    
    func getNome(_ index: Int) -> String {
        guard let nome = userModel[index].nome else { return "" }
        return nome
    }
    
    func getEmail(_ index: Int) -> String {
        guard let email = userModel[index].email else { return "" }
        return email
    }
    
}
