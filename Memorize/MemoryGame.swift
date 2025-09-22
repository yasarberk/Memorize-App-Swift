//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Berk Yaşar on 19.09.2025.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable{
    private(set) var cards: Array<Card>
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        // add numberOfPairsOfCards x 2 cards
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(id: "\(pairIndex + 1)a", content: content))
            cards.append(Card(id: "\(pairIndex + 1) b", content: content))
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
        print(cards)
    }
    
    mutating func choose(_ card: Card) {
        let chosenindex = index(of: card)
        cards[chosenindex].isFaceUp.toggle()
    }
    
    func index(of card: Card) -> Int {
        for index in cards.indices {
            if cards[index].id == card.id {
                return index
            }
        }
        return 0 // FIXME: fake
    }
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var id: String
        
        var isFaceUp = true
        var isMatched = false
        var content: CardContent
        
        var debugDescription: String {
            "\(id): \(content) \(isFaceUp ? "face up" : "face down") \(isMatched ? "matched" : "unmatched")"
        }
    }
}
