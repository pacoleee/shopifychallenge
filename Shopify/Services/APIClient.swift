//
//  APIClient.swift
//  Shopify
//
//  Created by Paco Lee on 2019-01-20.
//  Copyright © 2019 Paco Lee. All rights reserved.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    
    static let baseURLString = "https://shopicruit.myshopify.com/admin"
    
    // Instructor
    case getCustomCollections()
    case getCollects(collectionID: Int)
    case getProducts(productIDs: [Int])

    
    var method: HTTPMethod {
        switch self {
        case .getCustomCollections, .getCollects, .getProducts:
            return .get
        }
    }
    
    var accessToken: String {
        return "access_token=c32313df0d0ef512ca64d5b336a0d7c6"
    }
    
    // MARK: URLRequestConvertible
    
    func asURLRequest() throws -> URLRequest {
        let url = try Router.baseURLString.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(""))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .getCustomCollections():
            urlRequest.url = URL(string: "\(Router.baseURLString)/custom_collections.json?page=1&\(accessToken)")
        case .getCollects(let collectionID):
            urlRequest.url = URL(string: "\(Router.baseURLString)/collects.json?collection_id=\(collectionID)&\(accessToken)")
        case .getProducts(let productIDs):
            var urlString = "\(Router.baseURLString)/products.json?ids="
            for productID in productIDs  {
                urlString.append("\(productID),")
            }
            urlString.remove(at: urlString.index(before: urlString.endIndex))
            urlString.append("&page=1&\(accessToken)")
            urlRequest.url = URL(string: urlString)
        }
        
        return urlRequest
    }
}

class APIClient {
    
    static let sharedClient = APIClient()
    
    private let sessionManager: SessionManager
    
    init() {
        var defaultHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        
        defaultHeaders["Content-Type"] = ""
        defaultHeaders["Accept"] = "application/json"
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = defaultHeaders
        
        sessionManager = Alamofire.SessionManager(configuration: configuration)
    }
    
    func request(_ request: URLRequestConvertible, completion: @escaping (Result<Any>) -> Void) {
        sessionManager.request(request).validate().responseJSON { (response) in
            completion(response.result)
        }
    }
    
    func download(_ request: URLRequestConvertible, completion: @escaping (Result<Data>) -> Void) {
        sessionManager.download(request).validate().responseData{ response in
            completion(response.result)
        }
    }
    
    func upload(_ data: Data, fileName: String, mimeType: String, _ request: URLRequestConvertible, completion: @escaping (Result<Any>) -> Void) {
        sessionManager.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(data, withName: "file", fileName: fileName, mimeType: mimeType)
        },
            with:  request,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        completion(Result.success(response.result))
                    }
                case .failure(let encodingError):
                    completion(Result.failure(encodingError))
                }
        }
        )
    }
    
    
    // Utilities
    func checkSuccessHandler(response: Result<Any>, completion: @escaping (Result<Bool>) -> Void) {
        switch response {
        case .success:
            completion(Result.success(true))
        case .failure(let error):
            completion(Result.failure(error))
        }
    }
}

