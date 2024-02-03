//
//  APIRequestDispatcher.swift
//  PokemonWorld
//
//  Created by Yaroslav Chlek on 24.01.2024.
//

import Foundation

class APIRequestDispatcher {
    class func request<T: Codable>(apiRouter: APIRouter, responseClass: T.Type) async throws -> T {
        var components = URLComponents()
        components.host = apiRouter.host
        components.scheme = apiRouter.scheme
        components.path = apiRouter.path
        components.queryItems = apiRouter.parameters
        
        guard let url = components.url else {throw APIRequestError.badUrl}
        
        dPrint("URL: \(url)")
        dPrint("queryItems: \(apiRouter.parameters)")
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = apiRouter.method
        
        let session = URLSession(configuration: .default)
        
        return try await withCheckedThrowingContinuation { continuation in
            let dataTask = session.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    dPrint("Error: \(error)")
                    return continuation.resume(with: .failure(error))
                }
                
                guard let data = data else {
                    dPrint("No Data")
                    return continuation.resume(with: .failure(APIRequestError.noData))
                }
                
                do {
                    if let jsonString = String(data: data, encoding: .utf8) {
                                dPrint(jsonString)
                    }
                    let responseObject = try JSONDecoder().decode(T.self, from: data)
                    dPrint("Response: \(responseObject)")
                    DispatchQueue.main.async {
                        return continuation.resume(with: .success(responseObject))
                    }
                } catch {
                    dPrint("Error: \(error)")
                    return continuation.resume(with: .failure(error))
                }
            }
            
            dataTask.resume()
        }
    }
    
    class func requestFromString<T: Codable>(stringUrl: String, responseClass: T.Type) async throws -> T {
        let url = URL(string: stringUrl)
        
        guard let url = url else {throw APIRequestError.badUrl}
        
        dPrint("URL: \(url)")
        
        let urlRequest = URLRequest(url: url)
        
        let session = URLSession(configuration: .default)
        
        return try await withCheckedThrowingContinuation { continuation in
            let dataTask = session.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    dPrint("Error: \(error)")
                    return continuation.resume(with: .failure(error))
                }
                
                guard let data = data else {
                    dPrint("No Data")
                    return continuation.resume(with: .failure(APIRequestError.noData))
                }
                
                do {
                    if let jsonString = String(data: data, encoding: .utf8) {
                                dPrint(jsonString)
                    }
                    let responseObject = try JSONDecoder().decode(T.self, from: data)
                    dPrint("Response: \(responseObject)")
                    DispatchQueue.main.async {
                        return continuation.resume(with: .success(responseObject))
                    }
                } catch {
                    dPrint("Error: \(error)")
                    return continuation.resume(with: .failure(error))
                }
            }
            
            dataTask.resume()
        }
    }
}
