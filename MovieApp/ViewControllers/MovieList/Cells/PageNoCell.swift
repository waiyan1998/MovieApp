//
//  TitleCell.swift
//  MovieApp
//
//  Created by Wai Yan Pyae Sone on 11/12/23.
//

import UIKit

class PageNoCell : UICollectionViewCell {
    
    @IBOutlet weak var TitleLabel : UILabel!
    

    override var isSelected: Bool {
        didSet{
            if isSelected {
                self.TitleLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
                self.layer.borderColor = UIColor.blue.cgColor
                self.TitleLabel.textColor = .white
                self.backgroundColor = UIColor.blue
                self.layer.layoutIfNeeded()
            }else{
                self.TitleLabel.font = UIFont.systemFont(ofSize: 11, weight: .regular)
                self.layer.borderColor = UIColor.black.cgColor
                self.TitleLabel.textColor = .black
                self.backgroundColor = .white
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.TitleLabel.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        self.TitleLabel.textColor = .black
        self.layer.cornerRadius = 2
        self.backgroundColor  = .white
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 0.5
        
        // Initialization code
    }

}
