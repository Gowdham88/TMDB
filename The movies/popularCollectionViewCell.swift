//
//  popularCollectionViewCell.swift
//  The movies
//
//  Created by Mac on 13/08/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class popularCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var popularLabel: UILabel!
    
    @IBOutlet var popularImage: UIImageView!

    override func awakeFromNib() {
        popularImage.layer.cornerRadius = 12.0
        popularImage.clipsToBounds = true
        popularImage.contentMode = UIViewContentMode.scaleAspectFill

    }


}
