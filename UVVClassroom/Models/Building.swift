//
//  Building.swift
//  UVVClassroom
//
//  Created by lorenzopicoli on 26/03/17.
//  Copyright © 2017 Lorenzo Piccoli. All rights reserved.
//

import Foundation
import SwiftyJSON

class Building: NSObject{
    var id:Int?
    var name = ""
    var courses = ""
    var imageName = ""
    var locDescription = ""
    var numberOfRooms = 0
    
    init(json: JSON) {
        self.id = json["IDPredio"].int
        
        if let name = json["DSPredio"].string {
            self.name = name
        }
        
        if let name = json["DSPredio"].string {
            self.name = name
        }
        
        if let locDescription = json["DSLocalizacao"].string {
            self.locDescription = locDescription
        }
        
        if let courses = json["DSCursos"].string {
            self.courses = courses
        }
        
        if let imageName = json["NOImagem"].string {
            self.imageName = imageName
        }
        
        if let numberOfRooms = json["NRSalasPredio"].int {
            self.numberOfRooms = numberOfRooms
        }
    }
}
