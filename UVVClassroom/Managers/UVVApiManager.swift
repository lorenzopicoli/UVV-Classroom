//
//  UVVApiManager.swift
//  UVVClassroom
//
//  Created by lorenzopicoli on 25/03/17.
//  Copyright © 2017 Lorenzo Piccoli. All rights reserved.
//

import Foundation
class UVVApiManager: NSObject{
    
    // MARK: Variables
    static let apiURL:String = "http://www.uvv.br"
    static let apiURLSuffix:String = ".ashx"
    
    //MARK: Buildings
    class func getBuildings(completion: @escaping ([Building], UVVError?) -> Void){
        
        AlamofireWrapper.get(route: "getPredios") { (result, error) in
            guard result != .null,
                let resultArray = result.array else { return completion([], error) }
            
            var buildings:[Building] = []
            
            for buildingData in resultArray{
                buildings.append(Building(json: buildingData))
            }
            
            completion(buildings, nil)
        }
    }
    
    //MARK: Rooms
    class func getRooms(fromBuilding building: Building, shift: Shift, onDate date: Date, completion: @escaping ([Room], UVVError?) -> Void){
        
        guard let buildingId = building.id else {
            print("No building ID")
            return
        }
        
        let parameters: [String: Any] = [
            "prd": buildingId,
            "hrr": shift.rawValue,
            "dss": date
        ]
        
        AlamofireWrapper.get(route: "getSalas", params: parameters) { (result, error) in
            guard result != .null,
                let resultArray = result.array else { return completion([], error) }
            
            var rooms:[Room] = []
            
            for roomData in resultArray{
                rooms.append(Room(json: roomData))
            }
            
            completion(rooms, nil)
        }
    }
}
