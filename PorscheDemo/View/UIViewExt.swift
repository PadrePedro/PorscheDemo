//
//  ViewExt.swift
//  PorscheDemo
//
//  Created by Peter Liaw on 9/18/22.
//

import Foundation
import UIKit

extension UIView {
    
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
}
