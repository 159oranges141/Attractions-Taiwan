//
//  MainTableViewController.swift
//  Attractions Taiwan
//
//  Created by NDHU_CSIE on 2021/12/6.
//

import UIKit
import CoreData

class MainTableViewController: UITableViewController{
    
    var fetchResultController: NSFetchedResultsController<Scene>!
    var appDelegate: AppDelegate!
    var managedContext: NSManagedObjectContext!
    
    var scenes:[Scene] = []
    
    lazy var dataSource = configureDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Scene> = Scene.fetchRequest()
        let count = try? managedContext.count(for: fetchRequest)
        if count == 0 { Scene.generateData() }
        
        tableView.dataSource = dataSource
        
        //configure the navigation title
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // fetch data from the data store
        fetchSceneData()   //will refresh the table view
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
    
    // MARK: - swipe-to-left
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        //Get the selected restaurant
        guard let scene = self.dataSource.itemIdentifier(for: indexPath) else {
            return UISwipeActionsConfiguration()
        }

        
        //Delete Action
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, sourceView, completionHandler) in
            
            // Delete the data from the data store
            self.managedContext.delete(scene)
            self.appDelegate.saveContext()

            // Call completion handler to dismiss the action button
            completionHandler(true)
        }
        // Change the button's color
        deleteAction.backgroundColor = UIColor.systemRed
        deleteAction.image = UIImage(systemName: "trash")
        
        // Configure the action as swipe action
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])

        return swipeConfiguration

    }

    // MARK: - Core Data

    func fetchSceneData() {
        
        // Get the NSFetchRequest object and set the sorting criteria (at least one)
        let fetchRequest: NSFetchRequest<Scene> = Scene.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        //Use the NSFetchedResultController to fetch and monitor the managed objects
        fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultController.delegate = self
        
        //Start fetching data (run once and be monitored during the lifetime of the app)
        do {
            try fetchResultController.performFetch()
            updateSnapshot()  //create the snapshot for the table view
        } catch {
            print(error)
        }
    }
    
    func updateSnapshot() {
        if let fetchedObjects = fetchResultController.fetchedObjects {
            scenes = fetchedObjects
        }
        
        // Create a snapshot and populate the data
        var snapshot = NSDiffableDataSourceSnapshot<Section, Scene>()
        snapshot.appendSections([.all])
        snapshot.appendItems(scenes, toSection: .all)
        dataSource.apply(snapshot, animatingDifferences: false)
    }

}

extension MainTableViewController: NSFetchedResultsControllerDelegate {
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        updateSnapshot()
    }
    
}
