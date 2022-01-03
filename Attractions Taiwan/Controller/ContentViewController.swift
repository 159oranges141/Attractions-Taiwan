//
//  ContentViewController.swift
//  Attractions Taiwan
//
//  Created by NDHU_CSIE on 2021/12/27.
//

import UIKit

class ContentViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    
    var index = 0
    var image: Data?

    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = UIImage(data: image!)
    }
    
}
