//
//  Request.swift
//  MovieShelf
//
//  Created by Levy Cristian on 12/12/19.
//  Copyright © 2019 Levy Cristian. All rights reserved.
//

import Foundation
/**
    Class Reponsible for managment of API request layer
*/
class Request<T: EndPointType>: NetworkProtocol {
    
    private var task: URLSessionTask?
    /**
        Method resposible for json decoder fom API
       - parameter route: Api route to EndPoint
       - parameter completion: A generic completion of `Result<T, Errors>` that sould be implemented for api result
       */
    func run<U: Decodable>(_ endPoint: T, completion: @escaping (Result<U, Errors>) -> Void) {
        let session = URLSession.shared
        
        var request = URLRequest(url: endPoint.url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30.0)
        request.httpMethod = HTTPMethod.get.rawValue
        
        self.task = session.dataTask(with: request, completionHandler: { (data, _, error) in
            guard let responseData = data, error == nil else {
                print("Request Error:", error!.localizedDescription)
                return DispatchQueue.main.async {completion(.failure(Errors.noInternet))}
            }
            
            do {
                let decodeObject = try JSONDecoder().decode(U.self, from: responseData)
                
                DispatchQueue.main.async {
                    completion(.success(decodeObject))
                }
            } catch {
                print("Decoding error:", error)
                DispatchQueue.main.async {completion(.failure(Errors.failRequest))}
            }
        })
        
        self.task?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
    }
    
}
/**
   Enum of possible API Erros
*/
enum Errors: Error {
    case invalidURL
    case failRequest
    case noInternet
    
    var localizedDescription: String {
        switch self {
        case .invalidURL: return "Invalid URL"
        case .failRequest: return "Applicantion cannot request external data"
        case .noInternet: return "The Internet connection appears to be offline"
            
        }
    }
}
