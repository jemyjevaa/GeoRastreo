//
//  DeviceModel.swift
//  TrukmenAdmin
//
//  Created by Adan Magaña on 25/05/22.
//  Copyright © 2022 Adan Magaña. All rights reserved.
//

import Foundation
import SwiftyJSON

class deviceData : NSObject, NSCoding{

    var attributes : deviceAttribute!
    var category : String!
    var contact : String!
    var disabled : Bool!
    var geofenceIds : [AnyObject]!
    var groupId : Int!
    var id : Int!
    var lastUpdate : String!
    var model : String!
    var name : String!
    var phone : String!
    var positionId : Int!
    var status : String!
    var uniqueId : String!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
      //  print("json empty ", json)

        let attributesJson = json["attributes"]
        if !attributesJson.isEmpty{
            attributes = deviceAttribute(fromJson: attributesJson)
        }
        category = json["category"].stringValue
        contact = json["contact"].stringValue
        disabled = json["disabled"].boolValue
        geofenceIds = [Int]() as [AnyObject]
        let geofenceIdsArray = json["geofenceIds"].arrayValue
        for geofenceIdsJson in geofenceIdsArray{
            //geofenceIds.append(geofenceIdsJson.)
        }
        groupId = json["groupId"].intValue
        id = json["id"].intValue
        lastUpdate = json["lastUpdate"].stringValue
        model = json["model"].stringValue
        name = json["name"].stringValue
        phone = json["phone"].stringValue
        positionId = json["positionId"].intValue
        status = json["status"].stringValue
        uniqueId = json["uniqueId"].stringValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if attributes != nil{
            dictionary["attributes"] = attributes.toDictionary()
        }
        if category != nil{
            dictionary["category"] = category
        }
        if contact != nil{
            dictionary["contact"] = contact
        }
        if disabled != nil{
            dictionary["disabled"] = disabled
        }
        if geofenceIds != nil{
            dictionary["geofenceIds"] = geofenceIds
        }
        if groupId != nil{
            dictionary["groupId"] = groupId
        }
        if id != nil{
            dictionary["id"] = id
        }
        if lastUpdate != nil{
            dictionary["lastUpdate"] = lastUpdate
        }
        if model != nil{
            dictionary["model"] = model
        }
        if name != nil{
            dictionary["name"] = name
        }
        if phone != nil{
            dictionary["phone"] = phone
        }
        if positionId != nil{
            dictionary["positionId"] = positionId
        }
        if status != nil{
            dictionary["status"] = status
        }
        if uniqueId != nil{
            dictionary["uniqueId"] = uniqueId
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
        attributes = aDecoder.decodeObject(forKey: "attributes") as? deviceAttribute
        category = aDecoder.decodeObject(forKey: "category") as? String
        contact = aDecoder.decodeObject(forKey: "contact") as? String
        disabled = aDecoder.decodeObject(forKey: "disabled") as? Bool
        geofenceIds = aDecoder.decodeObject(forKey: "geofenceIds") as? [AnyObject]
        groupId = aDecoder.decodeObject(forKey: "groupId") as? Int
        id = aDecoder.decodeObject(forKey: "id") as? Int
        lastUpdate = aDecoder.decodeObject(forKey: "lastUpdate") as? String
        model = aDecoder.decodeObject(forKey: "model") as? String
        name = aDecoder.decodeObject(forKey: "name") as? String
        phone = aDecoder.decodeObject(forKey: "phone") as? String
        positionId = aDecoder.decodeObject(forKey: "positionId") as? Int
        status = aDecoder.decodeObject(forKey: "status") as? String
        uniqueId = aDecoder.decodeObject(forKey: "uniqueId") as? String
    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if attributes != nil{
            aCoder.encode(attributes, forKey: "attributes")
        }
        if category != nil{
            aCoder.encode(category, forKey: "category")
        }
        if contact != nil{
            aCoder.encode(contact, forKey: "contact")
        }
        if disabled != nil{
            aCoder.encode(disabled, forKey: "disabled")
        }
        if geofenceIds != nil{
            aCoder.encode(geofenceIds, forKey: "geofenceIds")
        }
        if groupId != nil{
            aCoder.encode(groupId, forKey: "groupId")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if lastUpdate != nil{
            aCoder.encode(lastUpdate, forKey: "lastUpdate")
        }
        if model != nil{
            aCoder.encode(model, forKey: "model")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        if phone != nil{
            aCoder.encode(phone, forKey: "phone")
        }
        if positionId != nil{
            aCoder.encode(positionId, forKey: "positionId")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
        if uniqueId != nil{
            aCoder.encode(uniqueId, forKey: "uniqueId")
        }

    }

}

class deviceAttribute : NSObject, NSCoding{


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {

    }

}
