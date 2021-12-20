//
//  DetailHeaderView.swift
//  Attractions Taiwan
//
//  Created by NDHU_CSIE on 2021/12/13.
//

import UIKit

class DetailHeaderView: UIView {

    @IBOutlet var namelabel: UILabel! {
        didSet{
            namelabel.numberOfLines = 0
        }
    }

}
