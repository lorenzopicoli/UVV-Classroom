//
//  Utility.swift
//  UVVClassroom
//
//  Created by lorenzopicoli on 27/03/17.
//  Copyright © 2017 Lorenzo Piccoli. All rights reserved.
//

import Foundation
import UIKit

class Utility: NSObject{
    
    class func dateToApiString(date: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        return formatter.string(from: date)
    }
    
    class func setLogoTitle(vc: UIViewController) {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "logo"))
        imageView.frame.size = CGSize(width: 40, height: 40)
        imageView.contentMode = .scaleAspectFit
        vc.navigationItem.titleView = imageView
    }
}
