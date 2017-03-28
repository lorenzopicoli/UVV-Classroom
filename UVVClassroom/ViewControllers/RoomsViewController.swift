//
//  RoomsViewController.swift
//  UVVClassroom
//
//  Created by lorenzopicoli on 27/03/17.
//  Copyright © 2017 Lorenzo Piccoli. All rights reserved.
//

import UIKit
import EasyPeasy
import PMAlertController

class RoomsViewController: UIViewController {
    
    //MARK: Variables
    private var tableView:UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    fileprivate var rooms:[Room] = []
    fileprivate var building:Building!
    
    //MARK: View Controller Lifecycle
    init(building: Building) {
        super.init(nibName: nil, bundle: nil)
        
        self.building = building
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Utility.setLogoTitle(vc: self)
        
        setupViews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UVVApiManager.getRooms(fromBuilding: building, shift: .firstMorning, onDate: Date()) { (rooms, error) in
            if let error = error {
                self.showError(message: error.message)
                return
            }
            
            self.rooms = []
            for room in rooms {
                guard let _ = room.professorName,
                    let _ = room.className else { continue }
                self.rooms.append(room)
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
extension RoomsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Go")
    }
}

//MARK: Table View Data Source
extension RoomsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let room = rooms[indexPath.row]
        
        guard let className = room.className,
            let professorName = room.professorName else { return UITableViewCell() }
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "RoomsCell")
        
        cell.textLabel?.text = "\(room.roomNumber) - \(className)"
        cell.detailTextLabel?.text = professorName
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rooms.count
    }
}
