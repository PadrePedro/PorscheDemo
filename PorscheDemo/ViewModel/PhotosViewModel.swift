//
//  PhotosViewModel.swift
//  PorscheDemo
//
//  Created by Peter Liaw on 9/17/22.
//

import Foundation

class PhotosViewModel {
    
    var allPhotos = [PhotoData]()
    var photos = LiveData<[PhotoData]>([PhotoData]())
    var error = LiveData<String?>(nil)
    
    private var dataService: DataService
    
    init(dataService: DataService) {
        self.dataService = dataService
    }
    
    func getPhotos() {
        dataService.getPhotos(query: "Porsche Street Cars", count: 40) { result in
            switch result {
            case .success(let data):
                self.allPhotos = data
                self.photos.value = data
            case .failure(let error):
                self.error.value = error.localizedDescription
            }
        }
    }
    
    func filterPhotos(query: String?) {
        guard let query = query else {
            return
        }
        if query.isEmpty {
            self.photos.value = allPhotos
        }
        else {
            self.photos.value = allPhotos.filter({ data in
                data.desc?.lowercased().contains(query.lowercased()) ?? false
            })
        }
    }
}
