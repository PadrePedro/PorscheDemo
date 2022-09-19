//
//  LiveData.swift
//  PorscheDemo
//
//  Created by Peter Liaw on 9/17/22.
//

import Foundation

/**
 To support MVVM, LiveData is used to wrap values that will notify listeners when udpated.
 */
class LiveData<T> {
    
    typealias Listener = (T)->Void
    var listener: Listener?
    
    var value: T {
        didSet {
            DispatchQueue.main.async {
                self.listener?(self.value)
            }
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(listener: Listener?) {
        self.listener = listener
    }
}
