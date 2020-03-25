//
//  Category.swift
//  Clothingland
//
//  Created by Luis Segoviano on 24/03/20.
//  Copyright © 2020 Luis Segoviano. All rights reserved.
//

import Foundation

struct Category {
    
    var categoryId: String = ""
    var name: String = ""
    var children: [Category] = []
    
    init(categoriesArray: Dictionary<String, Any>) {
        if let categoryId = categoriesArray["categoryId"] as? String {
            self.categoryId = categoryId
        }
        
        if let name = categoriesArray["name"] as? String {
            self.name = name
        }
        
        if let children = categoriesArray["children"] as? [Dictionary<String, Any>] {
            for child in children {
                let newChild = Category(categoriesArray: child)
                self.children.append(newChild)
            }
        }
        
    }
    
}
