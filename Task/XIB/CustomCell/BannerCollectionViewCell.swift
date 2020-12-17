//
//  BannerCollectionViewCell.swift
//  Task
//
//  Created by Vinod Reddy Sure on 18/12/20.
//  Copyright © 2020 Vinod Reddy Sure. All rights reserved.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bannerImage: UIImageView!
    var blurEffectView = UIVisualEffectView()

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.extraLight)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.contentView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.alpha = 0.3

    }

}
