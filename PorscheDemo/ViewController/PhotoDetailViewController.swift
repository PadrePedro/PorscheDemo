//
//  PhotoDetailViewController.swift
//  PorscheDemo
//
//  Created by Peter Liaw on 9/18/22.
//

import Foundation
import UIKit
import SafariServices

/**
 Shows details of one photo
 */
class PhotoDetailViewController: UIViewController {
    
    let descriptionLabel = UILabel()
    let sizeLabel = UILabel()
    let photographerLabel = UILabel()
    let shareButton = UIButton()
    let imageView = UIImageView()
    let profileImageView = UIImageView()
    
    var photoData: PhotoData!
    
    let margin = 20.0
    let smallMargin = 10.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        loadImages()
        
        descriptionLabel.text = photoData.desc
        sizeLabel.text = photoData.getSize()
        photographerLabel.text = photoData.getUserInfo()
    }
    
    override var prefersStatusBarHidden: Bool {
        // hide status bar
        true
    }
    
    func setup() {
        view.backgroundColor = UIColor(named: "appBackground")
        
        // photographer image
        view.addSubview(profileImageView)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -margin).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        profileImageView.layer.cornerRadius = photoData.user.portfolio_url == nil ? 15 : 25
        profileImageView.clipsToBounds = true
        profileImageView.isUserInteractionEnabled = true
        profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(profileImageTapped(_:))))
        profileImageView.addShadow()

        view.addSubview(photographerLabel)
        photographerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        photographerLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: smallMargin).isActive = true
        photographerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: margin).isActive = true
        photographerLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor).isActive = true
        
        // size info
        view.addSubview(sizeLabel)
        sizeLabel.translatesAutoresizingMaskIntoConstraints = false
        sizeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin).isActive = true
        sizeLabel.bottomAnchor.constraint(equalTo: profileImageView.topAnchor, constant: -margin).isActive = true

        // description
        view.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: sizeLabel.topAnchor, constant: -smallMargin).isActive = true
        descriptionLabel.numberOfLines = 0

        // car image view
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -margin).isActive = true
        imageView.clipsToBounds = true
        
        // share button
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(shareButton)
        shareButton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        shareButton.addTarget(self, action: #selector(share(_:)), for: .touchUpInside)
        shareButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin).isActive = true
        shareButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -margin).isActive = true
    }
    
    func loadImages() {
        // load photo image
        ImageLoader.shared.loadImage(url: photoData.urls.full) { [weak self] result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self?.imageView.alpha = 0
                    self?.imageView.image = image
                    UIView.animate(withDuration: 0.6) {
                        self?.imageView.alpha = 1
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
        // load user profile image
        ImageLoader.shared.loadImage(url: photoData.getProfileImage()) { [weak self] result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self?.profileImageView.image = image
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    /**
     Handle tapping of profile image link to user portfolio website, if any
     */
    @objc func profileImageTapped(_ sender: UIView) {
        if let urlString = photoData.user.portfolio_url,
           let url = URL(string: urlString) {
            let vc = SFSafariViewController(url: url)
            present(vc, animated: true)
        }
    }
    
    /**
     Handle share functionality for image
     */
    @objc func share(_ sender: UIView) {
        if let image = imageView.image {
            let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
            vc.modalPresentationStyle = .popover
            vc.popoverPresentationController?.sourceView = sender
            present(vc, animated: true)
        }
    }
}

extension PhotoData {
    func getUserInfo() -> String {
        let name = user.name ?? "Unknown"
        let location = user.location ?? "Unknown"
        return "\(name) - \(location)"
    }
    
    func getProfileImage() -> String? {
        return user.profile_image?.large
    }
    
    func getSize() -> String? {
        return "\(width) x \(height)"
    }
}
