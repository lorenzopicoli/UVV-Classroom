//
//  Utility.swift
//  UVVClassroom
//
//  Created by lorenzopicoli on 27/03/17.
//  Copyright © 2017 Lorenzo Piccoli. All rights reserved.
//

import Foundation

class Utility: NSObject{
    
    class func dateToApiString(date: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        return formatter.string(from: date)
    }
}
