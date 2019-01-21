//
//  Product.swift
//  Shopify
//
//  Created by Paco Lee on 2019-01-20.
//  Copyright © 2019 Paco Lee. All rights reserved.
//

import Foundation
import ObjectMapper

class Product: Mappable {
    
    var id: Int?
    var title: String?
    var image: Image?
    var variants: [Variant]?
    
    required public init?(map: Map) { }
    
    public func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        image <- map["image"]
        variants <- map["variants"]
    }
}
