//
//  Sence.swift
//  Attractions Taiwan
//
//  Created by NDHU_CSIE on 2021/12/6.
//

import Foundation
import CoreData
import UIKit

//struct Scene: Hashable {
//    var name: String = ""
//    var city: String = ""
//    var address: String = ""
//    var description: String = ""
//    var photoCount: Int = 0
//    var photos: [String] = ["", "", ""]
//}

public class Scene: NSManagedObject {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Scene> {
        return NSFetchRequest<Scene>(entityName: "Scene")
    }
    
    @NSManaged public var name: String
    @NSManaged public var city: String
    @NSManaged public var address: String
    @NSManaged public var descript: String
    @NSManaged public var photoCount: Decimal
    @NSManaged public var photo1: Data?
    @NSManaged public var photo2: Data?
    @NSManaged public var photo3: Data?
    
    // implement one customized managed object constructor
    convenience init(name: String, city: String, address: String, descript: String, photoCount: Decimal, photo1: String, photo2: String, photo3: String) {
        
        let appDelegate = (UIApplication.shared.delegate as? AppDelegate)
        self.init(context: appDelegate!.persistentContainer.viewContext)
        self.name = name
        self.city = city
        self.address = address
        self.descript = descript
        self.photoCount = photoCount
        self.photo1 = UIImage(named: photo1)!.pngData()!
        self.photo2 = UIImage(named: photo2)!.pngData()!
        self.photo3 = UIImage(named: photo3)!.pngData()!
    }
    
}

extension Scene {
    static func generateData(){
        _ = [
            Scene(name: "Taipei 101", city: "Taipei", address: "Taipei 101, Taipei", descript: "The Taipei 101 (台北101) is a supertall skyscraper designed by C.Y. Lee and C.P. Wang in Xinyi, Taipei, Taiwan. This building was officially classified as the world's tallest from its opening in 2004 until the 2010 completion of the Burj Khalifa in Dubai, UAE.", photoCount: 3, photo1: "101_1.jpg", photo2: "101_2.jpg", photo3: "101_3.jpg")
            ]
        
        let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        appDelegate.saveContext()
    }
}
