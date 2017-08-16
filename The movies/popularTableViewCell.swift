//
//  popularTableViewCell.swift
//  The movies
//
//  Created by Mac on 13/08/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class popularTableViewCell: UITableViewCell {

    @IBOutlet var popularTitle: UILabel!
    @IBOutlet var popularCollection: UICollectionView!

    
      override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: D, forRow row: Int) {
        
        popularCollection.delegate   = dataSourceDelegate
        popularCollection.dataSource = dataSourceDelegate
        popularCollection.tag        = row
        popularCollection.reloadData()
        
        
        
        
        
    }

    
    
}
