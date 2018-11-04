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
    var documentObject = DocumentModel(object: (Any).self)
    
    func saveUser(userName: String?, userEmail: String?, userPhone: String? ) -> Bool {
        
        if let nome = userName, let email  = userEmail, let phone = userPhone {
            
            let objUser = UserModel(object: (Any).self)
            objUser.nome = nome
            objUser.email = email
            objUser.telefone = phone
            objUser.createdat = "\(Date().timeIntervalSinceNow)"
            
            return ServiceUser().addUsers(user: objUser)
        }
        return false
    }
    
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
        guard let nome = userModel[index].nome else { return "" }
        return nome
    }
    
    func getEmail(_ index: Int) -> String {
        guard let email = userModel[index].email else { return "" }
        return email
    }
    
    func didSelectUser(id : Int){
        documentObject.userid = id
    }
    
}
