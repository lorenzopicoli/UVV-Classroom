//
//  Room.swift
//  UVVClassroom
//
//  Created by lorenzopicoli on 26/03/17.
//  Copyright © 2017 Lorenzo Piccoli. All rights reserved.
//

import Foundation
import SwiftyJSON

class Room: NSObject{
    var id:Int?
    var shift:Shift?
    var shiftDescription = ""
    var roomNumber = 0
    var classNumber = 0
    var className = ""
    var professorName = ""
    var alert:String?
    
    init(json: JSON) {
        self.id = json["IDSala"].int
        
        if let shift = json["IDHorario"].int {
            self.shift = Shift(rawValue: shift)
        }
        
        if let shiftDescription = json["DSHorario"].string {
            self.shiftDescription = shiftDescription
        }
        
        if let roomNumber = json["NRSala"].int {
            self.roomNumber = roomNumber
        }
        
        if let professorName = json["NOProfessor"].string {
            self.professorName = professorName
        }
        
        if let className = json["NOTurma"].string {
            self.className = className
        }
        
        if let alert = json["DSAlerta"].string {
            self.alert = alert
        }
    }
}
