//
//  ViewExt.swift
//  PorscheDemo
//
//  Created by Peter Liaw on 9/18/22.
//

import Foundation
import UIKit

extension UIView {
    
    /**
     Shrink image with animation
     */
    func shrink(down: Bool) {
      UIView.animate(withDuration: 0.3) {
        if down {
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }
        else {
            self.transform = .identity
        }
      }
    }
    
    /**
     Add shadow effect
     */
    func addShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        layer.shadowRadius = 10
    }
}
