//
//  Delegate.swift
//  Drom
//
//  Created by Vadim Voronkov on 19.06.2022.
//

import Foundation
import UIKit

extension MainVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.5) {
            if let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell { cell.image.center.x += ScreenSize.width / 1 - 10 }
        } completion: { Bool in
            ImageModel.images.remove(at: indexPath.row)
            collectionView.deleteItems(at: [indexPath])
            collectionView.reloadData()
            if indexPath.row <= 3 {
                self.presenter?.fetchData()
            }
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.presenter?.fetchData()
    }
    
}
