"
Contains all the different cards of the game. Draw method returns card at the top of the deck
"
Class {
	#name : 'CardDeck',
	#superclass : 'Object',
	#instVars : [
		'cards'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'adding' }
CardDeck >> addCard: aCard [
	cards add: aCard
]

{ #category : 'drawing' }
CardDeck >> draw [
	(cards isEmpty) ifFalse: [^cards removeLast].
	self generateRandomCards: 20.
	^cards removeLast 
]

{ #category : 'adding' }
CardDeck >> generateRandomCards: aNumberOfCards [
	 1 to: aNumberOfCards do: [:i | cards add: self randomCard ].
]

{ #category : 'initialization' }
CardDeck >> initialize [
	cards := OrderedCollection new.
]

{ #category : 'adding' }
CardDeck >> randomCard [
	| r |
    r := Random new next.

    (r < 0.17) ifTrue: [ ^ Acceleration new ].
    (r < 0.34) ifTrue: [ ^ Ally new ].
    (r < 0.51) ifTrue: [ ^ Overload new ].
    (r < 0.68) ifTrue: [ ^ Cancellation new ].
    (r < 0.84) ifTrue: [ ^ Repeat new ].
    ^ Redo new.
]
