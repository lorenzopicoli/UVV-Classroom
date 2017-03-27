//
//  UVVApiManager.swift
//  UVVClassroom
//
//  Created by lorenzopicoli on 25/03/17.
//  Copyright © 2017 Lorenzo Piccoli. All rights reserved.
//

import Foundation
import Alamofire

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
        
        // We are making the request using Alamofire directly and building the URL ourselves
        // without proper encoding
        // If the API wasn't shitty and required(!) the URL params to be in a certain order
        // we would be able to use our wrapper
        
        let baseUrl = AlamofireWrapper.getFormatterdUrl(route: "getSalas")
        let url = "\(baseUrl)?prd=\(buildingId)&hrr=\(shift.rawValue)&dss=\(Utility.dateToApiString(date: date))"
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            AlamofireWrapper.handleResponse(response: response, completion: { (result, error) in
                guard result != .null,
                    let resultArray = result.array else { return completion([], error) }
                
                var rooms:[Room] = []
                
                for roomData in resultArray{
                    rooms.append(Room(json: roomData))
                }
                
                completion(rooms, nil)
            })
        }
    }
}
