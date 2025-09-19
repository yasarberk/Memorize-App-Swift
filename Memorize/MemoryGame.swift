//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Berk Yaşar on 19.09.2025.
//

import Foundation

struct MemoryGame<CardContent> {
    var cards: Array<Card>
    
    func choose(card: Card) {
        
    }
    
    struct Card {
        var isFaceUp: Bool
        var isMatched: Bool
        var content: CardContent
    }
}
