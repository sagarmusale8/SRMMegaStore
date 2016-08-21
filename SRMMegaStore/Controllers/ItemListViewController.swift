//
//  ItemListViewController.swift
//  SRMMegaStore
//
//  Created by Sagar Musale on 20/08/16.
//  Copyright © 2016 SRM. All rights reserved.
//

import UIKit

class ItemListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionViewItems: UICollectionView!
    
    let reusableIdForItemCollectionViewCell = String(ItemCollectionViewCell)
    let minimumSpacing: CGFloat = 2
    
    var allItems: [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchAllItems()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    // MARK: Loading data from core data
    func fetchAllItems(){
        if let sortedItems = ItemsDataHandler.getAllItems(){
            allItems = sortedItems
        }
        collectionViewItems.reloadData()
    }

    // MARK: UICollectionView DataSource Method
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return allItems.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        if let itemCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(reusableIdForItemCollectionViewCell, forIndexPath: indexPath) as? ItemCollectionViewCell{
            let item = allItems[indexPath.row]
            itemCollectionViewCell.lblItem.text = item.name
            if let price = item.price{
                itemCollectionViewCell.lblPrice.text = "$\(price)"
            }
            if let imageData = item.image{
                itemCollectionViewCell.imgItem.image = UIImage(data: imageData)
            }
            
            return itemCollectionViewCell
        }
        return UICollectionViewCell()
    }
    
    // MARK: 
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat{
        return minimumSpacing
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat{
        return minimumSpacing
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        
        let collectionViewWidth = collectionView.viewWidth()
        var width: CGFloat = 300
        
        if collectionViewWidth < 500 {
            let widthForTwo = CGFloat(collectionViewWidth / 2) - minimumSpacing
            width = floor(widthForTwo)
        }
        
        return CGSizeMake(width, width+50)
    }
}

