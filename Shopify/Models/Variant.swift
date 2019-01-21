//
//  Variant.swift
//  Shopify
//
//  Created by Paco Lee on 2019-01-21.
//  Copyright © 2019 Paco Lee. All rights reserved.
//

import Foundation
import ObjectMapper

class Variant: Mappable {
    
    var inventoryQuantity: Int?
    
    required public init?(map: Map) { }
    
    public func mapping(map: Map) {
        inventoryQuantity <- map["inventory_quantity"]
    }
}
