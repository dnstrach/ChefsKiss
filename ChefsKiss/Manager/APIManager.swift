//
//  APIManager.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 3/14/24.
//

import Foundation

// print error strings for each case??
// how to access strings?
enum APIError: String, Error {
    case invalidURL
    case invalidResponse
    case exceededCallLimit = "Exceeded daily limit of network calls."
    case unableToDecode
}

struct APIManager {
    private static let apiKey = "18687e4b26fb4529b62e13351861d9eb"
 
    static func loadRecipes(searchTerm: SearchTerm) async throws -> [APIRecipe] {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.spoonacular.com"
        components.path = "/recipes/complexSearch"
        components.queryItems = [
            URLQueryItem(name: "apiKey", value: "\(apiKey)"),
            URLQueryItem(name: "addRecipeInformation", value: "true"),
            URLQueryItem(name: "instructionsRequired", value: "true"),
            URLQueryItem(name: "number", value: "100"),
            URLQueryItem(name: "\(searchTerm.searchParam)", value: "\(searchTerm.searchValue)")
        ]
        
//        if !query.isEmpty {
//            components.queryItems?.append(URLQueryItem(name: "query", value: query))
//        }

        guard let url = components.url else {
            throw APIError.invalidURL

        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let response = response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }
            
            guard response.statusCode == 200 else {
                if response.statusCode == 402 {
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
    
    static func loadSearchRecipes(query: String) async throws -> [APIRecipe] {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.spoonacular.com"
        components.path = "/recipes/complexSearch"
        components.queryItems = [
            URLQueryItem(name: "apiKey", value: "\(apiKey)"),
            URLQueryItem(name: "addRecipeInformation", value: "true"),
            URLQueryItem(name: "instructionsRequired", value: "true"),
            URLQueryItem(name: "number", value: "100"),
            URLQueryItem(name: "query", value: query)
        ]

        guard let url = components.url else {
            throw APIError.invalidURL

        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let response = response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }
            
            guard response.statusCode == 200 else {
                if response.statusCode == 402 {
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
