//
//  MyTableViewCell.swift
//  countryList
//
//  Created by lolivera on 06/09/2021.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    @IBOutlet weak var countryView: UIView!
    @IBOutlet weak var countryImage: UIImageView!
    @IBOutlet weak var countryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//    }

}
