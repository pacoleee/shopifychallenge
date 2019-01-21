//
//  Collect.swift
//  Shopify
//
//  Created by Paco Lee on 2019-01-20.
//  Copyright © 2019 Paco Lee. All rights reserved.
//

import Foundation
import ObjectMapper

class Collect: Mappable {
    
    var id: Int?
    var collectionID: String?
    var productID: Int?
    
    required public init?(map: Map) { }
    
    public func mapping(map: Map) {
        id <- map["id"]
        collectionID <- map["collection_id"]
        productID <- map["product_id"]
    }
    
}
