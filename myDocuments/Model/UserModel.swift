//
//  UserModel.swift
//  myDocuments
//
//  Created by Wesley Brito on 03/11/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class UserModel: NSCoding {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let nome = "nome"
        static let email = "email"
        static let id = "id"
        static let telefone = "telefone"
        static let createdat = "createdat"
    }
    
    // MARK: Properties
    public var nome: String?
    public var email: String?
    public var id: Int?
    public var telefone: String?
    public var createdat: String?
    
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
        nome = json[SerializationKeys.nome].string
        email = json[SerializationKeys.email].string
        id = json[SerializationKeys.id].int
        telefone = json[SerializationKeys.telefone].string
        createdat = json[SerializationKeys.createdat].string
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = nome { dictionary[SerializationKeys.nome] = value }
        if let value = email { dictionary[SerializationKeys.email] = value }
        if let value = id { dictionary[SerializationKeys.id] = value }
        if let value = telefone { dictionary[SerializationKeys.telefone] = value }
        if let value = createdat { dictionary[SerializationKeys.createdat] = value }
        return dictionary
    }
    
    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.nome = aDecoder.decodeObject(forKey: SerializationKeys.nome) as? String
        self.email = aDecoder.decodeObject(forKey: SerializationKeys.email) as? String
        self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? Int
        self.telefone = aDecoder.decodeObject(forKey: SerializationKeys.telefone) as? String
        self.createdat = aDecoder.decodeObject(forKey: SerializationKeys.createdat) as? String
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(nome, forKey: SerializationKeys.nome)
        aCoder.encode(email, forKey: SerializationKeys.email)
        aCoder.encode(id, forKey: SerializationKeys.id)
        aCoder.encode(telefone, forKey: SerializationKeys.telefone)
        aCoder.encode(createdat, forKey: SerializationKeys.createdat)
    }
    
}
