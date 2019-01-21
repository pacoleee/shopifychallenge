//
//  Image.swift
//  Shopify
//
//  Created by Paco Lee on 2019-01-20.
//  Copyright © 2019 Paco Lee. All rights reserved.
//

import Foundation
import ObjectMapper

class Image: Mappable {
    
    var src: String?
    
    required public init?(map: Map) { }
    
    public func mapping(map: Map) {
        src <- map["src"]
    }
    
}
