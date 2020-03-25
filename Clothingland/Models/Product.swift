//
//  Product.swift
//  Clothingland
//
//  Created by Luis Segoviano on 24/03/20.
//  Copyright © 2020 Luis Segoviano. All rights reserved.
//

import Foundation

struct Product {
    
    var modelId: String = ""
    var name: String = ""
    var type: String = ""
    var sku: String = ""
    var description: String = ""
    var url: String = ""
    var color: String = ""
    var composition: String = ""
    var care: String = ""
    var originalPrice: Int = 0
    var finalPrice: Int = 0
    var finalPriceType: String = ""
    var currency: String = ""
    var images: [String] = []
    var sizes: [Size] = []
    
    init(productObjectDict: Dictionary<String, Any>) {
        if let modelId = productObjectDict["modelId"] as? String {
            self.modelId = modelId
        }
        if let name = productObjectDict["name"] as? String {
            self.name = name
        }
        if let type = productObjectDict["type"] as? String {
            self.type = type
        }
        if let sku = productObjectDict["sku"] as? String {
            self.sku = sku
        }
        if let description = productObjectDict["description"] as? String {
            self.description = description
        }
        if let url = productObjectDict["url"] as? String {
            self.url = url
        }
        if let color = productObjectDict["color"] as? String {
            self.color = color
        }
        if let composition = productObjectDict["composition"] as? String {
            self.composition = composition
        }
        if let care = productObjectDict["care"] as? String {
            self.care = care
        }
        if let originalPrice = productObjectDict["originalPrice"] as? Int {
            self.originalPrice = originalPrice
        }
        if let finalPrice = productObjectDict["finalPrice"] as? Int {
            self.finalPrice = finalPrice
        }
        if let finalPriceType = productObjectDict["finalPriceType"] as? String {
            self.finalPriceType = finalPriceType
        }
        if let currency = productObjectDict["currency"] as? String {
            self.currency = currency
        }
        if let images = productObjectDict["images"] as? [String] {
            self.images = images
        }
        if let sizes = productObjectDict["sizes"] as? [Dictionary<String, Any>] {
            for s in sizes {
                let newSize = Size(sizeObjectArray: s)
                self.sizes.append(newSize)
            }
        }
    }
    
}


struct Size {
    
    var variantId: String = ""
    var name: String = ""
    var stockQty: Int = 0
    
    init(sizeObjectArray: Dictionary<String, Any>) {
        if let variantId = sizeObjectArray["variantId"] as? String {
            self.variantId = variantId
        }
        if let name = sizeObjectArray["name"] as? String {
            self.name = name
        }
        if let stockQty = sizeObjectArray["stockQty"] as? Int {
            self.stockQty = stockQty
        }
    }
    
}
