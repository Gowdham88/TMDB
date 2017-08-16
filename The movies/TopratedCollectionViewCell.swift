//
//  TopratedCollectionViewCell.swift
//  The movies
//
//  Created by Mac on 13/08/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class TopratedCollectionViewCell: UICollectionViewCell {
    

    @IBOutlet var topratedCollectionTitle: UILabel!
   
    @IBOutlet var topratedCollectionimage: UIImageView!

    override func awakeFromNib() {
        topratedCollectionimage.layer.cornerRadius = 12.0
        topratedCollectionimage.clipsToBounds = true
        topratedCollectionimage.contentMode = UIViewContentMode.scaleAspectFill

    }


}
