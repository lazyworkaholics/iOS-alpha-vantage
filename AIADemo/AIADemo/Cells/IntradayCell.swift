//
//  IntradayCell.swift
//  AIADemo
//
//  Created by Harsha VARDHAN on 24/05/2021.
//

import UIKit

class IntradayCell: UITableViewCell {

    @IBOutlet var time_lbl: UILabel!
    @IBOutlet var open_lbl: UILabel!
    @IBOutlet var high_lbl: UILabel!
    @IBOutlet var low_lbl: UILabel!
    @IBOutlet var close_lbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        open_lbl.layer.cornerRadius = 10
        open_lbl.layer.borderWidth = 0.5
        open_lbl.layer.borderColor = UIColor.init(named: "navigation")?.cgColor
        
        high_lbl.layer.cornerRadius = 10
        high_lbl.layer.borderWidth = 0.5
        high_lbl.layer.borderColor = UIColor.init(named: "navigation")?.cgColor
        
        low_lbl.layer.cornerRadius = 10
        low_lbl.layer.borderWidth = 0.5
        low_lbl.layer.borderColor = UIColor.init(named: "navigation")?.cgColor
        
        close_lbl.layer.cornerRadius = 10
        close_lbl.layer.borderWidth = 0.5
        close_lbl.layer.borderColor = UIColor.init(named: "navigation")?.cgColor
    }

}
