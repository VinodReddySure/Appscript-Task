//
//  CustomHeaderView.swift
//  Task
//
//  Created by Vinod Reddy Sure on 18/12/20.
//  Copyright © 2020 Vinod Reddy Sure. All rights reserved.
//

import Foundation
import UIKit

class CustomHeaderView: UITableViewHeaderFooterView {
    @IBOutlet weak var backGroundView: UIView!
    @IBOutlet weak var labelSectionTitle: UILabel!
    
    var onTapHeader : (()->Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        initialLoads()
    }
}


extension CustomHeaderView {
    
    func initialLoads() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.onTapSectionHeader))
        backGroundView.addGestureRecognizer(tap)
    }
    
    @IBAction func onTapSectionHeader() {
        self.onTapHeader?()
    }
}
