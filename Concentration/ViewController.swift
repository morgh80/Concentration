//
//  ViewController.swift
//  Concentration
//
//  Created by aeronaut on 21.12.2017.
//  Copyright © 2017 aeronaut. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count / 2))
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet weak var scoreCountLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]!
    @IBAction func playAgain(_ sender: UIButton) {
        game = Concentration(numberOfPairsOfCards: (cardButtons.count / 2))
        emojiChoices = createEmojiSet()
        updateViewFromModel()
    }
    
    private func createEmojiSet() -> [String] {
        let simsSet = ["🧛‍♂️", "👩‍✈️", "🎅", "👩‍🍳", "👩‍💻", "👸", "🧟‍♂️"]
        let animalSet = ["🐙", "🦋", "🐥", "🦍", "🐒", "🦀", "🦈"]
        let sportSet =  ["🏌️‍♀️", "⚽️", "🏋️‍♀️", "🧗‍♂️", "🤺", "⛷", "🚴‍♂️"]
        let facesSet = ["🤒", "😎", "🤨", "🤡", "😈", "😯", "🤠"]
        let vehiclesSet = ["✈️", "🚁", "🚘", "🛵", "🚤", "🚠", "🚌"]
        let veggiSet = ["🍋", "🌽", "🥦", "🍒", "🍇", "🍏", "🍓"]
        let emojiChoiceSet = [simsSet, animalSet, sportSet, facesSet, vehiclesSet, veggiSet]
        
        return emojiChoiceSet[emojiChoiceSet.count.arc4random]
    }
    
    private lazy var emojiChoices = createEmojiSet()
 
        @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.choseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
        scoreCountLabel.text = "Score: \(game.scoreCount)"
        flipCountLabel.text = "Flips: \(game.flipCount)"
    }
    
    private var emoji = [Card:String]()
    
    private func emoji(for card: Card ) -> String {
        if(emoji[card] == nil), emojiChoices.count > 0 {
            emoji[card] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        return emoji[card] ?? "?"
    }
    
}

extension Int {
    
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
    
}
