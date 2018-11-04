//
//  PhotoModel.swift
//  myDocuments
//
//  Created by Wesley Brito on 03/11/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class PhotoModel: NSCoding {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let img = "IMG"
        static let createdat = "CREATEDAT"
        static let id = "ID"
    }
    
    // MARK: Properties
    public var img: String?
    public var createdat: String?
    public var id: Int?
    
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
        img = json[SerializationKeys.img].string
        createdat = json[SerializationKeys.createdat].string
        id = json[SerializationKeys.id].int
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = img { dictionary[SerializationKeys.img] = value }
        if let value = createdat { dictionary[SerializationKeys.createdat] = value }
        if let value = id { dictionary[SerializationKeys.id] = value }
        return dictionary
    }
    
    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.img = aDecoder.decodeObject(forKey: SerializationKeys.img) as? String
        self.createdat = aDecoder.decodeObject(forKey: SerializationKeys.createdat) as? String
        self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? Int
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(img, forKey: SerializationKeys.img)
        aCoder.encode(createdat, forKey: SerializationKeys.createdat)
        aCoder.encode(id, forKey: SerializationKeys.id)
    }
    
}
