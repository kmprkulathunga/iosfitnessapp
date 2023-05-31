//
//  AboutWorkoutViewExtension.swift
//  iOFitness
//
//  Created by ShitOS on 2023-05-31.
//

import UIKit


protocol WorkoutSelectionDelegate: AnyObject {
    func didSelectWorkout(cardModel: CardModel)
}

extension AboutWorkoutView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return workoutCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WorkoutCardCell", for: indexPath) as! WorkoutCardCell

        let card = workoutCards[indexPath.item]
        cell.configure(card: card)

        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Adjust the card size according to your needs
        let cardWidth = collectionView.frame.width
        // let cardHeight = collectionView.frame.height / 10
        return CGSize(width: cardWidth, height: 80)
    }
    
    // MARK: - Card Select
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCard = workoutCards[indexPath.item]
        selectionDelegate?.didSelectWorkout(cardModel: selectedCard)
    }
}
