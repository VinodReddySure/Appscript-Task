//
//  BannerHeaderView.swift
//  Task
//
//  Created by Vinod Reddy Sure on 17/12/20.
//  Copyright © 2020 Vinod Reddy Sure. All rights reserved.
//

import Foundation
import UIKit

class BannerHeaderView: UITableViewHeaderFooterView {
    
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
}

extension BannerHeaderView {
    
    func initialLoads() {
        
    }
}
