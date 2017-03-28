//
//  BuildingTableViewCell.swift
//  UVVClassroom
//
//  Created by lorenzopicoli on 28/03/17.
//  Copyright © 2017 Lorenzo Piccoli. All rights reserved.
//

import Foundation
import UIKit
import EasyPeasy
import EZYGradientView

class BuildingTableViewCell: UITableViewCell {
    
    //MARK: Variables
    private let buildingImageView = UIImageView()
    private let buildingName = UILabel()
    private let bottomGradient = EZYGradientView()
    
    init(imageName: String, title: String) {
        super.init(style: .default, reuseIdentifier: "BuildingTableViewCell")
        
        buildingImageView.image = UIImage(named: imageName)
        buildingName.text = title

        setupViews()
        setupContraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Views
    func setupViews() {
        buildingName.textColor = .white
        buildingName.font = UIFont.boldSystemFont(ofSize: 20)
        
        buildingImageView.contentMode = .scaleAspectFill
        buildingImageView.clipsToBounds = true
        
        // Gradient
        bottomGradient.firstColor = UIColor.black.withAlphaComponent(0.6)
        bottomGradient.secondColor = .clear
        bottomGradient.angleº = 180
        bottomGradient.fadeIntensity = 1
        
        addSubview(buildingImageView)
        addSubview(bottomGradient)
        addSubview(buildingName)

    }
    
    //MARK: Contraints
    func setupContraints() {
        buildingImageView <- Edges()
        
        buildingName <- [
            Bottom(20),
            Leading(10),
            Trailing(10)
        ]
        
        bottomGradient <- [
            Bottom(),
            Height(100),
            Trailing(),
            Leading()
        ]
    }
}
