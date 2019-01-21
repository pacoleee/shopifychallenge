//
//  Service.swift
//  Shopify
//
//  Created by Paco Lee on 2019-01-20.
//  Copyright © 2019 Paco Lee. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import SwiftyJSON

class Service {
    static let sharedService = Service()
    
    func getCustomCollections(completion: @escaping (Result<[Collection]>) -> Void) {
        APIClient.sharedClient.request(Router.getCustomCollections()) { (response) in
            switch response {
            case .success(let result):
                let jsonResult = result as? [String: Any]
                if let jsonResult = jsonResult, let json = jsonResult["custom_collections"] as? [[String: Any]] {
                    let collections = Mapper<Collection>().mapArray(JSONArray: json)
                    completion(Result.success(collections))
                }
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
    
    func getCollects(collectionID: Int, completion: @escaping (Result<[Collect]>) -> Void) {
        APIClient.sharedClient.request(Router.getCollects(collectionID: collectionID)) { (response) in
            switch response {
            case .success(let result):
                
                let jsonResult = result as? [String: Any]
                if let jsonResult = jsonResult, let json = jsonResult["collects"] as? [[String: Any]] {
                    let collects = Mapper<Collect>().mapArray(JSONArray: json)
                    completion(Result.success(collects))
                } else {
                    print("failure")
                }
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
    
    func getProducts(collects: [Collect], completion: @escaping (Result<[Product]>) -> Void) {
        var productIDs = [Int]()
        
        for collect in collects {
            if let productID = collect.productID {
                productIDs.append(productID)
            }
        }
        
        APIClient.sharedClient.request(Router.getProducts(productIDs: productIDs)) { (response) in
            switch response {
            case .success(let result):
                let jsonResult = result as? [String: Any]
                if let jsonResult = jsonResult, let json = jsonResult["products"] as? [[String: Any]] {
                    let products = Mapper<Product>().mapArray(JSONArray: json)
                    completion(Result.success(products))
                }
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
}

