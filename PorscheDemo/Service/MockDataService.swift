//
//  MockDataService.swift
//  PorscheDemo
//
//  Created by Peter Liaw on 9/19/22.
//

import Foundation

/**
 Returns mock data returned from app bundle. This call is expected to succeed.
 */
class MockDataService: DataService {
    
    func getPhotos(query: String, page: Int, count: Int, completion: @escaping (Result<[PhotoData], Error>) -> Void) {
        
        DispatchQueue.main.async {
            
            
            if let fileURL = Bundle.main.url(forResource: "mockdata-\(page)", withExtension: "json"),
               // we found the file in our bundle!
               let fileContents = try? String(contentsOf: fileURL) {
                // we loaded the file into a string!
                if let data = try? JSONDecoder().decode(PhotoDataResponse.self, from: fileContents.data(using: .utf8)!) {
                    completion(Result.success(data.results))
                }
                else {
                    completion(Result.failure(NSError(domain: "can't parse", code: 0)))
                }
            }
            else {
                completion(Result.failure(NSError(domain: "can't load file", code: 0)))
            }
        }
    }
    
}
