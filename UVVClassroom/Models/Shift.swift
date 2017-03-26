//
//  Shift.swift
//  UVVClassroom
//
//  Created by lorenzopicoli on 26/03/17.
//  Copyright © 2017 Lorenzo Piccoli. All rights reserved.
//

import Foundation

enum Shift:Int {
    
    // First class in the morning shift
    case firstMorning = 1
    case secondMorning = 2
    // Yeah, the api has no logical pattern
    case thirdMorning = 7
    
    case firstAfternoon = 3
    case secondAfternoon = 4
    case thirdAfternoon = 8
    
    case firstNight = 5
    case secondNight = 6
}
