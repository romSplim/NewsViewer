//
//  LayoutBuilder.swift
//  NewsViewer
//
//  Created by ramil on 22.06.2023.
//

import UIKit

final class LayoutBuilder {
    static func buildTopSectionLayout() -> NSCollectionLayoutSection {
    
        let itemSize: NSCollectionLayoutSize =
            .init(widthDimension: .fractionalWidth(1),
                  heightDimension: .fractionalHeight(1))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize: NSCollectionLayoutSize = .init(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(0.3))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        group.contentInsets = .init(top: 15,
                                    leading: 15,
                                    bottom: 20,
                                    trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        section.interGroupSpacing = 10
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
        
        let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        section.boundarySupplementaryItems = [headerItem]
        
        return section
    }
    
    static func buildLatestSectionLayout() -> NSCollectionLayoutSection {
        let height = NSCollectionLayoutDimension.estimated(100)

        let itemSize: NSCollectionLayoutSize =
            .init(widthDimension: .fractionalWidth(1),
                  heightDimension: height)
        //.fractionalHeight(1)
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize: NSCollectionLayoutSize = .init(widthDimension: .fractionalWidth(1), heightDimension: height)
        //.absolute(100)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                       subitems: [item])
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
        
        let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [headerItem]
        return section
    }
    
    
}
