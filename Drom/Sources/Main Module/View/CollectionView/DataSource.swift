//
//  DataSource.swift
//  Drom
//
//  Created by Vadim Voronkov on 19.06.2022.
//

import Foundation
import UIKit

extension MainVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ImageModel.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
        if let image = ImageModel.images[indexPath.row].image { cell.configureCell(image: image) }
        return cell
    }
    
}
