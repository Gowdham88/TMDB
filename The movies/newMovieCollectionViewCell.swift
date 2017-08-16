//
//  newMovieCollectionViewCell.swift
//  The movies
//
//  Created by Mac on 13/08/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class newMovieCollectionViewCell: UICollectionViewCell {
    

    @IBOutlet var movieTitle: UILabel!
    @IBOutlet var newMovieImage: UIImageView!
    
    override func awakeFromNib() {
        newMovieImage.layer.cornerRadius = 12.0
        newMovieImage.clipsToBounds = true
        newMovieImage.contentMode = UIViewContentMode.scaleAspectFill

    }

   
}
