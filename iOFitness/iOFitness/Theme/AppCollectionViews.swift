//
//  AppCollectionViews.swift
//  iOFitness
//
//  Created by ShitOS on 2023-05-30.
//

import UIKit

class AppCollectionViews {
    
    static func workoutLevelCardCollection(registerClass: AnyClass, cellIdentifier: String) -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(registerClass, forCellWithReuseIdentifier: cellIdentifier)
        return collectionView
    }
    
    static func workoutCardCollection(registerClass: AnyClass, cellIdentifier: String) -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(registerClass, forCellWithReuseIdentifier: cellIdentifier)
        return collectionView
    }
    
}
