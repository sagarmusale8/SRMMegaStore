//
//  ItemCollectionViewCell.swift
//  SRMMegaStore
//
//  Created by Sagar Musale on 20/08/16.
//  Copyright © 2016 SRM. All rights reserved.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgItem: UIImageView!
    @IBOutlet weak var lblItem: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
    // Setting up cell
    func setupCellUI(){
        lblItem.setProperties(UIColor.whiteColor(), textFont: Fonts.Regular_16)
        lblPrice.setProperties(UIColor.whiteColor(), textFont: Fonts.Regular_14)
    }
    
    // Cleaning UI for reuse
    override func prepareForReuse() {
        lblPrice.text = ""
        lblItem.text = ""
        imgItem.image = nil
    }
}
