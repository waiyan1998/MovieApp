//
//  HeaderViewCell.swift
//  MovieApp
//
//  Created by Wai Yan Pyae Sone on 11/12/23.
//

import UIKit

class HeaderViewCell: UICollectionViewCell {
    @IBOutlet weak var PosterImageView: UIImageView!
    @IBOutlet weak var BackPosterImageView: UIImageView!
    @IBOutlet weak var width: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.width.constant = UIScreen.main.bounds.width - 50
    }

}
