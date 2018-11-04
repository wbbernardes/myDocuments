//
//  DocumentController.swift
//  myDocuments
//
//  Created by Wesley Brito on 03/11/18.
//  Copyright © 2018 Wesley Brito. All rights reserved.
//

import Foundation

class DocumentController: NSObject {
    
    var documentModel: [DocumentModel] = []
    
    func loadDocuments(userID: Int ,callback: @escaping CompletionHandler) {
        ServiceDocument().loadDocument(userID: userID) { (result) in
            self.documentModel = result as! [DocumentModel]
            callback(self.filterListDocuments(name: "", documents: self.documentModel))
        }
    }
    
    func filterListDocuments(name: String, documents: [DocumentModel]) -> [DocumentModel] {
        if name.isEmpty {
            return self.documentModel
        }
        
        return documents.filter{$0.nome?.lowercased().contains(name.lowercased()) ?? false}
    }
    
}
