//
//  APIManager.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 3/14/24.
//

import Foundation

enum APIError: String, Error {
    case invalidURL
    case invalidResponse
    case exceededCallLimit = "Exceeded daily limit of network calls."
    case unableToDecode
}

enum SearchTerm {
    case query(String)
    case searchParam(param: String, value: String)
}

struct CachedResponseEntry {
    let response: CachedURLResponse
    let timestamp: Date
}

struct APIManager {
//     private static let apiKey = "d86e2105280b41c2bab075b22d45af54"
//     private static let apiKey = "c53944f6e54e40a48656945f4b29eb07"
     private static let apiKey = "3f6a72d40dfe481bbd6a747499faaa2f"
    
    private static let urlCache = URLCache.shared
    private static var cacheStorage: [URL: CachedResponseEntry] = [:]

    static func loadRecipes(searchTerm: SearchTerm) async throws -> [APIRecipe] {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.spoonacular.com"
        components.path = "/recipes/complexSearch"
        components.queryItems = [
            URLQueryItem(name: "apiKey", value: "\(apiKey)"),
            URLQueryItem(name: "addRecipeInformation", value: "true"),
            // instructionsRequired
            URLQueryItem(name: "addRecipeInstructions", value: "true"),
            URLQueryItem(name: "number", value: "100")
        ]
        
        switch searchTerm {
        case let .query(queryValue):
            components.queryItems?.append(
                URLQueryItem(name: "query",
                             value: queryValue))
            
        case let .searchParam(param, value):
            components.queryItems?.append(
                URLQueryItem(name: param,
                             value: value)
            )
        }

        guard let url = components.url else {
            throw APIError.invalidURL
        }
        
        let request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60.0)
        
        if let cachedEntry = cacheStorage[url] {
            if Date().timeIntervalSince(cachedEntry.timestamp) < 3600 {
                return try JSONDecoder().decode(Response.self, from: cachedEntry.response.data).results
            } else {
                cacheStorage.removeValue(forKey: url)
            }
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            print(data.count)
            print("Response data:", String(data: data, encoding: .utf8) ?? "")
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }
            
            guard httpResponse.statusCode == 200 else {
                if httpResponse.statusCode == 402 {
                    throw APIError.exceededCallLimit
                } else {
                    throw APIError.invalidResponse
                }
            }
            
            let cachedResponse = CachedURLResponse(response: httpResponse, data: data)
            cacheStorage[url] = CachedResponseEntry(response: cachedResponse, timestamp: Date())
            
            guard let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) else {
                throw APIError.unableToDecode
            }
            
            return decodedResponse.results
        } catch {
            if let cachedEntry = cacheStorage[url] {
                if Date().timeIntervalSince(cachedEntry.timestamp) < 3600 {
                    return try JSONDecoder().decode(Response.self, from: cachedEntry.response.data).results
                }
            }
            throw(error)
        }
    }
}

