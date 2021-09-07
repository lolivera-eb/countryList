//
//  MyCustonTableViewCell.swift
//  countryList
//
//  Created by lolivera on 03/09/2021.
//

import UIKit

class MyCustonTableViewCell: UITableViewCell {

    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var myLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        myLabel.font = UIFont.boldSystemFont(ofSize: 15)
        myLabel.textColor = .white
        backgroundColor = .gray
         
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

     
    }
    
}
