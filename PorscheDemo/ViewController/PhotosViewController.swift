//
//  PhotosViewController.swift
//  PorscheDemo
//
//  Created by Peter Liaw on 9/17/22.
//

import Foundation
import UIKit

/**
 Main view controller for app.  Displays UICollectionView of photos
 */
class PhotosViewController: UICollectionViewController {
    
    enum Section {
        case first
    }
    
    /// view model managing data to be displayed
    var viewModel = PhotosViewModel(dataService: UnsplashDataService())
    
    /// UICollectionView diffable datasource
    lazy var dataSource = createDataSource()
    
    /// search bar controller
    var searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        viewModel.photos.bind { _ in
            // when photos get updated, recreate snapshot
            self.createSnapshot()
        }
        // load data from data service
        viewModel.getPhotos()
    }
    
    override var prefersStatusBarHidden: Bool {
        // hide status bar
        true
    }
    
    func setup() {
        collectionView.backgroundColor = UIColor(named: "appBackground")
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.reuseId)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }

    func createDataSource() -> UICollectionViewDiffableDataSource<Section,PhotoData> {
      let ds = UICollectionViewDiffableDataSource<Section,PhotoData>(collectionView: collectionView) { collectionView, indexPath, photo in
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.reuseId, for: indexPath) as? PhotoCollectionViewCell
          cell?.label.text = photo.desc
          ImageLoader.shared.loadImage(url: photo.urls.small) { result in
              switch result {
              case .success(let image):
                  DispatchQueue.main.async {
                      cell?.imageView.image = image
                  }
              case .failure(let error):
                  print(error.localizedDescription)
              }
          }
        return cell
      }
      return ds
    }
    
    func createSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, PhotoData>()
        snapshot.appendSections([.first])
        snapshot.appendItems(viewModel.photos.value)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    static func getLayout() -> UICollectionViewLayout {
      return UICollectionViewCompositionalLayout(sectionProvider: { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
        let isPhone = layoutEnvironment.traitCollection.userInterfaceIdiom == UIUserInterfaceIdiom.phone
        let size = NSCollectionLayoutSize(
            widthDimension: NSCollectionLayoutDimension.fractionalWidth(1),
          heightDimension: NSCollectionLayoutDimension.absolute(isPhone ? 280 : 240)
        )
        let itemCount = isPhone ? 1 : 3
        let item = NSCollectionLayoutItem(layoutSize: size)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitem: item, count: itemCount)
          group.interItemSpacing = .fixed(10)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        section.interGroupSpacing = 10
        return section
      })
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
      super.viewWillTransition(to: size, with: coordinator)
      coordinator.animate(alongsideTransition: { context in
        self.collectionView.collectionViewLayout.invalidateLayout()
      }, completion: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = viewModel.photos.value[indexPath.row]
        let vc = PhotoDetailViewController()
        vc.photoData = photo
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        navigationController?.pushViewController(vc, animated: true)
    }
}



extension PhotosViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.filterPhotos(query: searchController.searchBar.text)
    }
}
