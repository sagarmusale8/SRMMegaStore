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
    func fetchAllItems(filterType: FilterType? = .ByName){
        if let sortedItems = ItemsDataHandler.getAllItems(withFilterType: filterType!){
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
            itemCollectionViewCell.setupCellUI()
            
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
    
    // MARK: On filter button tap
    @IBAction func actionOnFilter(sender: AnyObject) {
        let filterButton: UIBarButtonItem = sender as! UIBarButtonItem
        showFilterView(filterButton)
    }
    
    // Showing filter options
    func showFilterView(filterButton: UIBarButtonItem){
        let filterAlertView = UIAlertController(title: "Sort by", message: "Choose a filter to sort by", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let byNameFilterAction = UIAlertAction(title: "Name", style: UIAlertActionStyle.Default) { (action: UIAlertAction) in
            self.fetchAllItems()
        }
        
        let byPriceFilterAction = UIAlertAction(title: "Price", style: UIAlertActionStyle.Default) { (action: UIAlertAction) in
            self.fetchAllItems(FilterType.ByPrice)
        }
        
        let byCategoryFilterAction = UIAlertAction(title: "Category", style: UIAlertActionStyle.Default) { (action: UIAlertAction) in
            self.fetchAllItems(FilterType.ByCategory)
        }
        
        filterAlertView.addAction(byNameFilterAction)
        filterAlertView.addAction(byCategoryFilterAction)
        filterAlertView.addAction(byPriceFilterAction)
        
        self.showAsAlertController(filterAlertView, withBarButton: filterButton)
    }
    
    // MARK: Passing data to details view
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == ProjectConstant.SEGUE_DETIALS_ID, let destination = segue.destinationViewController as? ItemDetailsViewController {
            // if cart selects any item then it will load this item
            if let isItem = sender?.isKindOfClass(Item.self) where isItem{
                destination.selectedItemBlock = {()->Item in
                    return (sender as! Item)
                }
            }
            // If normal selection occures
            else if let isCollectionViewCell = sender?.isKindOfClass(UICollectionViewCell.self) where isCollectionViewCell{
                if let cell = sender as? UICollectionViewCell, let indexPath = collectionViewItems.indexPathForCell(cell) {
                    destination.selectedItemBlock = {()->Item in
                        return self.allItems[indexPath.row]
                    }
                }
            }
            
        } else if segue.identifier == ProjectConstant.SEGUE_SHOW_CART_FROM_LIST{
            addItemSelectionBlockToCartViewWithSegue(segue)
        }
    }
    
    // Adding
    func addItemSelectionBlockToCartViewWithSegue(segue: UIStoryboardSegue){
        if let navController = segue.destinationViewController as? UINavigationController, let cartController = navController.viewControllers.first as? CartViewController{
            cartController.itemSelectionBlock = {(item: Item)->Void in
                self.performSegueWithIdentifier(ProjectConstant.SEGUE_DETIALS_ID, sender: item)
            }
        }
    }
}

