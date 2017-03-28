//
//  BuildingsViewController.swift
//  UVVClassroom
//
//  Created by lorenzopicoli on 27/03/17.
//  Copyright © 2017 Lorenzo Piccoli. All rights reserved.
//

import UIKit
import EasyPeasy
import PMAlertController

class BuildingsViewController: UIViewController {
    
    //MARK: Variables
    private var tableView:UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    fileprivate var buildings:[Building] = []
    
    //MARK: View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Prédios"
        
        setupViews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UVVApiManager.getBuildings { (buildings, error) in
            if let error = error {
                print(error.message)
                self.showError(message: error.message)
                return
            }
            
            self.buildings = []
            
            for building in buildings {
                self.buildings.append(building)
            }

            self.tableView.reloadData()
        }
    }
    
    //MARK: Constraints
    func setupConstraints(){
        // Apply left = 0, right = 0, top = 20 and bottom = 0 constraints to its superview
        tableView <- Edges(UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0))
    }
    
    //MARK: Views
    func setupViews(){
        
        view.backgroundColor = .white
        
        tableView = UITableView()
        view.addSubview(tableView)
    }
    
    //MARK: Helpers
    func showError(message: String){
        let alertVC = PMAlertController(title: "Algo deu errado", description: message, image: #imageLiteral(resourceName: "error-icon"), style: .alert)
        
        alertVC.addAction(PMAlertAction(title: "OK", style: .default))
        
        self.present(alertVC, animated: true, completion: nil)
    }
}

//MARK: Table View Delegate
extension BuildingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(RoomsViewController(building: buildings[indexPath.row]), animated: true)
    }
}

//MARK: Table View Data Source
extension BuildingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let building = buildings[indexPath.row]
        let imageName = building.imageName ?? "default.jpg"
        
        let cell = BuildingTableViewCell(imageName: imageName, title: building.name)
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return buildings.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
