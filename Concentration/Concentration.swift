//
//  Concentration.swift
//  Concentration
//
//  Created by aeronaut on 23.12.2017.
//  Copyright © 2017 aeronaut. All rights reserved.
//

import Foundation
import GameKit

class Concentration {
    
    private(set) var cards = [Card]()
    private(set) var flipCount = 0
    private(set) var scoreCount = 0
    
    private var indexOfOneAndOlnlyFaceUpCard: Int? {
        get {
            let faceUpCardIndecis = cards.indices.filter { cards[$0].isFaceUp }
            return faceUpCardIndecis.count == 1 ? faceUpCardIndecis.first : nil
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func choseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOlnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    scoreCount += 2
                } else {
                    scoreCount -= 1
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOlnlyFaceUpCard = index
            }
        }
        flipCount += 1
    }
    func resetGame() {
        flipCount = 0
        scoreCount = 0
    }
    
    init(numberOfPairsOfCards: Int) {
        var unshuffledCards = [Card]()
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            unshuffledCards += [card, card]
        }
        var usedIndexes = [Int]()
        for _ in 0..<unshuffledCards.count {
            let rand = returnUnusedIndex(numberOfIndexes: unshuffledCards.count, usedIndexes: usedIndexes)
            cards.append(unshuffledCards[rand])
            usedIndexes.append(rand)
        }
    }
    
    func returnUnusedIndex(numberOfIndexes: Int, usedIndexes: [Int]) -> Int {
        let index = Int(arc4random_uniform(UInt32(numberOfIndexes)))
        if usedIndexes.contains(index) {
            return returnUnusedIndex(numberOfIndexes: numberOfIndexes, usedIndexes: usedIndexes)
        }
        return index
    }
    
}
