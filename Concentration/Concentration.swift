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
    
    var cards = Array<Card>() // [Card]()
    
    var indexOfOneAndOlnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
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
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOlnlyFaceUpCard = index
            }
        }
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
