//
//  PhotoCollectViewCell.swift
//  PorscheDemo
//
//  Created by Peter Liaw on 9/17/22.
//

import Foundation
import UIKit

/**
 View for each cell in the photo collection view
 */
class PhotoCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = String(describing: PhotoCollectionViewCell.self)

    /// car image
    let imageView = UIImageView()
    /// description
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isHighlighted: Bool {
        didSet {
            // shrink image when depressed
            shrink(down: isHighlighted)
        }
      }
    
    func initialize() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        contentView.addSubview(imageView)
        let imageTop = NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1.0, constant: 0)
        let imageBottom = NSLayoutConstraint(item: imageView, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1.0, constant: -30)
        let imageLeading = NSLayoutConstraint(item: imageView, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1.0, constant: 0)
        let imageTrailing = NSLayoutConstraint(item: imageView, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1.0, constant: 0)
        NSLayoutConstraint.activate([imageTop, imageBottom, imageLeading, imageTrailing])

        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        let labelLeading = NSLayoutConstraint(item: label, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1.0, constant: 10)
        let labelBottom = NSLayoutConstraint(item: label, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: -10)
        let labelTrailing = NSLayoutConstraint(item: label, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: -10)
        NSLayoutConstraint.activate([labelLeading, labelBottom, labelTrailing])
    }
    
    
}
