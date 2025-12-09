//
//  PosicionModel.swift
//  TrukmenAdmin
//
//  Created by Adan Magaña on 24/05/22.
//  Copyright © 2022 Adan Magaña. All rights reserved.
//

import Foundation
import SwiftyJSON

class PositionModelo : NSObject, NSCoding{

    var positions : [Position]!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            print("json empty ")
            return
        }
      //  print("json position ", json)
        positions = [Position]()
        let positionsArray = json["positions"].arrayValue
        for positionsJson in positionsArray{
            let value = Position(fromJson: positionsJson)
            positions.append(value)
        }
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if positions != nil{
        var dictionaryElements = [[String:Any]]()
        for positionsElement in positions {
            dictionaryElements.append(positionsElement.toDictionary())
        }
        dictionary["positions"] = dictionaryElements
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
        positions = aDecoder.decodeObject(forKey: "positions") as? [Position]
    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if positions != nil{
            aCoder.encode(positions, forKey: "positions")
        }

    }

}

class Position : NSObject, NSCoding{

    var accuracy : Int!
    var address : String!
    var altitude : Int!
    var attributes : PositionAttributes!
    var course : Int!
    var deviceId : Int!
    var deviceTime : String!
    var fixTime : String!
    var id : Int!
    var latitude : Float!
    var longitude : Float!
    var network : AnyObject!
    var outdated : Bool!
    var `protocol` : String!
    var serverTime : String!
    var speed : Float!
    var type : AnyObject!
    var valid : Bool!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        accuracy = json["accuracy"].intValue
        address = json["address"].stringValue
        altitude = json["altitude"].intValue
        let attributesJson = json["attributes"]
        if !attributesJson.isEmpty{
            attributes = PositionAttributes(fromJson: attributesJson)
        }
        course = json["course"].intValue
        deviceId = json["deviceId"].intValue
        deviceTime = json["deviceTime"].stringValue
        fixTime = json["fixTime"].stringValue
        id = json["id"].intValue
        latitude = json["latitude"].floatValue
        longitude = json["longitude"].floatValue
        network = json["network"] as AnyObject
        outdated = json["outdated"].boolValue
        `protocol` = json["protocol"].stringValue
        serverTime = json["serverTime"].stringValue
        speed = json["speed"].floatValue
        type = json["type"] as AnyObject
        valid = json["valid"].boolValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if accuracy != nil{
            dictionary["accuracy"] = accuracy
        }
        if address != nil{
            dictionary["address"] = address
        }
        if altitude != nil{
            dictionary["altitude"] = altitude
        }
        if attributes != nil{
            dictionary["attributes"] = attributes.toDictionary()
        }
        if course != nil{
            dictionary["course"] = course
        }
        if deviceId != nil{
            dictionary["deviceId"] = deviceId
        }
        if deviceTime != nil{
            dictionary["deviceTime"] = deviceTime
        }
        if fixTime != nil{
            dictionary["fixTime"] = fixTime
        }
        if id != nil{
            dictionary["id"] = id
        }
        if latitude != nil{
            dictionary["latitude"] = latitude
        }
        if longitude != nil{
            dictionary["longitude"] = longitude
        }
        if network != nil{
            dictionary["network"] = network
        }
        if outdated != nil{
            dictionary["outdated"] = outdated
        }
        if `protocol` != nil{
            dictionary["protocol"] = `protocol`
        }
        if serverTime != nil{
            dictionary["serverTime"] = serverTime
        }
        if speed != nil{
            dictionary["speed"] = speed
        }
        if type != nil{
            dictionary["type"] = type
        }
        if valid != nil{
            dictionary["valid"] = valid
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
        accuracy = aDecoder.decodeObject(forKey: "accuracy") as? Int
        address = aDecoder.decodeObject(forKey: "address") as? String
        altitude = aDecoder.decodeObject(forKey: "altitude") as? Int
        attributes = aDecoder.decodeObject(forKey: "attributes") as? PositionAttributes
        course = aDecoder.decodeObject(forKey: "course") as? Int
        deviceId = aDecoder.decodeObject(forKey: "deviceId") as? Int
        deviceTime = aDecoder.decodeObject(forKey: "deviceTime") as? String
        fixTime = aDecoder.decodeObject(forKey: "fixTime") as? String
        id = aDecoder.decodeObject(forKey: "id") as? Int
        latitude = aDecoder.decodeObject(forKey: "latitude") as? Float
        longitude = aDecoder.decodeObject(forKey: "longitude") as? Float
        network = aDecoder.decodeObject(forKey: "network") as? AnyObject
        outdated = aDecoder.decodeObject(forKey: "outdated") as? Bool
        `protocol` = aDecoder.decodeObject(forKey: "protocol") as? String
        serverTime = aDecoder.decodeObject(forKey: "serverTime") as? String
        speed = aDecoder.decodeObject(forKey: "speed") as? Float
        type = aDecoder.decodeObject(forKey: "type") as? AnyObject
        valid = aDecoder.decodeObject(forKey: "valid") as? Bool
    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if accuracy != nil{
            aCoder.encode(accuracy, forKey: "accuracy")
        }
        if address != nil{
            aCoder.encode(address, forKey: "address")
        }
        if altitude != nil{
            aCoder.encode(altitude, forKey: "altitude")
        }
        if attributes != nil{
            aCoder.encode(attributes, forKey: "attributes")
        }
        if course != nil{
            aCoder.encode(course, forKey: "course")
        }
        if deviceId != nil{
            aCoder.encode(deviceId, forKey: "deviceId")
        }
        if deviceTime != nil{
            aCoder.encode(deviceTime, forKey: "deviceTime")
        }
        if fixTime != nil{
            aCoder.encode(fixTime, forKey: "fixTime")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if latitude != nil{
            aCoder.encode(latitude, forKey: "latitude")
        }
        if longitude != nil{
            aCoder.encode(longitude, forKey: "longitude")
        }
        if network != nil{
            aCoder.encode(network, forKey: "network")
        }
        if outdated != nil{
            aCoder.encode(outdated, forKey: "outdated")
        }
        if `protocol` != nil{
            aCoder.encode(`protocol`, forKey: "protocol")
        }
        if serverTime != nil{
            aCoder.encode(serverTime, forKey: "serverTime")
        }
        if speed != nil{
            aCoder.encode(speed, forKey: "speed")
        }
        if type != nil{
            aCoder.encode(type, forKey: "type")
        }
        if valid != nil{
            aCoder.encode(valid, forKey: "valid")
        }

    }

}

class PositionAttributes : NSObject, NSCoding{

