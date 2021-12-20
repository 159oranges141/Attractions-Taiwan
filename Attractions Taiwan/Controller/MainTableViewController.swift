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
        
        //configure the navigation title
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    // MARK: - UITableView Diffable Data Source
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
    
    // MARK: - For Segue's function
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                //get the destination's view controller
                let destinationController = segue.destination as! DetailViewController
                //pass the data from the source side to the destination side
                destinationController.scenes = scenes[indexPath.row]
            }
        }
    }
    
    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }

}
