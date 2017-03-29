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
    private var collectionView:UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
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
        
        self.title = building.name.replacingOccurrences(of: "Prédio", with: "")
        
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
            
            self.collectionView.reloadData()
        }
    }
    
    //MARK: Constraints
    func setupConstraints(){
        // Apply left = 0, right = 0, top = 20 and bottom = 0 constraints to its superview
        collectionView <- [
            Edges(UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0))
        ]
    }
    
    //MARK: Views
    func setupViews(){
        
        view.backgroundColor = .white
        
        // Collection View
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: UltravisualLayout())
        collectionView.backgroundColor = .clear
        self.collectionView.register(RoomCollectionViewCell.self, forCellWithReuseIdentifier: "RoomsCell")
        
        if #available(iOS 10.0, *) {
            collectionView.isPrefetchingEnabled = false
        }
        
        view.addSubview(collectionView)
    }
    
    //MARK: Helpers
    func showError(message: String){
        let alertVC = PMAlertController(title: "Algo deu errado", description: message, image: #imageLiteral(resourceName: "error-icon"), style: .alert)
        
        alertVC.addAction(PMAlertAction(title: "OK", style: .default))
        
        self.present(alertVC, animated: true, completion: nil)
    }
}

//MARK: Collection View Delegate
extension RoomsViewController: UICollectionViewDelegate {

}

//MARK: Collection View Data Source
extension RoomsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rooms.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RoomsCell", for: indexPath) as! RoomCollectionViewCell
        
        let room = rooms[indexPath.row]
        let label = UILabel()
        
        label.text = "\(room.roomNumber)"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        
        cell.contentView.addSubview(label)
        
        label <- [
            CenterX(),
            CenterY()
        ]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        for view in cell.contentView.subviews {
            if let a = view as? UILabel {
                a.removeFromSuperview()
            }
        }
    }
}
