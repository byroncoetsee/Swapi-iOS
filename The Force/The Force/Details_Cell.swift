//
//  Details_Cell.swift
//  The Force
//
//  Created by Byron Coetsee on 2016/09/08.
//  Copyright © 2016 Byron Coetsee. All rights reserved.
//

import UIKit

class Details_Cell: UITableViewCell {
	
	@IBOutlet weak var viewSeparator: UIView!
	@IBOutlet weak var lblText: Sub_UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