    var battery : Float!
    var di1 : Int!
    var distance : Float!
    var event : Int!
    var gpsStatus : Int!
    var hdop : Float!
    var hours : Int!
    var ignition : Bool!
    var io11 : Int!
    var io14 : Int!
    var io16 : Int!
    var io200 : Int!
    var io207 : Int!
    var io249 : Int!
    var io68 : Int!
    var motion : Bool!
    var `operator` : Int!
    var out1 : Bool!
    var pdop : Float!
    var power : Float!
    var priority : Int!
    var rssi : Int!
    var sat : Int!
    var totalDistance : Float!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        battery = json["battery"].floatValue
        di1 = json["di1"].intValue
        distance = json["distance"].floatValue
        event = json["event"].intValue
        gpsStatus = json["gpsStatus"].intValue
        hdop = json["hdop"].floatValue
        hours = json["hours"].intValue
        ignition = json["ignition"].boolValue
        io11 = json["io11"].intValue
        io14 = json["io14"].intValue
        io16 = json["io16"].intValue
        io200 = json["io200"].intValue
        io207 = json["io207"].intValue
        io249 = json["io249"].intValue
        io68 = json["io68"].intValue
        motion = json["motion"].boolValue
        `operator` = json["operator"].intValue
        out1 = json["out1"].boolValue
        pdop = json["pdop"].floatValue
        power = json["power"].floatValue
        priority = json["priority"].intValue
        rssi = json["rssi"].intValue
        sat = json["sat"].intValue
        totalDistance = json["totalDistance"].floatValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if battery != nil{
            dictionary["battery"] = battery
        }
        if di1 != nil{
            dictionary["di1"] = di1
        }
        if distance != nil{
            dictionary["distance"] = distance
        }
        if event != nil{
            dictionary["event"] = event
        }
        if gpsStatus != nil{
            dictionary["gpsStatus"] = gpsStatus
        }
        if hdop != nil{
            dictionary["hdop"] = hdop
        }
        if hours != nil{
            dictionary["hours"] = hours
        }
        if ignition != nil{
            dictionary["ignition"] = ignition
        }
        if io11 != nil{
            dictionary["io11"] = io11
        }
        if io14 != nil{
            dictionary["io14"] = io14
        }
        if io16 != nil{
            dictionary["io16"] = io16
        }
        if io200 != nil{
            dictionary["io200"] = io200
        }
        if io207 != nil{
            dictionary["io207"] = io207
        }
        if io249 != nil{
            dictionary["io249"] = io249
        }
        if io68 != nil{
            dictionary["io68"] = io68
        }
        if motion != nil{
            dictionary["motion"] = motion
        }
        if `operator` != nil{
            dictionary["operator"] = `operator`
        }
        if out1 != nil{
            dictionary["out1"] = out1
        }
        if pdop != nil{
            dictionary["pdop"] = pdop
        }
        if power != nil{
            dictionary["power"] = power
        }
        if priority != nil{
            dictionary["priority"] = priority
        }
        if rssi != nil{
            dictionary["rssi"] = rssi
        }
        if sat != nil{
            dictionary["sat"] = sat
        }
        if totalDistance != nil{
            dictionary["totalDistance"] = totalDistance
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
        battery = aDecoder.decodeObject(forKey: "battery") as? Float
        di1 = aDecoder.decodeObject(forKey: "di1") as? Int
        distance = aDecoder.decodeObject(forKey: "distance") as? Float
        event = aDecoder.decodeObject(forKey: "event") as? Int
        gpsStatus = aDecoder.decodeObject(forKey: "gpsStatus") as? Int
        hdop = aDecoder.decodeObject(forKey: "hdop") as? Float
        hours = aDecoder.decodeObject(forKey: "hours") as? Int
        ignition = aDecoder.decodeObject(forKey: "ignition") as? Bool
        io11 = aDecoder.decodeObject(forKey: "io11") as? Int
        io14 = aDecoder.decodeObject(forKey: "io14") as? Int
        io16 = aDecoder.decodeObject(forKey: "io16") as? Int
        io200 = aDecoder.decodeObject(forKey: "io200") as? Int
        io207 = aDecoder.decodeObject(forKey: "io207") as? Int
        io249 = aDecoder.decodeObject(forKey: "io249") as? Int
        io68 = aDecoder.decodeObject(forKey: "io68") as? Int
        motion = aDecoder.decodeObject(forKey: "motion") as? Bool
        `operator` = aDecoder.decodeObject(forKey: "operator") as? Int
        out1 = aDecoder.decodeObject(forKey: "out1") as? Bool
        pdop = aDecoder.decodeObject(forKey: "pdop") as? Float
        power = aDecoder.decodeObject(forKey: "power") as? Float
        priority = aDecoder.decodeObject(forKey: "priority") as? Int
        rssi = aDecoder.decodeObject(forKey: "rssi") as? Int
        sat = aDecoder.decodeObject(forKey: "sat") as? Int
        totalDistance = aDecoder.decodeObject(forKey: "totalDistance") as? Float
    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if battery != nil{
            aCoder.encode(battery, forKey: "battery")
        }
        if di1 != nil{
            aCoder.encode(di1, forKey: "di1")
        }
        if distance != nil{
            aCoder.encode(distance, forKey: "distance")
        }
        if event != nil{
            aCoder.encode(event, forKey: "event")
        }
        if gpsStatus != nil{
            aCoder.encode(gpsStatus, forKey: "gpsStatus")
        }
        if hdop != nil{
            aCoder.encode(hdop, forKey: "hdop")
        }
        if hours != nil{
            aCoder.encode(hours, forKey: "hours")
        }
        if ignition != nil{
            aCoder.encode(ignition, forKey: "ignition")
        }
        if io11 != nil{
            aCoder.encode(io11, forKey: "io11")
        }
        if io14 != nil{
            aCoder.encode(io14, forKey: "io14")
        }
        if io16 != nil{
            aCoder.encode(io16, forKey: "io16")
        }
        if io200 != nil{
            aCoder.encode(io200, forKey: "io200")
        }
        if io207 != nil{
            aCoder.encode(io207, forKey: "io207")
        }
        if io249 != nil{
            aCoder.encode(io249, forKey: "io249")
        }
        if io68 != nil{
            aCoder.encode(io68, forKey: "io68")
        }
        if motion != nil{
            aCoder.encode(motion, forKey: "motion")
        }
        if `operator` != nil{
            aCoder.encode(`operator`, forKey: "operator")
        }
        if out1 != nil{
            aCoder.encode(out1, forKey: "out1")
        }
        if pdop != nil{
            aCoder.encode(pdop, forKey: "pdop")
        }
        if power != nil{
            aCoder.encode(power, forKey: "power")
        }
        if priority != nil{
            aCoder.encode(priority, forKey: "priority")
        }
        if rssi != nil{
            aCoder.encode(rssi, forKey: "rssi")
        }
        if sat != nil{
            aCoder.encode(sat, forKey: "sat")
        }
        if totalDistance != nil{
            aCoder.encode(totalDistance, forKey: "totalDistance")
        }

    }

}
