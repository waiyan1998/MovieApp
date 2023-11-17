//
//  GenreCell.swift
//  MovieApp
//
//  Created by Wai Yan Pyae Sone on 11/12/23.
//

import UIKit

class GenreCell: UICollectionViewCell {
    @IBOutlet weak var Label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 15
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth  = 0.5
        // Initialization code
    }

}
