//
//  CartTableViewCell.swift
//  SRMMegaStore
//
//  Created by Sagar Musale on 23/08/16.
//  Copyright © 2016 SRM. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnRemove: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // Cleaning UI for reuse
    override func prepareForReuse() {
        lblPrice.text = ""
        lblName.text = ""
        imgView.image = nil
    }
    
    // setting up cell UI
    func setupCellUI(){
        lblName.setProperties(UIColor.blueColor(), textFont: Fonts.Regular_18)
        lblPrice.setProperties(UIColor.blueColor(), textFont: Fonts.Regular_18)
        btnRemove.setProperties(UIColor.whiteColor(), textFont: Fonts.Medium_14, backgroundColor: Colors.Red_D52438)
        btnRemove.makeViewWithRoundedCorner(CGFloat(5.0))
        selectionStyle = .None
    }
}
