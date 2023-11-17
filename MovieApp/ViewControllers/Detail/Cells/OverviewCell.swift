//
//  OverviewCell.swift
//  MovieApp
//
//  Created by Wai Yan Pyae Sone on 11/12/23.
//

import UIKit

class OverviewCell: UICollectionViewCell {
    
    @IBOutlet weak var TextView : UITextView!
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
