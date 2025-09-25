//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Berk Yaşar on 19.09.2025.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card]

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

    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { return cards.indices.filter { index in cards[index].isFaceUp }.only }
        set { cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) }}
    }

    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    if cards[chosenIndex].content
                        == cards[potentialMatchIndex].content
                    {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                    }
                } else {
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
        }
    }

    private func index(of card: Card) -> Int? {
        for index in cards.indices {
            if cards[index].id == card.id {
                return index
            }
        }
        return nil
    }

    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var id: String

        var isFaceUp = false
        var isMatched = false
        var content: CardContent

        var debugDescription: String {
            "\(id): \(content) \(isFaceUp ? "face up" : "face down") \(isMatched ? "matched" : "unmatched")"
        }
    }
}

extension Array {
    var only:Element? {
        return count == 1 ? first: nil
    }
}
