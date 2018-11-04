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
    
    public func loadDocument(callback: @escaping CompletionHandler) {
        
        Alamofire.request(urlDocument).responseJSON { response in
            print(response.result)
            if let json = response.result.value as? [AnyObject] {
                for document in json {
                    let documentObject = DocumentModel(json: JSON(document))
                    let modelDoc = DocumentModel(object: (Any).self)
                    if documentObject.userid == modelDoc.userid {
                        self.documentModel.append(documentObject)
                    }
                }
            }
        }
        
    }
    
    
}
