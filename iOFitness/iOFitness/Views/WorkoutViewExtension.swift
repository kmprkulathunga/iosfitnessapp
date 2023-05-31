//
//  WorkoutViewExtension.swift
//  iOFitness
//
//  Created by ShitOS on 2023-05-30.
//

import UIKit


protocol WorkoutLevelSelectionDelegate: AnyObject {
    func didSelectWorkout(cardModel: CardModel)
}

extension WorkoutsView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewAbs {
            return absWorkoutCards.count
        } else if collectionView == collectionViewChest {
            return chestWorkoutCards.count
        } else if collectionView == collectionViewArm {
            return armWorkoutCards.count
        } else if collectionView == collectionViewLeg {
            return legWorkoutCards.count
        } else if collectionView == collectionViewShoulderNBack {
            return shoulderNBackWorkoutCards.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WorkoutLevelCardCell", for: indexPath) as! WorkoutLevelCardCell
        
        if collectionView == collectionViewAbs {
            let card = absWorkoutCards[indexPath.item]
            cell.configure(card: card)
        } else if collectionView == collectionViewChest {
            let card = chestWorkoutCards[indexPath.item]
            cell.configure(card: card)
        } else if collectionView == collectionViewArm {
            let card = armWorkoutCards[indexPath.item]
            cell.configure(card: card)
        } else if collectionView == collectionViewLeg {
            let card = legWorkoutCards[indexPath.item]
            cell.configure(card: card)
        } else if collectionView == collectionViewShoulderNBack {
            let card = shoulderNBackWorkoutCards[indexPath.item]
            cell.configure(card: card)
        }
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Adjust the card size according to your needs
        let cardWidth = collectionView.frame.width * 0.7
        let cardHeight = collectionView.frame.height
        return CGSize(width: cardWidth, height: cardHeight)
    }
    
    // MARK: - Card Select
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var selectedCard: CardModel?
        if collectionView == collectionViewAbs {
            selectedCard = absWorkoutCards[indexPath.item]
        } else if collectionView == collectionViewChest {
            selectedCard = chestWorkoutCards[indexPath.item]
        } else if collectionView == collectionViewArm {
            selectedCard = armWorkoutCards[indexPath.item]
        } else if collectionView == collectionViewLeg {
            selectedCard = legWorkoutCards[indexPath.item]
        } else if collectionView == collectionViewShoulderNBack {
            selectedCard = shoulderNBackWorkoutCards[indexPath.item]
        }
        
        if let cardModel = selectedCard {
            selectionDelegate?.didSelectWorkout(cardModel: cardModel)
        }
    }
}
