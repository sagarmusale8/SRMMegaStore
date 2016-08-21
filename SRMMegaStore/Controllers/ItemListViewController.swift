//
//  ItemListViewController.swift
//  SRMMegaStore
//
//  Created by Sagar Musale on 20/08/16.
//  Copyright © 2016 SRM. All rights reserved.
//

import UIKit

class ItemListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionViewItems: UICollectionView!
    
    let reusableIdForItemCollectionViewCell = String(ItemCollectionViewCell)
    
    var allItems: [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchAllItems()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: Setting up UI Componenets
    func setupUI(){
        
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
            itemCollectionViewCell.lblPrice.text = String(item.price)
            
            return itemCollectionViewCell
        }
        return UICollectionViewCell()
    }
}

