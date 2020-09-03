//
//  Movie_Cell.swift
//  Flix App
//
//  Created by Eduardo Antonini on 9/3/20.
//  Copyright © 2020 Eduardo Antonini. All rights reserved.
//

import UIKit

class Movie_Cell: UITableViewCell {

    @IBOutlet weak var title_label: UILabel!
    @IBOutlet weak var synopsis_label: UILabel!
    @IBOutlet weak var movie_art: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
