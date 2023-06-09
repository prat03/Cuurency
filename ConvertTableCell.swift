//
//  ConvertTableCell.swift
//  SME_Project
//
//  Created by Leena, Jayakumar (Contractor) on 09/06/23.
//

import UIKit

class ConvertTableCell: UITableViewCell {

    
    @IBOutlet weak var currency_result: UILabel!
    
    
    @IBOutlet weak var currency_rate: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
