//
//  ServiceDocument.swift
//  myDocuments
//
//  Created by Wesley Brito on 03/11/18.
//  Copyright © 2018 Wesley Brito. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire


class ServiceDocument: NSObject {
    
    let urlDocument = "http://localhost:3000/document"
    let urlPhoto = "http://localhost:3000/photo"
    var documentModel: [DocumentModel] = []
    var photoModel: PhotoModel?
    
    //LOAD
    public func loadDocument(userID: Int, callback: @escaping CompletionHandler) {
        Alamofire.request(urlDocument).responseJSON { response in
            print(response.result)
            if let json = response.result.value as? [AnyObject] {
                for document in json {
                    let documentObject = DocumentModel(json: JSON(document))
                    if documentObject.userid == userID {
                        self.documentModel.append(documentObject)
                    }
                }
                callback(self.documentModel)
            }
        }
    }
    
    //LOAD
    public func loadPhoto(photoId: Int, callback: @escaping CompletionHandler) {
        let photoUrl = urlPhoto + "/" + "\(String(describing: urlPhoto))"
        Alamofire.request(photoUrl).responseJSON { (response) in
            print(response.result)
            if let json = response.result.value {
                let photoObject = PhotoModel(json: JSON(json))
                callback(photoObject)
            } else {
                print("ERROR SERVICE USER -----------------------------")
                print(response.description)
                callback(nil)
            }
        }
    }
    
    //DELETE
    func deleteDocument(document: DocumentModel?, callback: @escaping CompletionHandler) {
        var deleteUrl = ""
        if let idDocument = document?.id {
            deleteUrl = urlDocument + "/" + "\(idDocument)"
        }
        let idPhoto = document?.photoid
        if let objectDocument = document {
            Alamofire.request(deleteUrl, method: .delete, parameters: objectDocument.dictionaryRepresentation(), encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
                print(response.response as Any)
                
                if response.error == nil {
                    self.deletePhoto(idPhoto: idPhoto, callback: { (success) in
                        if success as! Bool {
                            callback(true)
                        } else {
                            callback(false)
                            print("ERROR SERVICE USER -----------------------------")
                            print(response.description)
                        }
                    })
                } else {
                    callback(false)
                }
            }
            self.documentModel.append(objectDocument)
        }
    }
    
    //DELETE
    func deletePhoto(idPhoto: Int?, callback: @escaping CompletionHandler) {
        let deleteUrl = urlPhoto + "/" + "\(String(describing: idPhoto))"
        if idPhoto != nil {
            Alamofire.request(deleteUrl, method: .delete, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
                print(response.response as Any)
                if response.error == nil {
                    callback(true)
                } else {
                    callback(false)
                    print("ERROR SERVICE USER -----------------------------")
                    print(response.description)
                }
            }
        }
    }
    
    //CREATE
    func addDocument(document: DocumentModel?, callback: @escaping CompletionHandler) {
        if let documentObject = document {
            Alamofire.request(urlDocument, method: .post, parameters: documentObject.dictionaryRepresentation(), encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
                print(response.response as Any)
                
                if response.error == nil {
                    let json = response.result.value
                    callback(DocumentModel.init(object: json as Any))
                } else {
                    callback(nil)
                    print("ERROR SERVICE USER -----------------------------")
                    print(response.description)
                }
            }
        }
    }
    
    //CREATE
    func addPhoto(photo: PhotoModel?, callback: @escaping CompletionHandler) {
        if let photoObject = photo {
            Alamofire.request(urlPhoto, method: .post, parameters: photoObject.dictionaryRepresentation(), encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
                if response.response?.statusCode == 200 {
                    
                        self.photoModel = photoObject
                    callback(1)
                    //passei valor fixo pois nao consegui fazer a minha API retornar os valores corretos.
                } else {
                    callback(0)
                }
            }
        }
        
    }
    
}
