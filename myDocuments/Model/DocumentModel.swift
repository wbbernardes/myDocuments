//
//  DocumentModel.swift
//  myDocuments
//
//  Created by Wesley Brito on 03/11/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class DocumentModel: NSCoding {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let data = "data"
        static let userid = "userid"
        static let id = "id"
        static let createdat = "createdat"
        static let nome = "nome"
    }
    
    // MARK: Properties
    public var data: String?
    public var userid: Int?
    public var id: Int?
    public var createdat: String?
    public var nome: String?
    
    // MARK: SwiftyJSON Initializers
    /// Initiates the instance based on the object.
    ///
    /// - parameter object: The object of either Dictionary or Array kind that was passed.
    /// - returns: An initialized instance of the class.
    public convenience init(object: Any) {
        self.init(json: JSON(object))
    }
    
    /// Initiates the instance based on the JSON that was passed.
    ///
    /// - parameter json: JSON object from SwiftyJSON.
    public required init(json: JSON) {
        data = json[SerializationKeys.data].string
        userid = json[SerializationKeys.userid].int
        id = json[SerializationKeys.id].int
        createdat = json[SerializationKeys.createdat].string
        nome = json[SerializationKeys.nome].string
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = data { dictionary[SerializationKeys.data] = value }
        if let value = userid { dictionary[SerializationKeys.userid] = value }
        if let value = id { dictionary[SerializationKeys.id] = value }
        if let value = createdat { dictionary[SerializationKeys.createdat] = value }
        if let value = nome { dictionary[SerializationKeys.nome] = value }
        return dictionary
    }
    
    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.data = aDecoder.decodeObject(forKey: SerializationKeys.data) as? String
        self.userid = aDecoder.decodeObject(forKey: SerializationKeys.userid) as? Int
        self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? Int
        self.createdat = aDecoder.decodeObject(forKey: SerializationKeys.createdat) as? String
        self.nome = aDecoder.decodeObject(forKey: SerializationKeys.nome) as? String
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(data, forKey: SerializationKeys.data)
        aCoder.encode(userid, forKey: SerializationKeys.userid)
        aCoder.encode(id, forKey: SerializationKeys.id)
        aCoder.encode(createdat, forKey: SerializationKeys.createdat)
        aCoder.encode(nome, forKey: SerializationKeys.nome)
    }
    
}
