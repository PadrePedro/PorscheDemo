//
//  ImageLoader.swift
//  PorscheDemo
//
//  Created by Peter Liaw on 9/18/22.
//

import Foundation
import UIKit

/**
 Simple ImageLoader utility class
 */
class ImageLoader {
    
    static let shared = ImageLoader()
    
    var cache = [String:UIImage]()
    
    func loadImage(url: String?, completion: @escaping (Result<UIImage,Error>)->Void) {
        print("loadImage")
        guard let url = url else {
            completion(Result.failure(NSError(domain: "No URL \(url)", code: 0)))
            return
        }
        guard let url = URL(string: url) else {
            completion(Result.failure(NSError(domain: "Invalid URL \(url)", code: 0)))
            return
        }
        URLSession.shared.dataTask(with: url) { data, resp, error in
            if let error = error {
                completion(Result.failure(error))
                return
            }
            if let data = data {
                if let image = UIImage(data: data) {
                    completion(Result.success(image))
                }
                else {
                    completion(Result.failure(NSError(domain: "Invalid image", code: 0)))
                }
            }
            else {
                completion(Result.failure(NSError(domain: "No data", code: 0)))
            }
        }.resume()
    }
}
