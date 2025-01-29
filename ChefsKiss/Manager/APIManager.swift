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
    // raw value will be used for alert message
    case exceededCallLimit = "Exceeded daily limit of network calls."
    case unableToDecode
}

enum SearchTerm {
    // search recipe
    case query(String)
    // cuisine, meal type, diet, intolerance categories
    // ex: categoryParam(param: "cuisine", value: "Italian")
    case categoryParam(param: String, value: String)
}

struct APIManager {
    // chefskiss949702970   //$9
    private static let apiKey = "cce86962d1e94f68b85f3fad930d6ee6"
   // private static let urlCache = URLCache.shared

    static func loadRecipes(searchTerm: SearchTerm) async throws -> [APIRecipe] {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.spoonacular.com"
        components.path = "/recipes/complexSearch"
        components.queryItems = [
            URLQueryItem(name: "apiKey", value: "\(apiKey)"),
            URLQueryItem(name: "addRecipeInformation", value: "true"),
            URLQueryItem(name: "addRecipeInstructions", value: "true"),
            URLQueryItem(name: "number", value: "100")
        ]
        
        // endpoint values for search or category parameters
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
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            //
           // print(data.count)
           // print("Response data:", String(data: data, encoding: .utf8) ?? "")
            //
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }
            
            // status code 200 = OK Status
            guard httpResponse.statusCode == 200 else {
                // status 402 Payment Required
                if httpResponse.statusCode == 402 {
                    throw APIError.exceededCallLimit
                } else {
                    throw APIError.invalidResponse
                }
            }
            
            guard let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) else {
                throw APIError.unableToDecode
            }
            
            return decodedResponse.results
        } catch {
            throw(error)
        }
    }
}

