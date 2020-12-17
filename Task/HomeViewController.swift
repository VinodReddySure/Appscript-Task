//
//  HomeViewController.swift
//  Task
//
//  Created by Vinod Reddy Sure on 17/12/20.
//  Copyright © 2020 Vinod Reddy Sure. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var productsTable : UITableView!

    var sections = [Section]()
    var banners = [Banner]()
    
    var bannersCollectionView: UICollectionView!

    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initialLoads()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }

}

extension HomeViewController {
    
    func initialLoads() {
        
        productsTable.register(UINib(nibName: "ItemTableViewCell", bundle: .main), forCellReuseIdentifier: "ItemTableViewCell")
        
        productsTable.register(UINib(nibName: "BannerHeaderView", bundle: .main), forHeaderFooterViewReuseIdentifier: "BannerHeaderView")
        productsTable.register(UINib(nibName: "CustomHeaderView", bundle: .main), forHeaderFooterViewReuseIdentifier: "CustomHeaderView")

        productsTable.separatorStyle = .none
        
        sections = [
          Section(name: "Pizza", items: ["Farm House", "Cheese Pizza", "Peppy Paneer"]),
          Section(name: "Burger", items: ["Cheeseburger", "Double Cheeseburger", "Quarter Pounder with Cheese"])
        ]
        
        banners = [Banner(name: "Cheeseburger", image: "banner_1", description: "A cheeseburger is a hamburger topped with cheese. Traditionally, the slice of cheese is placed on top of the meat patty.", price: "100"),
                   Banner(name: "Chicken sandwich", image: "banner_2", description: "A chicken sandwich is a sandwich that typically consists of boneless, skinless chicken breast served between slices of bread, with pickles, on a bun, or on a roll.", price: "100"),
                   Banner(name: "Chicken Roll", image: "banner_3", description: "Succulent pieces of spicy chicken cooked with freshly chopped onions and peppers, drizzled with a tangy cilantro mint chutney and rolled in soft flaky parathas", price: "100")]

    }
    
    func onTapSection(section : Int) {
        
        let collapsed = sections[section-1].collapsed

        // Toggle collapse
        sections[section-1].collapsed = !collapsed!

        // Reload section
        productsTable.reloadSections(IndexSet(integer: section), with: .automatic)

    }
}

extension HomeViewController : UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count + 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section != 0 {
            return sections[section-1].collapsed ? 0 : sections[section-1].items.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = productsTable.dequeueReusableCell(withIdentifier: "ItemTableViewCell", for: indexPath) as? ItemTableViewCell,indexPath.section != 0 {
            
            cell.labelItemName.text = sections[indexPath.section - 1].items[indexPath.row]
            cell.selectionStyle = .none
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if let headerView = self.productsTable.dequeueReusableHeaderFooterView(withIdentifier:"BannerHeaderView" ) as? BannerHeaderView,section == 0 {
            self.bannersCollectionView = headerView.bannerCollectionView
            self.bannersCollectionView.register(UINib(nibName: "BannerCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "BannerCollectionViewCell")

//            let layout = UICollectionViewFlowLayout()
//            layout.scrollDirection = .horizontal
//            layout.minimumInteritemSpacing = 10
//            layout.minimumLineSpacing = 10
//            headerView.bannerCollectionView.alwaysBounceHorizontal = false
//            headerView.bannerCollectionView.contentInset = UIEdgeInsets(top: 10, left: 5, bottom:10, right: 5)
            
            DispatchQueue.main.async {
                headerView.bannerCollectionView.delegate = self
                headerView.bannerCollectionView.dataSource = self
                headerView.bannerCollectionView.reloadData()
            }

            return headerView
        }else{
            let headerView = self.productsTable.dequeueReusableHeaderFooterView(withIdentifier:"CustomHeaderView" ) as! CustomHeaderView
            headerView.labelSectionTitle.text = sections[section - 1].name
            headerView.onTapHeader = {
                self.onTapSection(section: section)
            }
            return headerView
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0 {
            return self.view.frame.width * 0.7
        }
        return 45
    }
}

extension HomeViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.banners.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = self.bannersCollectionView.dequeueReusableCell(withReuseIdentifier: "BannerCollectionViewCell", for: indexPath) as? BannerCollectionViewCell {
            
            cell.bannerImage.image = UIImage(named: banners[indexPath.item].image)
            cell.bannerImage.contentMode = .scaleAspectFill

            cell.bannerImage.addSubview(cell.blurEffectView)

            if banners[indexPath.item].selected {
                cell.blurEffectView.alpha = 0.3
            }else{
                cell.blurEffectView.alpha = 0.0
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = self.storyboard?.instantiateViewController(identifier: "DetailsViewController") as! DetailsViewController
        vc.selectedBanner = banners[indexPath.item]
        vc.onTapSelection = { banner in
            
            print(banner.selected)
            self.banners[indexPath.item] = banner
            self.bannersCollectionView.reloadData()

        }
        self.navigationController?.pushViewController(vc, animated: true)
//        self.selectedIndex = indexPath.item
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.view.frame.width-10, height: self.bannersCollectionView.frame.height-10)

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }

}
