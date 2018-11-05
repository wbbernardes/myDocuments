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
    
    func deleteDocument(i: Int, callback: @escaping CompletionHandler){
        ServiceDocument().deleteDocument(document: documentModel[i]) { result in
            callback(true)
        }
    }
    
    func saveDocument(userID: Int, name: String, photo: Data, callback: @escaping CompletionHandler) {
        
        let photoObject = PhotoModel.init(object: (Any).self)
        photoObject.img = encodeImageToBase64(imageData: photo)
        photoObject.createdat = "\(Date().timeIntervalSinceNow)"
//        print(photoObject.img)
        
        ServiceDocument().addPhoto(photo: photoObject) { (response) in
            if response as! Int > 0 {
                let documentObject = DocumentModel.init(object: (Any).self)
                documentObject.nome = name
                documentObject.photoid = response as? Int
                documentObject.userid = userID
                documentObject.data = "\(Date().timeIntervalSinceNow)"
                documentObject.createdat = "\(Date().timeIntervalSinceNow)"
                ServiceDocument().addDocument(document: documentObject, callback: { (result) in
                    if result != nil {
                        self.documentModel.append(result as! DocumentModel)
                        callback(true)
                    } else {
                        callback(false)
                    }
                })
                
            }
            
        }
    }
    
    func filterListDocuments(name: String, documents: [DocumentModel]) -> [DocumentModel] {
        if name.isEmpty {
            return self.documentModel
        }
        
        return documents.filter{$0.nome?.lowercased().contains(name.lowercased()) ?? false}
    }
    
    func selectDocument(i: Int) -> DocumentModel {
        return self.documentModel[i]
    }
    
    func selectPhoto(idPhoto: Int, callback: @escaping CompletionHandler) {
        ServiceDocument().loadPhoto(photoId: idPhoto) { result in
            if result !=  nil{
                callback(result as! PhotoModel)
            } else {
                callback(nil)
            }
        }
    }
    
    func encodeImageToBase64(imageData : Data) -> String{
        let strBase64 = imageData.base64EncodedString(options: Data.Base64EncodingOptions.init(rawValue: 0))
        return strBase64
    }
    
    func orderListDocuments(documents: [DocumentModel]) -> [DocumentModel]{
        return documents.sorted { $0.nome! < $1.nome! }
    }
    
}
