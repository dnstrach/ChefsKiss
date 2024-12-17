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
    // search recipe
    case query(String)
    // cuisine, meal type, diet, intolerance
    case categoryParam(param: String, value: String)
}

struct CachedResponseEntry {
    let response: CachedURLResponse
    let timestamp: Date
}

struct APIManager {
    private static let apiKey = "9df016c1df2e48ffb464d489cec9e760"
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
        
        // endpoint for search or category
        switch searchTerm {
        case let .query(queryValue):
            components.queryItems?.append(
                URLQueryItem(name: "query",
                             value: queryValue))
            
        case let .categoryParam(param, value):
            components.queryItems?.append(
                URLQueryItem(name: param,
                             value: value)
            )
        }

        guard let url = components.url else {
            throw APIError.invalidURL
        }
        
        let request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60.0)
        
        // checking if request is cached
        if let cachedResponse = cacheStorage[url] {
            // stores and loads api requests for 1 hour
            if Date().timeIntervalSince(cachedResponse.timestamp) < 3600 {
                return try JSONDecoder().decode(Response.self, from: cachedResponse.response.data).results
            } else {
                cacheStorage.removeValue(forKey: url)
            }
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            // print statements
//            print(data.count)
//            print("Response data:", String(data: data, encoding: .utf8) ?? "")
            //
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }
            
            // status code 200 = OK Status
            guard httpResponse.statusCode == 200 else {
                if httpResponse.statusCode == 402 {
                    throw APIError.exceededCallLimit
                } else {
                    throw APIError.invalidResponse
                }
            }
            
            guard let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) else {
                throw APIError.unableToDecode
            }
            
            // storing response
            let cachedResponse = CachedURLResponse(response: httpResponse, data: data)
            cacheStorage[url] = CachedResponseEntry(response: cachedResponse, timestamp: Date())
            
            return decodedResponse.results
        } catch {
            throw(error)
        }
    }
}

