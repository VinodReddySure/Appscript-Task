//
//  Common.swift
//  Task
//
//  Created by Vinod Reddy Sure on 18/12/20.
//  Copyright © 2020 Vinod Reddy Sure. All rights reserved.
//

import Foundation

struct Section {
  var name: String!
  var items: [String]!
  var collapsed: Bool!

  init(name: String, items: [String]) {
    self.name = name
    self.items = items
    self.collapsed = false
  }
}

struct Banner {
    var name: String!
    var image: String!
    var description: String!
    var price : String!
    var selected: Bool!

    init(name: String, image: String, description:String, price:String) {
        self.name = name
        self.image = image
        self.description = description
        self.price = price
        self.selected = false
    }
}
