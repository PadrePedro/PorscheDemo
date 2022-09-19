//
//  PhotosViewModel.swift
//  PorscheDemo
//
//  Created by Peter Liaw on 9/17/22.
//

import Foundation

/**
 Photos View Model
 */
class PhotosViewModel {

    /// photos to display, could be subset of allPhotos if user entered search phrase
    var photos = LiveData<[PhotoData]>([PhotoData]())
    /// error to display, if any
    var error = LiveData<String?>(nil)

    /// all photos retrieved
    private var allPhotos = [PhotoData]()

    /// DataService object
    private var dataService: DataService
    
    /**
     Create View Model with given injected data service
     */
    init(dataService: DataService) {
        self.dataService = dataService
    }
    
    func getPhotos() {
        let pageCount = 20
        let page = (self.allPhotos.count / pageCount) + 1
        dataService.getPhotos(query: "Porsche Vehicles", page: page, count: pageCount) { result in
            switch result {
            case .success(let data):
                self.allPhotos += data
                self.photos.value = self.allPhotos
                if self.allPhotos.count < 100 {
                    self.getPhotos()
                }
            case .failure(let error):
                self.error.value = error.localizedDescription
            }
        }
    }
    
    /**
     Filter all photos with given query string.
     */
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
