//
//  MainTableViewController.swift
//  Attractions Taiwan
//
//  Created by NDHU_CSIE on 2021/12/6.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    var scenes:[Scene] = []
    
    lazy var dataSource = configureDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Scene.generateData(sourceArray: &scenes)
        
        tableView.dataSource = dataSource
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Scene>()
        snapshot.appendSections([.all])
        snapshot.appendItems(scenes, toSection: .all)
        
        dataSource.apply(snapshot, animatingDifferences: false)
        
    }
    
    func configureDataSource() -> DiffableDataSource {
        let cellIdentifier = "datacell"
        
        let dataSource = DiffableDataSource(
            tableView: tableView,
            cellProvider: { tableView, IndexPath, Scene in
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: IndexPath) as! MainTableViewCell
                
                cell.nameLabel.text = Scene.name
                cell.cityLabel.text = Scene.city
                
                return cell
            }
        )
        
        return dataSource
    }

    // MARK: - Table view data source

}
