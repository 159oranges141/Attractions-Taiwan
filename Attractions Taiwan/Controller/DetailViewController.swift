//
//  DetailViewController.swift
//  Attractions Taiwan
//
//  Created by NDHU_CSIE on 2021/12/13.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var tableview: UITableView!
    @IBOutlet var headerview: DetailHeaderView!
    
    var scenes: Scene!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Connect the tableview to the controller itself that provides the method implementation
        tableview.dataSource = self
        tableview.delegate = self
        
        // Config data on the table header
        headerview.namelabel.text = scenes.name
        
        

        // Disable the navigation title text
        navigationItem.largeTitleDisplayMode = .never
    }
    
    // MARK: - Proceed Segues for Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMap" {
            let destinationController = segue.destination as! MapViewController
            destinationController.scenes = scenes
        }
        //else if segue.identifier == "showWeather" {
        //    let destinationController = segue.destination as! WeatherViewController
        //    destinationController.scenes = scenes
        //}
    }
    
    

}


// MARK: - Method implementations for the tableview data source
extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
            
        case 0:  //for prototype cell 1
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TextTwoViewCell.self), for: indexPath) as! TextTwoViewCell
            
            cell.TitlelabelOne.text = "City"
            cell.TextlabelOne.text = scenes.city
            cell.TitlelabelTwo.text = "Address"
            cell.TextlabelTwo.text = scenes.address
            cell.selectionStyle = .none
            
            return cell
            
        case 1:  //for prototype cell 2
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TextViewCell.self), for: indexPath) as! TextViewCell
            
            cell.descriptlabel.text = scenes.descript
            cell.selectionStyle = .none
            
            return cell
            
        default:
            fatalError("Failed to instantiate the table view cell for detail view controller")
            
        }
    }
}
