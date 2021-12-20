//
//  TextTwoViewCell.swift
//  Attractions Taiwan
//
//  Created by NDHU_CSIE on 2021/12/20.
//

import UIKit

class TextTwoViewCell: UITableViewCell {
    
    @IBOutlet var TitlelabelOne: UILabel! {
        didSet{
            TitlelabelOne.text = TitlelabelOne.text?.uppercased()
            TitlelabelOne.numberOfLines = 0
        }
    }
    @IBOutlet var TextlabelOne: UILabel! {
        didSet {
            TextlabelOne.numberOfLines = 0
        }
    }
    @IBOutlet var TitlelabelTwo: UILabel! {
        didSet{
            TitlelabelTwo.text = TitlelabelTwo.text?.uppercased()
            TitlelabelTwo.numberOfLines = 0
        }
    }
    @IBOutlet var TextlabelTwo: UILabel! {
        didSet {
            TextlabelTwo.numberOfLines = 0
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
