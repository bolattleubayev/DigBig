//
//  DigDetailTableViewCell.swift
//  DigBig
//
//  Created by macbook on 5/3/20.
//  Copyright © 2020 bolattleubayev. All rights reserved.
//

import UIKit

class DigDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var digDetailImageView: UIImageView!
    @IBOutlet weak var digDetailTitleLabel: UILabel!
    @IBOutlet weak var digDetailSubtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
