//
//  TopratedTableViewCell.swift
//  The movies
//
//  Created by Mac on 13/08/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class TopratedTableViewCell: UITableViewCell {

    
    @IBOutlet var topRatedTitle: UILabel!
    @IBOutlet var topRatedcollection: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: D, forRow row: Int) {
        
        topRatedcollection.delegate   = dataSourceDelegate
        topRatedcollection.dataSource = dataSourceDelegate
        topRatedcollection.tag        = row
        topRatedcollection.reloadData()
        
        
    }

    
}
