//
//  ProductListFlowLayout.swift
//  BongoMovie
//
//  Created by mac 2019 on 03/11/2022.
//

import UIKit

class TopRatedMoviesFlowLayout: UICollectionViewCompositionalLayout {

    convenience init() {
        self.init { sectionIndex, environment in
            return TopRatedMoviesFlowLayout.generateLayout()
        }
    }
    
    private static func generateLayout() -> NSCollectionLayoutSection {
        let isPhone = AppManager.shared.isPhone
        let fullPhotoItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(isPhone ? 1 : 1),
                heightDimension: .fractionalHeight(1.0)))
        fullPhotoItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        let fullGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(180.s)),
            subitem: fullPhotoItem,
            count: isPhone ? 1 : 1)
        
        let section = NSCollectionLayoutSection(group: fullGroup)
        return section
    }
}
