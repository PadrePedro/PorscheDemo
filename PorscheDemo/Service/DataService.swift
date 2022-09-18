//
//  DataService.swift
//  PorscheDemo
//
//  Created by Peter Liaw on 9/17/22.
//

import Foundation

protocol DataService {
    func getPhotos(query: String, count: Int, completion: @escaping (Result<[PhotoData],Error>)->Void)
}
