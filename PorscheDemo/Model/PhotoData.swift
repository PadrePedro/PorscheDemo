//
//  PhotoData.swift
//  PorscheDemo
//
//  Created by Peter Liaw on 9/17/22.
//

import Foundation

struct PhotoDataResponse: Decodable {
    let results: [PhotoData]
}
struct PhotoData: Decodable, Hashable {
    static func == (lhs: PhotoData, rhs: PhotoData) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id: String
    let description: String?
    let alt_description: String?
    let urls: URLS
    
    var desc: String? {
        get {
            description ?? alt_description
        }
    }
}

struct URLS: Decodable {
    let thumb: String?
    let small: String?
    let full: String?
}
