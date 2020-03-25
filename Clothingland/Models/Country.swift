//
//  Country.swift
//  Clothingland
//
//  Created by Luis Segoviano on 24/03/20.
//  Copyright © 2020 Luis Segoviano. All rights reserved.
//

import Foundation

struct Country {
    
    var name: String = ""
    var countryCode: String = ""
    var storeCode: String = ""
    var websiteCode: String = ""
    var storeViews: [StoreViews] = []
    
    init(countryDictionary:Dictionary<String, Any>) {
        if let name = countryDictionary["name"] as? String {
            self.name = name
        }
        
        if let countryCode = countryDictionary["countryCode"] as? String {
            self.countryCode = countryCode
        }
        
        if let storeCode = countryDictionary["storeCode"] as? String {
            self.storeCode = storeCode
        }
        
        if let websiteCode = countryDictionary["websiteCode"] as? String {
            self.websiteCode = websiteCode
        }
        
        if let storeViews = countryDictionary["storeViews"] as? [Dictionary<String, Any>] {
            //self.storeViews = storeViews
            for sv in storeViews {
                self.storeViews.append(StoreViews(storeViewsDictionary: sv))
            }
        }
        
    }
}


struct StoreViews {
    
    var name: String = ""
    var storeId: Int = 0
    
    init(storeViewsDictionary:Dictionary<String, Any>){
        
        if let name = storeViewsDictionary["name"] as? String {
            self.name = name
        }
        
        if let storeId = storeViewsDictionary["storeId"] as? Int {
            self.storeId = storeId
        }
        
    }
}
