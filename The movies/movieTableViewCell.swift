//
//  movieTableViewCell.swift
//  The movies
//
//  Created by Mac on 13/08/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class movieTableViewCell: UITableViewCell {

    
    @IBOutlet var NewMovies: UILabel!
    @IBOutlet var movieCollection: UICollectionView!
 

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: D, forRow row: Int) {
        print("setCollectionViewDataSourceDelegate")
        
        movieCollection.delegate = dataSourceDelegate
        movieCollection.dataSource = dataSourceDelegate
        
        movieCollection.tag = row
        movieCollection.reloadData()
        
    }

    
}

