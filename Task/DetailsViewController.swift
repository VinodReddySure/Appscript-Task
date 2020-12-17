//
//  DetailsViewController.swift
//  Task
//
//  Created by Vinod Reddy Sure on 18/12/20.
//  Copyright © 2020 Vinod Reddy Sure. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var labelItemName: UILabel!
    @IBOutlet weak var buttonSelection: UIButton!
    @IBOutlet weak var labelDetails: UILabel!
    
    var selectedBanner : Banner!
    
    var onTapSelection : ((Banner)->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialLoads()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.title = "Details"
    }

}

extension DetailsViewController {
    
    func initialLoads() {
        itemImage.image = UIImage(named: selectedBanner.image)
        itemImage.contentMode = .scaleAspectFill
        labelItemName.text = selectedBanner.name
        labelDetails.text = "Description : \(selectedBanner.description ?? "")\n\nPrice : \(selectedBanner.price ?? "")"
        buttonSelection.addTarget(self, action: #selector(onClickSelection), for: .touchUpInside)
    }
    
    @IBAction func onClickSelection() {
        
        selectedBanner.selected = selectedBanner.selected != true
        
        self.onTapSelection?(self.selectedBanner)
        self.navigationController?.popViewController(animated: true)
    }
    
}
