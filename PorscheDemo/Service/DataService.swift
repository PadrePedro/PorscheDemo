//
//  DataService.swift
//  PorscheDemo
//
//  Created by Peter Liaw on 9/17/22.
//

import Foundation

/**
 DataService protocol
 */
protocol DataService {
    func getPhotos(query: String, page: Int, count: Int, completion: @escaping (Result<[PhotoData],Error>)->Void)
}
