//
//  APIService.swift
//  BountyHunterSUI
//
//  Created by Ángel González on 15/11/23.
//

import Foundation

struct TodoItem: Identifiable, Codable {
    let id: Int
    let title: String
    let completed: Bool
}

enum APIError: Error{
    case invalidUrl, requestError, decodingError, statusNotOk
}

let BASE_URL: String = "https://jsonplaceholder.typicode.com"

struct APIService {
    
    func getTodos() async -> [TodoItem]? {
        do {
            guard let url = URL(string:  "\(BASE_URL)/todos") else  { throw APIError.invalidUrl }
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw APIError.statusNotOk }
            guard let result = try? JSONDecoder().decode([TodoItem].self, from: data) else {
                throw APIError.decodingError
            }
            return result
        }
        catch APIError.invalidUrl {
            print("There was an error creating the URL")
        }
        catch APIError.requestError {
            print("Did not get a valid response")
        }
        catch APIError.statusNotOk {
            print("Did not get a 2xx status code from the response")
        }
        catch APIError.decodingError {
            print("Failed to decode response into the given type")
        }
        catch {
            print("An error occured downloading the data")
        }
        return nil
    }
    
}
