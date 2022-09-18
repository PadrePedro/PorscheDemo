//
//  RestDataService.swift
//  PorscheDemo
//
//  Created by Peter Liaw on 9/17/22.
//

import Foundation

enum QueryError: Error {
    case invalidUrl
}

class RestDataService: DataService {
    
    // demo access key for Unsplash
    let accessKey = "D3FC-fuM9zlJ0_KUxx3xiunKYobejLZ1gDx-Y2sGziY"
    
    func getPhotos(query: String, count: Int, completion: @escaping (Result<[PhotoData], Error>) -> Void) {
        let queryString = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let urlString = "https://api.unsplash.com/search/photos?query=\(queryString)&per_page=\(count)&client_id=\(accessKey)"
        guard let url = URL(string: urlString) else {
            completion(Result.failure(QueryError.invalidUrl))
            return
        }
        URLSession.shared.dataTask(with: url) { data, resp, error in
            if let error = error {
                completion(Result.failure(error))
                return
            }
            if let data = data {
                print(String(data: data, encoding: .utf8))
                do {
                    let resp = try JSONDecoder().decode(PhotoDataResponse.self, from: data)
                    completion(Result.success(resp.results))
                }
                catch {
                    completion(Result.failure(error))
                }
            }
            else {
                completion(Result.failure(NSError(domain: "No data", code: 0)))
            }
        }.resume()
    }
    
    
}
